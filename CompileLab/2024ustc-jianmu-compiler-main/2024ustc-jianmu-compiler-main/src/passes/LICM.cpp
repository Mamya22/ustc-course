#include "BasicBlock.hpp"
#include "Constant.hpp"
#include "Function.hpp"
#include "GlobalVariable.hpp"
#include "Instruction.hpp"
#include "LICM.hpp"
#include "PassManager.hpp"
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
    
    throw std::runtime_error("Lab4: 你有一个TODO需要完成！");
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

    bool changed;
    do {
        changed = false;

        throw std::runtime_error("Lab4: 你有一个TODO需要完成！");

    } while (changed);

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
        
        throw std::runtime_error("Lab4: 你有一个TODO需要完成！");
    }

    // TODO: 用跳转指令重构控制流图 
    // 将所有非 latch 的 header 前驱块的跳转指向 preheader
    // 并将 preheader 的跳转指向 header
    // 注意这里需要更新前驱块的后继和后继的前驱
    std::vector<BasicBlock *> pred_to_remove;
    for (auto &pred : loop->get_header()->get_pre_basic_blocks()) {
        throw std::runtime_error("Lab4: 你有一个TODO需要完成！");
    }

    for (auto &pred : pred_to_remove) {
        loop->get_header()->remove_pre_basic_block(pred);
    }

    // TODO: 外提循环不变指令
    throw std::runtime_error("Lab4: 你有一个TODO需要完成！");

    // insert preheader br to header
    BranchInst::create_br(loop->get_header(), preheader);

    // insert preheader to parent loop
    if (loop->get_parent() != nullptr) {
        loop->get_parent()->add_block(preheader);
    }
}

