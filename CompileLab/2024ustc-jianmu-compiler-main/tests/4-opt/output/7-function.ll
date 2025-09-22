; ModuleID = 'cminus'
source_filename = "/home/mamya/CompileLab/2024ustc-jianmu-compiler/tests/4-opt/testcases/functional-cases/7-function.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @min(i32 %arg0, i32 %arg1) {
label_entry:
  %op6 = icmp sle i32 %arg0, %arg1
  %op7 = zext i1 %op6 to i32
  %op8 = icmp sgt i32 %op7, 0
  br i1 %op8, label %label9, label %label12
label9:                                                ; preds = %label_entry
  ret i32 %arg0
label12:                                                ; preds = %label_entry
  ret i32 %arg1
}
define i32 @main() {
label_entry:
  %op8 = call i32 @min(i32 11, i32 22)
  call void @output(i32 %op8)
  %op11 = call i32 @min(i32 22, i32 33)
  call void @output(i32 %op11)
  %op14 = call i32 @min(i32 33, i32 11)
  call void @output(i32 %op14)
  ret i32 0
}
