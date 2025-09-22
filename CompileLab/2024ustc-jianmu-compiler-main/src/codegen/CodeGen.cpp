#include "CodeGen.hpp"

#include "ASMInstruction.hpp"
#include "BasicBlock.hpp"
#include "CodeGenUtil.hpp"
#include "Function.hpp"
#include "Instruction.hpp"
#include "Register.hpp"
#include "Type.hpp"
#include <string>
#include <system_error>

void CodeGen::allocate() {
    // 备份 $ra $fp
    unsigned offset = PROLOGUE_OFFSET_BASE;

    // 为每个参数分配栈空间
    for (auto &arg : context.func->get_args()) {
        auto size = arg.get_type()->get_size();
        offset = offset + size;
        context.offset_map[&arg] = -static_cast<int>(offset);
    }

    // 为指令结果分配栈空间
    for (auto &bb : context.func->get_basic_blocks()) {
        for (auto &instr : bb.get_instructions()) {
            // 每个非 void 的定值都分配栈空间
            if (not instr.is_void()) {
                auto size = instr.get_type()->get_size();
                offset = offset + size;
                context.offset_map[&instr] = -static_cast<int>(offset);
            }
            // alloca 的副作用：分配额外空间
            if (instr.is_alloca()) {
                auto *alloca_inst = static_cast<AllocaInst *>(&instr);
                auto alloc_size = alloca_inst->get_alloca_type()->get_size();
                offset += alloc_size;
            }
        }
    }

    // 分配栈空间，需要是 16 的整数倍
    context.frame_size = ALIGN(offset, PROLOGUE_ALIGN);
}

void CodeGen::copy_stmt() {
    for (auto &succ : context.bb->get_succ_basic_blocks()) {
        for (auto &inst : succ->get_instructions()) {
            if (inst.is_phi()) {
                // 遍历后继块中 phi 的定值 bb
                for (unsigned i = 1; i < inst.get_operands().size(); i += 2) {
                    // phi 的定值 bb 是当前翻译块
                    if (inst.get_operand(i) == context.bb) {
                        auto *lvalue = inst.get_operand(i - 1);
                        if (lvalue->get_type()->is_float_type()) {
                            load_to_freg(lvalue, FReg::fa(0));
                            store_from_freg(&inst, FReg::fa(0));
                        } else {
                            load_to_greg(lvalue, Reg::a(0));
                            store_from_greg(&inst, Reg::a(0));
                        }
                        break;
                    }
                    // 如果没有找到当前翻译块，说明是 undef，无事可做
                }
            } else {
                break;
            }
        }
    }
}

void CodeGen::load_to_greg(Value *val, const Reg &reg) {
    assert(val->get_type()->is_integer_type() ||
           val->get_type()->is_pointer_type());

    if (auto *constant = dynamic_cast<ConstantInt *>(val)) {
        int32_t val = constant->get_value();
        if (IS_IMM_12(val)) {
            append_inst(ADDI WORD, {reg.print(), "$zero", std::to_string(val)});
        } else {
            load_large_int32(val, reg);
        }
    } else if (auto *global = dynamic_cast<GlobalVariable *>(val)) {
        append_inst(LOAD_ADDR, {reg.print(), global->get_name()});
    } else {
        load_from_stack_to_greg(val, reg);
    }
}

void CodeGen::load_large_int32(int32_t val, const Reg &reg) {
    int32_t high_20 = val >> 12; // si20
    uint32_t low_12 = val & LOW_12_MASK;
    append_inst(LU12I_W, {reg.print(), std::to_string(high_20)});
    append_inst(ORI, {reg.print(), reg.print(), std::to_string(low_12)});
}

void CodeGen::load_large_int64(int64_t val, const Reg &reg) {
    auto low_32 = static_cast<int32_t>(val & LOW_32_MASK);
    load_large_int32(low_32, reg);

    auto high_32 = static_cast<int32_t>(val >> 32);
    int32_t high_32_low_20 = (high_32 << 12) >> 12; // si20
    int32_t high_32_high_12 = high_32 >> 20;        // si12
    append_inst(LU32I_D, {reg.print(), std::to_string(high_32_low_20)});
    append_inst(LU52I_D,
                {reg.print(), reg.print(), std::to_string(high_32_high_12)});
}

void CodeGen::load_from_stack_to_greg(Value *val, const Reg &reg) {
    auto offset = context.offset_map.at(val);
    auto offset_str = std::to_string(offset);
    auto *type = val->get_type();
    if (IS_IMM_12(offset)) {
        if (type->is_int1_type()) {
            append_inst(LOAD BYTE, {reg.print(), "$fp", offset_str});
        } else if (type->is_int32_type()) {
            append_inst(LOAD WORD, {reg.print(), "$fp", offset_str});
        } else { // Pointer
            append_inst(LOAD DOUBLE, {reg.print(), "$fp", offset_str});
        }
    } else {
        load_large_int64(offset, reg);
        append_inst(ADD DOUBLE, {reg.print(), "$fp", reg.print()});
        if (type->is_int1_type()) {
            append_inst(LOAD BYTE, {reg.print(), reg.print(), "0"});
        } else if (type->is_int32_type()) {
            append_inst(LOAD WORD, {reg.print(), reg.print(), "0"});
        } else { // Pointer
            append_inst(LOAD DOUBLE, {reg.print(), reg.print(), "0"});
        }
    }
}

void CodeGen::store_from_greg(Value *val, const Reg &reg) {
    auto offset = context.offset_map.at(val);
    auto offset_str = std::to_string(offset);
    auto *type = val->get_type();
    if (IS_IMM_12(offset)) {
        if (type->is_int1_type()) {
            append_inst(STORE BYTE, {reg.print(), "$fp", offset_str});
        } else if (type->is_int32_type()) {
            append_inst(STORE WORD, {reg.print(), "$fp", offset_str});
        } else { // Pointer
            append_inst(STORE DOUBLE, {reg.print(), "$fp", offset_str});
        }
    } else {
        auto addr = Reg::t(8);
        load_large_int64(offset, addr);
        append_inst(ADD DOUBLE, {addr.print(), "$fp", addr.print()});
        if (type->is_int1_type()) {
            append_inst(STORE BYTE, {reg.print(), addr.print(), "0"});
        } else if (type->is_int32_type()) {
            append_inst(STORE WORD, {reg.print(), addr.print(), "0"});
        } else { // Pointer
            append_inst(STORE DOUBLE, {reg.print(), addr.print(), "0"});
        }
    }
}

void CodeGen::load_to_freg(Value *val, const FReg &freg) {
    assert(val->get_type()->is_float_type());
    if (auto *constant = dynamic_cast<ConstantFP *>(val)) {
        float val = constant->get_value();
        load_float_imm(val, freg);
    } else {
        auto offset = context.offset_map.at(val);
        auto offset_str = std::to_string(offset);
        if (IS_IMM_12(offset)) {
            append_inst(FLOAD SINGLE, {freg.print(), "$fp", offset_str});
        } else {
            auto addr = Reg::t(8);
            load_large_int64(offset, addr);
            append_inst(ADD DOUBLE, {addr.print(), "$fp", addr.print()});
            append_inst(FLOAD SINGLE, {freg.print(), addr.print(), "0"});
        }
    }
}

void CodeGen::load_float_imm(float val, const FReg &r) {
    int32_t bytes = *reinterpret_cast<int32_t *>(&val);
    load_large_int32(bytes, Reg::t(8));
    append_inst(GR2FR WORD, {r.print(), Reg::t(8).print()});
}

void CodeGen::store_from_freg(Value *val, const FReg &r) {
    auto offset = context.offset_map.at(val);
    if (IS_IMM_12(offset)) {
        auto offset_str = std::to_string(offset);
        append_inst(FSTORE SINGLE, {r.print(), "$fp", offset_str});
    } else {
        auto addr = Reg::t(8);
        load_large_int64(offset, addr);
        append_inst(ADD DOUBLE, {addr.print(), "$fp", addr.print()});
        append_inst(FSTORE SINGLE, {r.print(), addr.print(), "0"});
    }
}

void CodeGen::gen_prologue() {
    if (IS_IMM_12(-static_cast<int>(context.frame_size))) {
        append_inst("st.d $ra, $sp, -8");
        append_inst("st.d $fp, $sp, -16");
        append_inst("addi.d $fp, $sp, 0");
        append_inst("addi.d $sp, $sp, " +
                    std::to_string(-static_cast<int>(context.frame_size)));
    } else {
        load_large_int64(context.frame_size, Reg::t(0));
        append_inst("st.d $ra, $sp, -8");
        append_inst("st.d $fp, $sp, -16");
        append_inst("sub.d $sp, $sp, $t0");
        append_inst("add.d $fp, $sp, $t0");
    }

    int garg_cnt = 0;
    int farg_cnt = 0;
    for (auto &arg : context.func->get_args()) {
        if (arg.get_type()->is_float_type()) {
            store_from_freg(&arg, FReg::fa(farg_cnt++));
        } else { // int or pointer
            store_from_greg(&arg, Reg::a(garg_cnt++));
        }
    }
}

void CodeGen::gen_epilogue() {
    // TODO 根据你的理解设定函数的 epilogue
    append_inst(context.func->get_name()+"_exit", ASMInstruction::Label);
    if (IS_IMM_12(-static_cast<int>(context.frame_size))){
        append_inst("addi.d $sp, $sp, " + std::to_string(static_cast<int>(context.frame_size)));
        append_inst("ld.d $ra, $sp, -8");
        append_inst("ld.d $fp, $sp, -16");
        append_inst("jr $ra");
    }
    else{
        load_large_int64(context.frame_size, Reg::t(0));
        append_inst("add.d $sp, $sp, $t0");
        append_inst("ld.d $ra, $sp, -8");
        append_inst("ld.d $fp, $sp, -16");
        append_inst("jr $ra");
    }
    // throw not_implemented_error{__FUNCTION__};
}


void CodeGen::gen_ret() {
    // TODO 函数返回，思考如何处理返回值、寄存器备份，如何返回调用者地址
    auto *retInst = 
    static_cast<ReturnInst *>(context.inst);
    auto *retType = context.func->get_return_type();
    // retInst.g
    // auto *retType = static_cast<Type *>( retInst->get_type());
    // 加载返回地址，跳转返回位置
    if(retType->is_void_type()){
        append_inst("addi.w  $a0, $zero, 0");
    }
    else if (retType->is_float_type()) {
        load_to_freg(retInst->get_operand(0), FReg::fa(0));
        // store_from_freg(context.inst, FReg::fa(0));
    }
    else {
        load_to_greg(retInst->get_operand(0), Reg::a(0));
        // store_from_greg(context.inst, Reg::a(0));
    }
    // 跳转
    std::string label = context.func->get_name()+"_exit";
    append_inst("b " + label);
}

void CodeGen::gen_br() {
    auto *branchInst = static_cast<BranchInst *>(context.inst);
    if (branchInst->is_cond_br()) {
        // TODO 补全条件跳转的情况
        // 只有一种br操作
        // auto op = branchInst->get_instr_type();
        // switch (op) {
        // case 
        // }
        // br i1 <cond>, label <iftrue>, label <iffalse>
        // load condition
        load_to_greg(branchInst->get_operand(0), Reg::t(0));
        auto *trueBB =static_cast<BasicBlock *>( branchInst->get_operand(1));
        auto *falseBB = static_cast<BasicBlock *>(branchInst->get_operand(2));
        // 如果不等于0则跳转到trueBB
        append_inst("bnez", {Reg::t(0).print(), label_name(trueBB)});
        //未跳转，直接跳转至falseBB
        append_inst("b",{label_name(falseBB)});
        // throw not_implemented_error{__FUNCTION__};
    } else {
        auto *branchbb = static_cast<BasicBlock *>(branchInst->get_operand(0));
        append_inst("b " + label_name(branchbb));
    }
}

void CodeGen::gen_binary() {
    load_to_greg(context.inst->get_operand(0), Reg::t(0));
    load_to_greg(context.inst->get_operand(1), Reg::t(1));
    switch (context.inst->get_instr_type()) {
    case Instruction::add:
        output.emplace_back("add.w $t2, $t0, $t1");
        break;
    case Instruction::sub:
        output.emplace_back("sub.w $t2, $t0, $t1");
        break;
    case Instruction::mul:
        output.emplace_back("mul.w $t2, $t0, $t1");
        break;
    case Instruction::sdiv:
        output.emplace_back("div.w $t2, $t0, $t1");
        break;
    default:
        assert(false);
    }
    store_from_greg(context.inst, Reg::t(2));
}

void CodeGen::gen_float_binary() {
    // TODO 浮点类型的二元指令
    auto *floatInst = static_cast<FBinaryInst*>(context.inst);
    floatInst->get_operand(0);
    auto op = floatInst->get_instr_type();
    auto firstNum = floatInst->get_operand(0);
    load_to_freg(firstNum, FReg::ft(1));
    auto secondNum = floatInst->get_operand(1);
    load_to_freg(secondNum, FReg::ft(2));
    switch(op){
        case Instruction::fadd:
            append_inst("fadd.s", {FReg::ft(0).print(),FReg::ft(1).print(), FReg::ft(2).print()});
            break;
        case Instruction::fsub:
            append_inst("fsub.s", {FReg::ft(0).print(),FReg::ft(1).print(), FReg::ft(2).print()});
            break;
        case Instruction::fmul:
            append_inst("fmul.s", {FReg::ft(0).print(),FReg::ft(1).print(), FReg::ft(2).print()});
            break;
        case Instruction::fdiv:
            append_inst("fdiv.s", {FReg::ft(0).print(),FReg::ft(1).print(), FReg::ft(2).print()});
            break;
        default:
            std::cout << "wrong gen_float_binary" << std::endl;
            break;
    }
    store_from_freg(context.inst, FReg::ft(0));
    // throw not_implemented_error{__FUNCTION__};
}

void CodeGen::gen_alloca() {
    /* 我们已经为 alloca 的内容分配空间，在此我们还需保存 alloca
     * 指令自身产生的定值，即指向 alloca 空间起始地址的指针
     */
    // TODO 将 alloca 出空间的起始地址保存在栈帧上
    auto *allocaInst = static_cast<AllocaInst*>(context.inst);
    // offset保存的是allocaInst->get_type()->get_size();即指针偏移
    auto offset = context.offset_map[allocaInst];
    auto trueOffset = offset - int(allocaInst->get_alloca_type()->get_size());
    // 求出基地址
    // auto baseOffset = offset;
    append_inst("addi.d", {Reg::t(0).print(),"$fp", std::to_string(trueOffset)});
    store_from_greg(allocaInst, Reg::t(0));
    // append_inst("st.d",{Reg::t(0).print(), "$fp", std::to_string(trueOffset)});
    // throw not_implemented_error{__FUNCTION__};
}

void CodeGen::gen_load() {
    auto *ptr = context.inst->get_operand(0);
    auto *type = context.inst->get_type();
    load_to_greg(ptr, Reg::t(0));

    if (type->is_float_type()) {
        append_inst("fld.s $ft0, $t0, 0");
        store_from_freg(context.inst, FReg::ft(0));
    } else if(type->is_int32_type()){
        // TODO load 整数类型的数据
        append_inst("ld.w $t0, $t0, 0");
        store_from_greg(context.inst, Reg::t(0));
        // throw not_implemented_error{__FUNCTION__};
    }
    else if(type->is_int1_type()){
        append_inst("ld.b $t0, $t0, 0");
        store_from_greg(context.inst, Reg::t(0));
    }
    else{
        append_inst("ld.d $t0, $t0, 0");
        store_from_greg(context.inst, Reg::t(0));
    }
}

void CodeGen::gen_store() {
    // TODO 翻译 store 指令
    auto *storeInst = static_cast<StoreInst*>(context.inst);
    // operand 0
    auto addr = storeInst->get_operand(1);
    // operand 1
    auto value = storeInst->get_operand(0);
    load_to_greg(addr, Reg::t(0));
    if(value->get_type()->is_float_type()){
        load_to_freg(value, FReg::ft(0));
        append_inst("fst.s $ft0, $t0, 0");
    }
    else if(value->get_type()->is_int32_type()){
        load_to_greg(value, Reg::t(1));
        append_inst("st.w $t1, $t0, 0");
    }
    else if(value->get_type()->is_int1_type()){
        load_to_greg(value, Reg::t(1));
        append_inst("st.b $t1, $t0, 0");
    }
    else{
        load_to_greg(value, Reg::t(1));
        append_inst("st.d $t1, $t0, 0");
    }
    
    // throw not_implemented_error{__FUNCTION__};
}

void CodeGen::gen_icmp() {
    // TODO 处理各种整数比较的情况
    auto *icmpInst = static_cast<ICmpInst*>(context.inst);
    auto op = icmpInst->get_instr_type();
    // auto firstNum = 
    load_to_greg(icmpInst->get_operand(0), Reg::t(0));
    load_to_greg(icmpInst->get_operand(1), Reg::t(1));
    switch (op) {
        case Instruction::ge:
        // t0 < t1 = 1, 实际上应该为t0 >= t1 = 1
            append_inst("slt $t0, $t0, $t1");
            append_inst("addi.d $t1, $zero, 1");
            append_inst("xor $t0, $t0, $t1");
            break;
        case Instruction::gt:
            append_inst("slt $t0, $t1, $t0");
            break;
        case Instruction::le:
        //t0 <= t1 为 t0 > t1的反
            append_inst("slt $t0, $t1, $t0");
            append_inst("addi.d $t1, $zero, 1");
            append_inst("xor $t0, $t0, $t1");
            break;
        case Instruction::lt:
            append_inst("slt $t0, $t0, $t1");
            break;
        case Instruction::eq:
        //eq则t0=0
            append_inst("xor $t0, $t0, $t1");
            // 0 < t0 则为1，意味着不相等
            append_inst("sltu $t0, $zero, $t0");
            append_inst("addi.d $t1, $zero, 1");
            append_inst("xor $t0, $t0, $t1");
            break;
        case Instruction::ne:
            append_inst("xor $t0, $t0, $t1");
            // 0 < t0 则为1，意味着不相等
            append_inst("sltu $t0, $zero, $t0");
            break;
        default:
            std::cout << "wrong icmp" << std::endl;
            break;
    }
    store_from_greg(icmpInst, Reg::t(0));
    // throw not_implemented_error{__FUNCTION__};
}
// 是不是应该把结果存入内存
void CodeGen::gen_fcmp() {
    // TODO 处理各种浮点数比较的情况
    auto *fcmpInst = static_cast<FCmpInst*>(context.inst);
    auto op = fcmpInst->get_instr_type();
    // auto firstNum = 
    load_to_freg(fcmpInst->get_operand(0), FReg::ft(0));
    load_to_freg(fcmpInst->get_operand(1), FReg::ft(1));
    switch (op) {
        case Instruction::fge:
        // t0 < t1 = 1, 实际上应该为t0 >= t1 = 1
            append_inst("fcmp.sle.s $fcc0, $ft1, $ft0");
            break;
        case Instruction::fgt:
            append_inst("fcmp.slt.s $fcc0, $ft1, $ft0");
            break;
        case Instruction::fle:
            append_inst("fcmp.sle.s $fcc0, $ft0, $ft1");
            break;
        case Instruction::flt:
            append_inst("fcmp.slt.s $fcc0, $ft0, $ft1");      
            break;
        case Instruction::feq:
            append_inst("fcmp.seq.s $fcc0, $ft0, $ft1");
            break;
        case Instruction::fne:
            append_inst("fcmp.sne.s $fcc0, $ft0, $ft1");
            break;
        default:
            std::cout << "wrong fcmp" << std::endl;
            break;
        append_inst("bcnez", {"$fcc0","true" + std::to_string(context.br_num)});
        append_inst("addi.d $t0, $zero, 0");
        append_inst("b",{"exit"+std::to_string(context.br_num)});
        append_inst("true"+std::to_string(context.br_num),ASMInstruction::Label);
        append_inst("addi.d $t0, $zero, 1");
        append_inst("exit"+std::to_string(context.br_num),ASMInstruction::Label);
        context.br_num++;
        store_from_greg(context.inst, Reg::t(0));
    }
    // throw not_implemented_error{__FUNCTION__};
}

void CodeGen::gen_zext() {
    // TODO 将窄位宽的整数数据进行零扩展
    // zext <type> <value> to <type2>
    auto *zextInst = static_cast<ZextInst*>(context.inst);
    load_to_greg(zextInst->get_operand(0), Reg::t(0));
    // 最低8位，因为ld.b
    append_inst("bstrpick.w $t0, $t0, 7, 0");
    // 目标类型
    // auto destType = zextInst->get_dest_type()
    // // 待转化类型
    // auto type = zextInst->get_operand(0)->get_type();
    // if(type->is_int1_type()){
    //     if(destType->is_int32_type()){
    //         append_inst("bstrpick.w $t0, $t0, 7, 0");
    //     }
    //     else{
    //         std::cout << "error zext" << std::endl;
    //     }
    // }
    // else if (type->is_integer_type()) {
    // statements
    // }
    store_from_greg(context.inst, Reg::t(0));
    // throw not_implemented_error{__FUNCTION__};
}

void CodeGen::gen_call() {
    // TODO 函数调用，注意我们只需要通过寄存器传递参数，即不需考虑栈上传参的情况
    auto *callInst = static_cast<CallInst*>(context.inst);
    // 获取函数类型
    auto *functionType = static_cast<FunctionType*>(callInst->get_function_type());
    auto argsNum = functionType->get_num_of_args();
    //获取函数
    // 将参数传入寄存器
    // 按照类型划分
    unsigned int j = 0;
    unsigned int k = 0;
    for(int i = 0; i < argsNum; i++){
        if(functionType->get_param_type(i)->is_int32_type()){
            load_to_greg(callInst->get_operand(i+1), Reg::a(j));
            j++;
        }
        else if(functionType->get_param_type(i)->is_int1_type()){
            load_to_greg(callInst->get_operand(i+1), Reg::a(j));
            j++;
        }
        else if(functionType->get_param_type(i)->is_float_type()){
            load_to_freg(callInst->get_operand(i+1), FReg::fa(k));
            k++;
        }
        else{
            load_to_greg(callInst->get_operand(i+1), Reg::a(j));
            j++;
        }
    }
    // 调用函数，跳转
    auto *bb = static_cast<BasicBlock*>(callInst->get_operand(0));
    append_inst("bl",{bb->get_name()});
    // 存储返回值
    auto retType = functionType->get_return_type();
    if(retType->is_integer_type()){
        store_from_greg(context.inst, Reg::a(0));
    }
    else if(retType->is_float_type()){
        store_from_freg(context.inst, FReg::fa(0));
    }
    // throw not_implemented_error{__FUNCTION__};
}

/*
 * %op = getelementptr [10 x i32], [10 x i32]* %op, i32 0, i32 %op
 * %op = getelementptr        i32,        i32* %op, i32 %op
 *
 * Memory layout
 *       -            ^
 * +-----------+      | Smaller address
 * |  arg ptr  |---+  |
 * +-----------+   |  |
 * |           |   |  |
 * +-----------+   /  |
 * |           |<--   |
 * |           |   \  |
 * |           |   |  |
 * |   Array   |   |  |
 * |           |   |  |
 * |           |   |  |
 * |           |   |  |
 * +-----------+   |  |
 * |  Pointer  |---+  |
 * +-----------+      |
 * |           |      |
 * +-----------+      |
 * |           |      |
 * +-----------+      |
 * |           |      |
 * +-----------+      | Larger address
 *       +
 */
void CodeGen::gen_gep() {
    // TODO 计算内存地址
    // getelementptr <type>, <type>* <ptrval> ,
    // 示例：# %op6 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
    auto *getElementPtrInst = static_cast<GetElementPtrInst*>(context.inst);
    unsigned int num = getElementPtrInst->get_num_operand();
    // auto type = getElementPtrInst->get_operand(0)->get_type();
    load_to_greg(getElementPtrInst->get_operand(0), Reg::t(0));
    //t1是索引
    load_to_greg(getElementPtrInst->get_operand(num-1), Reg::t(1));
    auto elementType = getElementPtrInst->get_element_type();
    append_inst("addi.d $t2, $zero, 4");
    if(elementType->is_float_type()){
        append_inst("mul.d $t1, $t1, $t2");
    }
    else if (elementType->is_int32_type()) {
        append_inst("mul.d $t1, $t1, $t2");
    }
    else if (elementType->is_int1_type()) {

    }
    else{
        append_inst("addi.d $t2, $zero, 8");
        append_inst("mul.d $t1, $t1, $t2");
    }
    append_inst("add.d $t2, $t1, $t0");
    store_from_greg(context.inst, Reg::t(2));

}

void CodeGen::gen_sitofp() {
    // TODO 整数转向浮点数
    auto * sitofpInst = static_cast<SiToFpInst*>(context.inst);
    load_to_greg(sitofpInst->get_operand(0), Reg::t(0));
    append_inst("movgr2fr.w $ft0, $t0");
    append_inst("ffint.s.w $ft1, $ft0");
    store_from_freg(context.inst, FReg::ft(1));
    // throw not_implemented_error{__FUNCTION__};
}

void CodeGen::gen_fptosi() {
    // TODO 浮点数转向整数，注意向下取整(round to zero)
    auto *fptosiInst = static_cast<FpToSiInst*>(context.inst);
    load_to_freg(fptosiInst->get_operand(0), FReg::ft(0));
    append_inst("ftintrz.w.s $ft1, $ft0");
    append_inst("movfr2gr.s $t0, $ft1");
    store_from_greg(context.inst, Reg::t(0));
    // throw not_implemented_error{__FUNCTION__};
}

void CodeGen::run() {
    // 确保每个函数中基本块的名字都被设置好
    m->set_print_name();

    /* 使用 GNU 伪指令为全局变量分配空间
     * 你可以使用 `la.local` 指令将标签 (全局变量) 的地址载入寄存器中, 比如
     * 要将 `a` 的地址载入 $t0, 只需要 `la.local $t0, a`
     */
    if (!m->get_global_variable().empty()) {
        append_inst("Global variables", ASMInstruction::Comment);
        /* 虽然下面两条伪指令可以简化为一条 `.bss` 伪指令, 但是我们还是选择使用
         * `.section` 将全局变量放到可执行文件的 BSS 段, 原因如下:
         * - 尽可能对齐交叉编译器 loongarch64-unknown-linux-gnu-gcc 的行为
         * - 支持更旧版本的 GNU 汇编器, 因为 `.bss` 伪指令是应该相对较新的指令,
         *   GNU 汇编器在 2023 年 2 月的 2.37 版本才将其引入
         */
        append_inst(".text", ASMInstruction::Atrribute);
        append_inst(".section", {".bss", "\"aw\"", "@nobits"},
                    ASMInstruction::Atrribute);
        for (auto &global : m->get_global_variable()) {
            auto size =
                global.get_type()->get_pointer_element_type()->get_size();
            append_inst(".globl", {global.get_name()},
                        ASMInstruction::Atrribute);
            append_inst(".type", {global.get_name(), "@object"},
                        ASMInstruction::Atrribute);
            append_inst(".size", {global.get_name(), std::to_string(size)},
                        ASMInstruction::Atrribute);
            append_inst(global.get_name(), ASMInstruction::Label);
            append_inst(".space", {std::to_string(size)},
                        ASMInstruction::Atrribute);
        }
    }

    // 函数代码段
    output.emplace_back(".text", ASMInstruction::Atrribute);
    for (auto &func : m->get_functions()) {
        if (not func.is_declaration()) {
            // 更新 context
            context.clear();
            context.func = &func;

            // 函数信息
            append_inst(".globl", {func.get_name()}, ASMInstruction::Atrribute);
            append_inst(".type", {func.get_name(), "@function"},
                        ASMInstruction::Atrribute);
            append_inst(func.get_name(), ASMInstruction::Label);

            // 分配函数栈帧
            allocate();
            // 生成 prologue
            gen_prologue();

            for (auto &bb : func.get_basic_blocks()) {
                context.bb = &bb;
                append_inst(label_name(context.bb), ASMInstruction::Label);
                for (auto &instr : bb.get_instructions()) {
                    // For debug
                    append_inst(instr.print(), ASMInstruction::Comment);
                    context.inst = &instr; // 更新 context
                    switch (instr.get_instr_type()) {
                    case Instruction::ret:
                        gen_ret();
                        break;
                    case Instruction::br:
                        copy_stmt();
                        gen_br();
                        break;
                    case Instruction::add:
                    case Instruction::sub:
                    case Instruction::mul:
                    case Instruction::sdiv:
                        gen_binary();
                        break;
                    case Instruction::fadd:
                    case Instruction::fsub:
                    case Instruction::fmul:
                    case Instruction::fdiv:
                        gen_float_binary();
                        break;
                    case Instruction::alloca:
                        /* 对于 alloca 指令，我们已经为 alloca
                         * 的内容分配空间，在此我们还需保存 alloca
                         * 指令自身产生的定值，即指向 alloca 空间起始地址的指针
                         */
                        gen_alloca();
                        break;
                    case Instruction::load:
                        gen_load();
                        break;
                    case Instruction::store:
                        gen_store();
                        break;
                    case Instruction::ge:
                    case Instruction::gt:
                    case Instruction::le:
                    case Instruction::lt:
                    case Instruction::eq:
                    case Instruction::ne:
                        gen_icmp();
                        break;
                    case Instruction::fge:
                    case Instruction::fgt:
                    case Instruction::fle:
                    case Instruction::flt:
                    case Instruction::feq:
                    case Instruction::fne:
                        gen_fcmp();
                        break;
                    case Instruction::phi:
                        /* for phi, just convert to a series of
                         * copy-stmts */
                        /* we can collect all phi and deal them at
                         * the end */
                        break;
                    case Instruction::call:
                        gen_call();
                        break;
                    case Instruction::getelementptr:
                        gen_gep();
                        break;
                    case Instruction::zext:
                        gen_zext();
                        break;
                    case Instruction::fptosi:
                        gen_fptosi();
                        break;
                    case Instruction::sitofp:
                        gen_sitofp();
                        break;
                    }
                }
            }
            // 生成 epilogue
            gen_epilogue();
        }
    }
}

std::string CodeGen::print() const {
    std::string result;
    for (const auto &inst : output) {
        result += inst.format();
    }
    return result;
}
