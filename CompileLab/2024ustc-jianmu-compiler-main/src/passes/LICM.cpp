#include "BasicBlock.hpp"
#include "Constant.hpp"
#include "Function.hpp"
#include "GlobalVariable.hpp"
#include "Instruction.hpp"
#include "LICM.hpp"
#include "PassManager.hpp"
#include <algorithm>
#include <cstddef>
#include <memory>
#include <vector>

/**
 * @brief 循环不变式外提Pass的主入口函数
 * 
 */
void LoopInvariantCodeMotion::run() {

    loop_detection_ = std::make_unique<LoopDetection>(m_);
    loop_detection_->run();
    func_info_ = std::make_unique<FuncInfo>(m_);
    func_info_->run();
    for (auto &loop : loop_detection_->get_loops()) {
        is_loop_done_[loop] = false;
    }

    for (auto &loop : loop_detection_->get_loops()) {
        traverse_loop(loop);
    }
}

/**
 * @brief 遍历循环及其子循环
 * @param loop 当前要处理的循环
 * 
 */
void LoopInvariantCodeMotion::traverse_loop(std::shared_ptr<Loop> loop) {
    if (is_loop_done_[loop]) {
        return;
    }
    is_loop_done_[loop] = true;
    for (auto &sub_loop : loop->get_sub_loops()) {
        traverse_loop(sub_loop);
    }
    run_on_loop(loop);
}

// TODO: 实现collect_loop_info函数
// 1. 遍历当前循环及其子循环的所有指令
// 2. 收集所有指令到loop_instructions中
// 3. 检查store指令是否修改了全局变量，如果是则添加到updated_global中
// 4. 检查是否包含非纯函数调用，如果有则设置contains_impure_call为true
void LoopInvariantCodeMotion::collect_loop_info(
    std::shared_ptr<Loop> loop,
    std::set<Value *> &loop_instructions,
    std::set<Value *> &updated_global,
    bool &contains_impure_call) {
        for(auto &block : loop->get_blocks()){
            for(auto &instr : block->get_instructions()){
                loop_instructions.insert(&instr);
                if(instr.is_store()){
                    // store 指令哪个是地址
                    auto storeInst = static_cast<StoreInst*>(&instr);
                    if(storeInst->get_operand(1)->is<GlobalVariable>()){
                        updated_global.insert(storeInst->get_operand(1));
                    }
                }
                // 判断是否包含非纯函数调用，如何判断
                // 1. 只依赖输入，相同输入产生相同输出
                // 2. 没有任何副作用的函数
                else if(instr.is_call()){
                    auto callInst = static_cast<CallInst*>(&instr);
                    if(!func_info_->is_pure_function(callInst->get_function())){
                        contains_impure_call = true;
                    }

                }
            }
        }
    // throw std::runtime_error("Lab4: 你有一个TODO需要完成！");
}

/**
 * @brief 对单个循环执行不变式外提优化
 * @param loop 要优化的循环
 * 
 */
void LoopInvariantCodeMotion::run_on_loop(std::shared_ptr<Loop> loop) {
    std::set<Value *> loop_instructions;
    std::set<Value *> updated_global;
    bool contains_impure_call = false;
    collect_loop_info(loop, loop_instructions, updated_global, contains_impure_call);

    std::vector<Value *> loop_invariant;


    // TODO: 识别循环不变式指令
    //
    // - 如果指令已被标记为不变式则跳过
    // - 跳过 store、ret、br、phi 等指令与非纯函数调用
    // - 特殊处理全局变量的 load 指令
    // - 检查指令的所有操作数是否都是循环不变的
    // - 如果有新的不变式被添加则注意更新 changed 标志，继续迭代
    // 先遍历，找到所有的循环内部的变量？
    bool changed;
    do {
        // 操作数不是循环不变的，则所有操作数要么是常量，要么是之前已标记为不变的指令的结果
        // 要么是常量，要么是循环外部的变量
        changed = false;
        for(auto &inst : loop_instructions){
            if(std::count(loop_invariant.begin(), loop_invariant.end(), inst) == 0){
                bool operands_are_invariant = true;
                auto instruction = static_cast<Instruction*>(inst);
                if(instruction->is_store() || instruction->is_ret() || instruction->is_br() || instruction->is_phi()){
                    continue;
                }
                // 处理非纯函数调用
                if(instruction->is_call() && !func_info_->is_pure_function(instruction->get_function())){
                    continue;
                }
                // 如何处理load
                if(instruction->is_load()){
                    auto addr = instruction->get_operand(0);
                    if(addr->is<GlobalVariable>() && updated_global.find(addr) == updated_global.end()){
                        loop_invariant.push_back(instruction);
                    }
                }
                // 判断操作数是不是循环变量
                for(auto& op : instruction ->get_operands()){
                    // op是常数
                    if(!op->is<Instruction>()){
                        continue;
                    }
                    if(std::count(loop_invariant.begin(), loop_invariant.end(), op) != 0){
                        continue;
                    }
                    if(updated_global.find(op) != updated_global.end()){
                        operands_are_invariant = false;
                        break;
                    }
                    auto instr = op->as<Instruction>();
                    // 判断该操作数是不是在循环中被实现，是不是外部操作数
                    if(loop_instructions.find(instr) == loop_instructions.end()){
                        continue;
                    }
                    operands_are_invariant = false;
                    break;
                }
                if(operands_are_invariant){
                    loop_invariant.push_back(instruction);
                    changed=true;
                }
            }
        }
    } while (changed);
    // 创建preheader
    if (loop->get_preheader() == nullptr) {
        loop->set_preheader(
            BasicBlock::create(m_, "", loop->get_header()->get_parent()));
    }

    if (loop_invariant.empty())
        return;

    // insert preheader
    auto preheader = loop->get_preheader();

    // TODO: 更新 phi 指令
    for (auto &phi_inst_ : loop->get_header()->get_instructions()) {
        if (phi_inst_.get_instr_type() != Instruction::phi)
            break;
        // 转化为phiInst
        auto phiInst = static_cast<PhiInst *>(&phi_inst_);
        // 获取pairs
        auto phi_pairs = phiInst->get_phi_pairs();
        std::vector<std::pair<Value *, BasicBlock *>> in_pair, out_pair;        
        for(auto pair : phi_pairs){
            // 判断一个pair是来自内部还是循环外，循环内则保留，循环外提取到preheader
            // 用两个集合表示两种pair
            if(loop->get_latches().find(pair.second) == loop->get_latches().end()){
                out_pair.push_back(pair);
            }
            else{
                in_pair.push_back(pair);
            }
        }
        // 全部来自外部，则提取到preheader里，
        if(in_pair.size() == 0){
            // preheader->add_instr_begin(&phi_inst_);
            // phi_inst_.replace_all_use_with(out_pair[0].first);
            phi_inst_.get_parent()->remove_instr(&phi_inst_);
            preheader->add_instr_begin(&phi_inst_);
            phi_inst_.set_parent(preheader);
            // preheader->add_instr_begin(&phi_inst_);
            // 内部没有phi，把变量改为phi指令的值 
            continue;
        }
        // 不变
        if(out_pair.size() == 0){
            continue;
        }
        // 如何处理一部分的情况？
        // 将来自外部的pair替换成来自preheader
        auto outPhi = PhiInst::create_phi(phi_inst_.get_type(), preheader);
        for(auto out: out_pair){
            outPhi->add_phi_pair_operand(out.first, out.second);
        }
        for(auto out: out_pair){
            phiInst->remove_phi_operand(out.second);
        }
        phiInst->add_phi_pair_operand(outPhi, preheader);
        outPhi->set_parent(preheader);
        preheader->add_instr_begin(outPhi);
    }

    // TODO: 用跳转指令重构控制流图 
    // 将所有非 latch 的 header 前驱块的跳转指向 preheader
    // 并将 preheader 的跳转指向 header
    // 注意这里需要更新前驱块的后继和后继的前驱
    std::vector<BasicBlock *> pred_to_remove;
    for (auto &pred : loop->get_header()->get_pre_basic_blocks()) {
        // 非latch， 说明这个前驱块不是header的后继
        if(loop->get_latches().find(pred) != loop->get_latches().end()){
            continue;
        }
        // 若是非latch，更改后继为preheader
        pred->remove_succ_basic_block(loop->get_header());
        // 要把所有的br指令替换掉
        auto terminator = pred->get_terminator();
        pred->remove_instr(terminator);
        // pred.
        BranchInst::create_br(preheader, pred);
        pred_to_remove.push_back(pred);
    }
    // header 和 preheader 只需要添加一次
    for (auto &pred : pred_to_remove) {
        loop->get_header()->remove_pre_basic_block(pred);
    }

    // TODO: 外提循环不变指令
    Instruction *termi;
    if(preheader->is_terminated()){
        termi = preheader->get_terminator();
        preheader->remove_instr(termi);
    }
    for(auto &inst : loop_invariant){
        auto Inst = static_cast<Instruction *>(inst);
        // 获取指令对应的块
        auto block = Inst->get_parent();
        block->remove_instr(Inst);
        preheader->add_instruction(Inst);
        
    }

    // insert preheader br to header
    BranchInst::create_br(loop->get_header(), preheader);

    // insert preheader to parent loop
    if (loop->get_parent() != nullptr) {
        loop->get_parent()->add_block(preheader);
    }
}

