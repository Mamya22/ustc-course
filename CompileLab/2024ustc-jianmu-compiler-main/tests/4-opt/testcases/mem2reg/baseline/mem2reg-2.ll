; ModuleID = 'cminus'
source_filename = "/home/zox/compiler/2024ustc-jianmu-compiler-ta/tests/4-mem2reg/performance-cases/testcase-2.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  br label %label0
label0:                                                ; preds = %label_entry, %label5
  %op1 = phi i32 [ 1, %label_entry ], [ %op6, %label5 ]
  %op2 = icmp slt i32 %op1, 999999999
  %op3 = zext i1 %op2 to i32
  %op4 = icmp ne i32 %op3, 0
  br i1 %op4, label %label5, label %label7
label5:                                                ; preds = %label0
  %op6 = add i32 %op1, 1
  br label %label0
label7:                                                ; preds = %label0
  ret i32 %op1
}
