#include "Type.hpp"
#include "Module.hpp"
#include "IRBuilder.hpp"
#include "BasicBlock.hpp"
#include "Constant.hpp"
#include "Function.hpp"
#include "Value.hpp"

#include <iostream>
#include <memory>
#include <sys/types.h>
#include <vector>

#define CONST_INT(num) ConstantInt::get(num, module)

int main() {
    auto module = new Module();
    Type *Int32Type = module->get_int32_type();
    std::vector<Type *> Ints(1, Int32Type);
    auto calleeFunTy = FunctionType::get(Int32Type,Ints);
    auto calleeFun = Function::create(calleeFunTy, "callee", module);
    auto bb = BasicBlock::create(module, "entry", calleeFun);
    auto builder= new IRBuilder(nullptr, module);
    builder->set_insert_point(bb);
    auto retAlloca = builder->create_alloca(Int32Type);
    auto aAlloca = builder->create_alloca(Int32Type);
    std::vector<Value *> args;
    for (auto &arg : calleeFun->get_args()){
        args.push_back(&arg);
    }
    builder->create_store(args[0], aAlloca);
    auto aLoad = builder->create_load(aAlloca);
    auto mulRes = builder->create_imul(CONST_INT(2), aLoad);
    builder->create_store(mulRes, retAlloca);
    auto retLOAD = builder->create_load(retAlloca);
    builder->create_ret(retLOAD);
    // create main function
    auto mainFun = Function::create(FunctionType::get(Int32Type, {}), "main", module);
    bb = BasicBlock::create(module, "entry", mainFun);
    builder->set_insert_point(bb);
    retAlloca = builder->create_alloca(Int32Type);
    builder->create_store(CONST_INT(0), retAlloca);
    auto call = builder->create_call(calleeFun, {CONST_INT(110)});
    builder->create_ret(call);
    std::cout << module->print();
    delete module;
    return 0;
}