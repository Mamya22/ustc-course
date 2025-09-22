; ModuleID = 'cminus'
source_filename = "/home/mamya/CompileLab/2024ustc-jianmu-compiler/tests/testcases_general/6-num_add_int.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  %op1 = add i32 1000, 234
  ret i32 %op1
}
