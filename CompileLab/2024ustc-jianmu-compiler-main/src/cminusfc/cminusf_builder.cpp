#include "cminusf_builder.hpp"
#include "BasicBlock.hpp"
#include "Constant.hpp"
#include "Function.hpp"
#include "GlobalVariable.hpp"
#include "Instruction.hpp"
#include "Type.hpp"
#include "Value.hpp"
#include "ast.hpp"
#include <cstddef>
#include <memory>
#include <string>
#include <vector>

#define CONST_FP(num) ConstantFP::get((float)num, module.get())
#define CONST_INT(num) ConstantInt::get(num, module.get())

// types
Type *VOID_T;
Type *INT1_T;
Type *INT32_T;
Type *INT32PTR_T;
Type *FLOAT_T;
Type *FLOATPTR_T;
/*
 * use CMinusfBuilder::Scope to construct scopes
 * scope.enter: enter a new scope
 * scope.exit: exit current scope
 * scope.push: add a new binding to current scope
 * scope.find: find and return the value bound to the name
 */

Value* CminusfBuilder::visit(ASTProgram &node) {
    VOID_T = module->get_void_type();
    INT1_T = module->get_int1_type();
    INT32_T = module->get_int32_type();
    INT32PTR_T = module->get_int32_ptr_type();
    FLOAT_T = module->get_float_type();
    FLOATPTR_T = module->get_float_ptr_type();

    Value *ret_val = nullptr;
    for (auto &decl : node.declarations) {
        ret_val = decl->accept(*this);  // 到了CminusfBuilder::
    }
    return ret_val;
}

Value* CminusfBuilder::visit(ASTNum &node) {
    // TODO: This function is empty now.
    // Add some code here.
    // 返回数字
    if(node.type == TYPE_INT){
        context.num = node.i_val;
        return CONST_INT(node.i_val);
    }
    else if(node.type == TYPE_FLOAT){
        context.fnum = node.f_val;
        return CONST_FP(node.f_val);
    }
    return nullptr;
}
// 声明变量，返回了变量的地址
Value* CminusfBuilder::visit(ASTVarDeclaration &node) {
    // TODO: This function is empty now.
    // Add some code here.
    Type *var_type;
    if(node.type == TYPE_INT)
        var_type = INT32_T;
    else if(node.type == TYPE_FLOAT)
        var_type = FLOAT_T;
    else
        var_type = VOID_T;
    // 变量名：node.id，
    //判断是否为数组类型
    // 不是数组类型
    if(node.num == nullptr){
        // 说明是全局变量
        if(scope.in_global()){
            auto initializer = ConstantZero::get(var_type, module.get());
            auto idAlloca = GlobalVariable::create(node.id, module.get(), var_type, false, initializer);
            scope.push(node.id, idAlloca);
            return idAlloca;
        }
        else{
            auto idAlloca = builder->create_alloca(var_type);
            scope.push(node.id, idAlloca);
            return idAlloca;
        }
    }
    else{ // 数组类型
    //num 应该调用visit
        node.num->accept(*this);
        auto *arrayType = module.get()->get_array_type(var_type, context.num);
        if(scope.in_global()){
            auto initializer = ConstantZero::get(var_type, module.get());
            auto idAlloca = GlobalVariable::create(node.id, module.get(), arrayType, false, initializer);
            scope.push(node.id, idAlloca);
            return idAlloca;
        }
        else{
            auto idAlloca = builder->create_alloca(arrayType);
            scope.push(node.id, idAlloca);
            return idAlloca;
        }
    }
    return nullptr;
}

Value* CminusfBuilder::visit(ASTFunDeclaration &node) {
    FunctionType *fun_type;
    Type *ret_type;
    std::vector<Type *> param_types;
    // 首先判断返回值类型
    if (node.type == TYPE_INT)
        ret_type = INT32_T;
    else if (node.type == TYPE_FLOAT)
        ret_type = FLOAT_T;
    else
        ret_type = VOID_T;
    // 判断参数
    for (auto &param : node.params) {
        // TODO: Please accomplish param_types.
        param->accept(*this);
        param_types.push_back(context.type);
    }
    context.type = nullptr;
    // 创建一个Function
    fun_type = FunctionType::get(ret_type, param_types);
    auto func = Function::create(fun_type, node.id, module.get());
    //创建一个function类型的变量
    scope.push(node.id, func);
    // context
    context.func = func;
    //进入Function块
    auto funBB = BasicBlock::create(module.get(), "entry", func);
    builder->set_insert_point(funBB);
    // context.bb = funBB;
    //进入一个作用域
    scope.enter();
    std::vector<Value *> args;
    //添加进参数
    for (auto &arg : func->get_args()) {
        args.push_back(&arg);
    }
    for (unsigned int i = 0; i < node.params.size(); ++i) {
        // TODO: You need to deal with params and store them in the scope.
        auto paramAlloca = builder->create_alloca(param_types[i]);
        builder->create_store(args[i], paramAlloca);
        if(param_types[i] == INT32PTR_T || param_types[i] == FLOATPTR_T){  // 得到参数的指针
            scope.push(node.params[i]->id, builder->create_load(paramAlloca));
        }
        else
            scope.push(node.params[i]->id, paramAlloca);
    }
    // 调用复合语句块来处理函数体
    node.compound_stmt->accept(*this);
    if (not builder->get_insert_block()->is_terminated()) 
    {
        if (context.func->get_return_type()->is_void_type())
            builder->create_void_ret();
        else if (context.func->get_return_type()->is_float_type())
            builder->create_ret(CONST_FP(0.));
        else
            builder->create_ret(CONST_INT(0));
    }
    //退出当前作用域
    scope.exit();
    return nullptr;
}

Value* CminusfBuilder::visit(ASTParam &node) {
    // TODO: This function is empty now.
    // Add some code here.
    if(node.type == TYPE_INT){
        if(node.isarray)
            context.type = INT32PTR_T;
        else
            context.type = INT32_T;
    }
    else if(node.type == TYPE_FLOAT){
        if(node.isarray)
            context.type = FLOATPTR_T;
        else
            context.type = FLOAT_T;
    }
    return nullptr;
}

Value* CminusfBuilder::visit(ASTCompoundStmt &node) {
    // TODO: This function is not complete.
    // You may need to add some code here
    // to deal with complex statements. 
    scope.enter();
    for (auto &decl : node.local_declarations) {
        decl->accept(*this);
    }

    for (auto &stmt : node.statement_list) {
        stmt->accept(*this);
        if (builder->get_insert_block()->is_terminated())
            break;
    }
    scope.exit();
    return nullptr;
}

Value* CminusfBuilder::visit(ASTExpressionStmt &node) {
    // TODO: This function is empty now.
    // Add some code here.
    return node.expression->accept(*this);
}

Value* CminusfBuilder::visit(ASTSelectionStmt &node) {
    // TODO: This function is empty now.
    // Add some code here.
    auto br = node.expression->accept(*this);
    if(br->get_type()==FLOAT_T){
        br = builder->create_fptosi(br, INT32_T);
    }
    auto cmp = builder->create_icmp_gt(br, CONST_INT(0));

    auto trueBB = BasicBlock::create(module.get(), "", context.func);
    auto retBB = BasicBlock::create(module.get(), "", context.func);
    
    if(node.else_statement != nullptr){
        auto falseBB = BasicBlock::create(module.get(), "", context.func);
        builder->create_cond_br(cmp, trueBB, falseBB);
        builder->set_insert_point(trueBB);
        node.if_statement->accept(*this);
        //如果此时没有返回
        if(not builder->get_insert_block()->is_terminated()){
            builder->create_br(retBB);
        }
        builder->set_insert_point(falseBB);
        node.else_statement->accept(*this);
        if(not builder->get_insert_block()->is_terminated()){
            builder->create_br(retBB);
        }
        builder->set_insert_point(retBB);                  
    }
    else{
        builder->create_cond_br(cmp, trueBB, retBB);
        builder->set_insert_point(trueBB);
        node.if_statement->accept(*this);
        if (not builder->get_insert_block()->is_terminated()) {
            builder->create_br(retBB);
    }

    }
    builder->set_insert_point(retBB);
    return nullptr;
}

Value* CminusfBuilder::visit(ASTIterationStmt &node) {
    // TODO: This function is empty now.
    // Add some code here.
    auto whileBB = BasicBlock::create(module.get(), "", context.func);
    builder->create_br(whileBB);
    auto trueBB = BasicBlock::create(module.get(), "", context.func);
    auto retBB = BasicBlock::create(module.get(), "", context.func);
    builder->set_insert_point(whileBB);
    auto cond =  node.expression->accept(*this);
    auto cmp = builder->create_icmp_ne(cond, CONST_INT(0));
    builder->create_cond_br(cmp, trueBB, retBB);
    builder->set_insert_point(trueBB);
    node.statement->accept(*this);
    if(not builder->get_insert_block()->is_terminated())
        builder->create_br(whileBB);
    builder->set_insert_point(retBB);
    return nullptr;
}

Value* CminusfBuilder::visit(ASTReturnStmt &node) {
    if (node.expression == nullptr) {
        builder->create_void_ret();
    } else {
        auto ret = node.expression->accept(*this);
        auto ret_type = context.func->get_return_type();
        if(ret_type == INT32_T && ret->get_type() == FLOAT_T){
            auto trans_ret = builder->create_fptosi(ret, INT32_T);  
            builder->create_ret(trans_ret);
        }
        else if(ret_type == FLOAT_T && ret->get_type() == INT32_T){
            auto trans_ret = builder->create_sitofp(ret, FLOAT_T);
            builder->create_ret(trans_ret);
        }
        else
            builder->create_ret(ret);
        // TODO: The given code is incomplete.
        // You need to solve other return cases (e.g. return an integer).
    }
    return nullptr;
}
// 如何存储一个变量的地址
Value* CminusfBuilder::visit(ASTVar &node) {
    // TODO: This function is empty now.
    // Add some code here.
    if(node.expression == nullptr){
        // 找到对应的地址，怎么返回？
        Value *Load = nullptr;
        Load = scope.find(node.id);
        if(Load->get_type()->get_pointer_element_type()->is_array_type()){
            Load = builder->create_gep(Load, {CONST_INT(0), CONST_INT(0)});
            context.Load = Load;
            return Load;           
        }
        if(context.type == INT32PTR_T || context.type == FLOATPTR_T){
            Load = builder->create_gep(Load, {CONST_INT(0)});
            context.Load = Load;
            return Load;
        }
        context.Load = Load;
        return builder->create_load(Load);
    }
    else{  // a[id]
        Value* value = node.expression->accept(*this);
        Value *Load = nullptr;
        Value *ret = nullptr;
        Load = scope.find(node.id);
        if(value->get_type() == FLOAT_T){
            value = builder->create_fptosi(value,INT32_T);
        }      
        // 判断是否小于0
        auto cmp = builder->create_icmp_ge(value, CONST_INT(0));
        auto trueBB = BasicBlock::create(module.get(), "", context.func);
        auto falseBB = BasicBlock::create(module.get(), "", context.func);
        auto retBB = BasicBlock::create(module.get(), "", context.func);
        builder->create_cond_br(cmp, falseBB, trueBB);
        builder->set_insert_point(falseBB);
        Value *addr = nullptr;
        if(Load->get_type()->get_pointer_element_type()->is_float_type() || Load->get_type()->get_pointer_element_type()->is_integer_type())
            addr  = builder->create_gep(Load, {value});
        else if(Load->get_type()->get_pointer_element_type()->is_pointer_type())
            addr = builder->create_gep(builder->create_load(Load), {value});
        else
            addr  = builder->create_gep(Load, {CONST_INT(0),value});
        context.Load = addr;
        ret = builder->create_load(addr);
        builder->create_br(retBB);
        builder->set_insert_point(trueBB);
        // 调用函数
        builder->create_call(static_cast<Function *>(scope.find("neg_idx_except")),{});
        builder->create_br(retBB);
        builder->set_insert_point(retBB);
        return ret;
    }
    return nullptr;
}

Value* CminusfBuilder::visit(ASTAssignExpression &node) {
    // TODO: This function is empty now.
    // Add some code here.
    // 有expression
    Value* value_right = node.expression->accept(*this);
    auto val = node.var->accept(*this);
    if(val == nullptr){
        if (context.func->get_return_type()->is_void_type()) 
            builder->create_void_ret();
        else if (context.func->get_return_type()->is_float_type()) 
            builder->create_ret(CONST_FP(0.));
        else 
            builder->create_ret(CONST_INT(0));
        return nullptr;
    }
    if(value_right->get_type() == FLOAT_T && val->get_type() == INT32_T)
        value_right = builder->create_fptosi(value_right, INT32_T);
    else if(value_right->get_type() == INT32_T && val->get_type() == FLOAT_T)
        value_right = builder->create_sitofp(value_right, FLOAT_T);
    builder->create_store(value_right, context.Load);
    return value_right;
}

Value* CminusfBuilder::visit(ASTSimpleExpression &node) {
    // TODO: This function is empty now.
    // Add some code here.
    Value *left = node.additive_expression_l->accept(*this);
    if(node.additive_expression_r!=nullptr){
        Value *right = node.additive_expression_r->accept(*this);
        Value *cmp;
        bool rint = right->get_type() == INT32_T;
        bool lint = left->get_type() == INT32_T;
        switch (node.op) {
        case OP_LE:
            if(lint && rint){
                cmp = builder->create_icmp_le(left, right);   
            }
            else{
                if(lint){
                    auto left_f = builder->create_sitofp(left, FLOAT_T);
                    cmp = builder->create_fcmp_le(left_f, right);
                }
                else if(rint){
                    auto right_f = builder->create_sitofp(right, FLOAT_T);
                    cmp = builder->create_fcmp_le(left,right_f );
                }
                else 
                    cmp = builder->create_fcmp_le(left, right);
            }
            return builder->create_zext(cmp, INT32_T);
            break;
        case OP_LT:
            if(lint && rint){
                cmp = builder->create_icmp_lt(left, right);    
            }
            else{
                if(lint){
                    auto left_f = builder->create_sitofp(left, FLOAT_T);
                    cmp = builder->create_fcmp_lt(left_f, right);
                }
                else if(rint){
                    auto right_f = builder->create_sitofp(right, FLOAT_T);
                    cmp = builder->create_fcmp_lt(left,right_f );
                }
                else cmp = builder->create_fcmp_lt(left, right);
            }
            return builder->create_zext(cmp, INT32_T);
            break;
        case OP_GT:
            if(lint && rint){
                cmp = builder->create_icmp_gt(left, right);   
            }
            else{
                if(lint){
                    auto left_f = builder->create_sitofp(left, FLOAT_T);
                    cmp = builder->create_fcmp_gt(left_f, right);
                }
                else if(rint){
                    auto right_f = builder->create_sitofp(right, FLOAT_T);
                    cmp = builder->create_fcmp_gt(left,right_f );
                }
                else cmp = builder->create_fcmp_gt(left, right);
            }
            return builder->create_zext(cmp, INT32_T);
            break;
        case OP_GE:
            if(lint && rint){
                cmp = builder->create_icmp_ge(left, right);   
            }
            else{
                if(lint){
                    auto left_f = builder->create_sitofp(left, FLOAT_T);
                    cmp = builder->create_fcmp_ge(left_f, right);
                }
                else if(rint){
                    auto right_f = builder->create_sitofp(right, FLOAT_T);
                    cmp = builder->create_fcmp_ge(left,right_f );
                }
                else cmp = builder->create_fcmp_ge(left, right);
            }
            return builder->create_zext(cmp, INT32_T);
            break;
        case OP_EQ:
            if(lint && rint){
                cmp = builder->create_icmp_eq(left, right);   
            }
            else{
                if(lint){
                    auto left_f = builder->create_sitofp(left, FLOAT_T);
                    cmp = builder->create_fcmp_eq(left_f, right);
                }
                else if(rint){
                    auto right_f = builder->create_sitofp(right, FLOAT_T);
                    cmp = builder->create_fcmp_eq(left,right_f );
                }
                else cmp = builder->create_fcmp_eq(left, right);
            }
            return builder->create_zext(cmp, INT32_T);
            break;
        case OP_NEQ:
            if(lint && rint){
                cmp = builder->create_icmp_ne(left, right);    
            }
            else{
                if(lint){
                    auto left_f = builder->create_sitofp(left, FLOAT_T);
                    cmp = builder->create_fcmp_ne(left_f, right);
                }
                else if(rint){
                    auto right_f = builder->create_sitofp(right, FLOAT_T);
                    cmp = builder->create_fcmp_ne(left,right_f );
                }
                else cmp = builder->create_fcmp_ne(left, right);
            }
            return builder->create_zext(cmp, INT32_T);
            break;
        }
    }
    else
        return left;
    return nullptr;
}

Value* CminusfBuilder::visit(ASTAdditiveExpression &node) {
    // TODO: This function is empty now.
    // Add some code here.
    // 要利用返回值
    while(node.additive_expression != nullptr){
        auto value = node.additive_expression->accept(*this);
        auto term_val = node.term->accept(*this);
        bool value_int = value->get_type() == INT32_T;
        bool term_int = term_val->get_type() == INT32_T;
        // Value *res;
        switch (node.op) {
        case OP_PLUS:
            if(value_int && term_int){
                return builder->create_iadd(value, term_val);
            }
            else{
                if(value_int){
                    auto value_f = builder->create_sitofp(value, FLOAT_T);
                    return builder->create_fadd(value_f, term_val);
                }
                if(term_int){
                    auto term_f = builder->create_sitofp(term_val, FLOAT_T);
                    return builder->create_fadd(value, term_f);
                }
                return builder->create_fadd(value, term_val);
            }
            break;
        case OP_MINUS:
            if(value_int && term_int){
                return builder->create_isub(value, term_val);
            }
            else{
                if(value_int){
                    auto value_f = builder->create_sitofp(value, FLOAT_T);
                    return builder->create_fsub(value_f, term_val);
                }
                if(term_int){
                    auto term_f = builder->create_sitofp(term_val, FLOAT_T);
                    return builder->create_fsub(value, term_f);
                }
                return builder->create_fsub(value, term_val);
            }
            break;
        }
    }
    return node.term->accept(*this);
}

Value* CminusfBuilder::visit(ASTTerm &node) {
    // TODO: This function is empty now.
    // Add some code here.
    while(node.term != nullptr){
        auto term_val = node.term->accept(*this);
        auto factor_val = node.factor->accept(*this);
        bool term_int = term_val->get_type() == INT32_T;
        bool factor_int = factor_val->get_type() == INT32_T;
        switch (node.op) {
        case OP_MUL:
            if(term_int && factor_int){
                return builder->create_imul(term_val, factor_val);
            }
            else{
                if(term_int){
                    auto term_f = builder->create_sitofp(term_val, FLOAT_T);
                    return builder->create_fmul(term_f, factor_val);
                }
                if(factor_int){
                    auto factor_f = builder->create_sitofp(factor_val, FLOAT_T);
                    return builder->create_fmul(term_val, factor_f);
                }
                return builder->create_fmul(term_val, factor_val);
            }
            break;
        case OP_DIV:
            if(term_int && factor_int){
                return builder->create_isdiv(term_val, factor_val);
            }
            else{
                if(term_int){
                    auto term_f = builder->create_sitofp(term_val, FLOAT_T);
                    return builder->create_fdiv(term_f, factor_val);
                }
                if(factor_int){
                    auto factor_f = builder->create_sitofp(factor_val, FLOAT_T);
                    return builder->create_fdiv(term_val, factor_f);
                }
                return builder->create_fdiv(term_val, factor_val);
            }
            break;
        }
    }
    return node.factor->accept(*this);
    return nullptr;
}

Value* CminusfBuilder::visit(ASTCall &node) {
    // TODO: This function is empty now.
    // Add some code here.
    // 调用函数
    std::vector<Value *> args_list;
    std::vector<Type *> args_type_list;
    auto callFun = dynamic_cast<Function*>(scope.find(node.id));
    for(auto &arg : callFun->get_args()){
        args_type_list.push_back(arg.get_type());
    }
    size_t j  = 0;
    for(auto &expr : node.args){
        context.type = args_type_list[j]; // 找到对应的参数
        args_list.push_back(expr->accept(*this));
        if(args_type_list[j] == INT32_T && args_list[j]->get_type() == FLOAT_T){
            args_list[j] = builder->create_fptosi(args_list[j], args_type_list[j]);
        }
        else if(args_type_list[j] == FLOAT_T && args_list[j]->get_type() == INT32_T){
            args_list[j] = builder->create_sitofp(args_list[j], args_type_list[j]);
        }
        j++;
    }
    context.type = nullptr;
    // 调用函数
    auto call = builder->create_call(callFun, args_list);
    return call;
    return nullptr;
}
