; ModuleID = 'cminus'
source_filename = "/home/mamya/CompileLab/2024ustc-jianmu-compiler/tests/testcases_general/12-funcall_recursion.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @factorial(i32 %arg0) {
label_entry:
  %op3 = icmp eq i32 %arg0, 0
  %op4 = zext i1 %op3 to i32
  %op5 = icmp sgt i32 %op4, 0
  br i1 %op5, label %label6, label %label8
label6:                                                ; preds = %label_entry
  ret i32 1
label8:                                                ; preds = %label_entry
  %op11 = sub i32 %arg0, 1
  %op12 = call i32 @factorial(i32 %op11)
  %op13 = mul i32 %arg0, %op12
  ret i32 %op13
}
define i32 @main() {
label_entry:
  %op1 = call i32 @factorial(i32 10)
  ret i32 %op1
}
