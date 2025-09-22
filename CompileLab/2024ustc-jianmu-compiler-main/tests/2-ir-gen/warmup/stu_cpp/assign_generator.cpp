#include "../../../../include/lightir/BasicBlock.hpp"
#include "../../../../include/lightir/Constant.hpp"
#include "../../../../include/lightir/Function.hpp"
#include "../../../../include/lightir/IRBuilder.hpp"
#include "../../../../include/lightir/Module.hpp"
#include "../../../../include/lightir/Type.hpp"

#include <iostream>
#include <memory>

// 定义一个从常数值获取/创建 ConstantInt 类实例化的宏，方便多次调用
#define CONST_INT(num) ConstantInt::get(num, module)

int main() {
    // 创建一个 Module 实例
    auto module = new Module();
    auto builder = new IRBuilder(nullptr, module);
    Type *Int32Type = module->get_int32_type();
    // create a 10 x i32 array
    // auto *arrayType = ArrayType::get(Int32Type, 10);
    // create main Function
    auto mainFun = Function::create(FunctionType::get(Int32Type,{}), "main",module);
    // create bb
    auto bb = BasicBlock::create(module, "entry", mainFun);
    // create insert
    builder->set_insert_point(bb);
    // create 10 x int32
    auto *arrayType = module->get_array_type(Int32Type, 10);
    // auto Int32PtrType = module->get_int32_ptr_type();
    auto aAlloca = builder->create_alloca(arrayType);
    auto a0GEP = builder->create_gep(aAlloca, {CONST_INT(0), CONST_INT(0)});
    builder->create_store(CONST_INT(10),a0GEP);
    auto a1GEP = builder->create_gep(aAlloca, {CONST_INT(0), CONST_INT(1)}); 
    auto a0LOAD = builder->create_load(a0GEP);
    auto addRes = builder->create_imul(a0LOAD, CONST_INT(2));
    builder->create_store(addRes, a1GEP);
    auto a1LOAD = builder->create_load(a1GEP);
    builder->create_ret(a1LOAD);
    std::cout << module->print();
    delete module;
    return 0;
}