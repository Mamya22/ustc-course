; ModuleID = 'cminus'
source_filename = "/home/mamya/CompileLab/lab2/2024ustc-jianmu-compiler/tests/2-ir-gen/autogen/testcases/lv1/assign_int_array_local.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define void @main() {
label_entry:
  %op0 = alloca [10 x i32]
  %op1 = icmp slt i32 3, 0
  br i1 %op1, label %label_trueBB0, label %label_falseBB0
label_trueBB0:                                                ; preds = %label_entry
  call void @neg_idx_except()
  ret void
label_falseBB0:                                                ; preds = %label_entry
}
