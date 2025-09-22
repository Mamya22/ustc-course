#include "Type.hpp"
#include "Module.hpp"
#include "IRBuilder.hpp"
#include "BasicBlock.hpp"
#include "Constant.hpp"
#include "Function.hpp"
#include "Value.hpp"

#include <cstddef>
#include <iostream>
#include <memory>
#include <sys/types.h>

#define CONST_INT(num) ConstantInt::get(num, module)

int main() {
    auto module = new Module();
    auto builder = new IRBuilder(nullptr, module);
    Type *Int32Type = module->get_int32_type();
    auto mainFun = Function::create(FunctionType::get(Int32Type, {}), "main", module);
    auto bb = BasicBlock::create(module, "entry", mainFun);
    // 
    builder->set_insert_point(bb);
    auto aAlloca = builder->create_alloca(Int32Type);
    auto iAlloca = builder->create_alloca(Int32Type);
    builder->create_store(CONST_INT(10), aAlloca);
    builder->create_store(CONST_INT(0), iAlloca);

    auto whileBB = BasicBlock::create(module, "whileBB", mainFun);
    auto trueBB = BasicBlock::create(module, "trueBB", mainFun);
    auto retBB = BasicBlock::create(module, "retBB", mainFun);
    // 进入while循环
    builder->create_br(whileBB);
    builder->set_insert_point(whileBB);
    auto iLoad = builder->create_load(iAlloca);
    auto icmp = builder->create_icmp_lt(iLoad, CONST_INT(10));
    //设置跳转条件
    builder->create_cond_br(icmp, trueBB, retBB);
    //设置循环体内容
    builder->set_insert_point(trueBB);
    auto addI = builder->create_iadd(iLoad, CONST_INT(1));
    builder->create_store(addI, iAlloca);
    auto aLoad = builder->create_load(aAlloca);
    auto addA = builder->create_iadd(aLoad, addI);
    builder->create_store(addA, aAlloca);
    builder->create_br(whileBB);
    //跳出while循环的内容
    builder->set_insert_point(retBB);
    aLoad = builder->create_load(aAlloca);
    builder->create_ret(aLoad);
    std::cout << module->print();
    delete module;
    return 0;
}
