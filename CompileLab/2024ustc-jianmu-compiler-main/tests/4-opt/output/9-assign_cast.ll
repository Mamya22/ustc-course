; ModuleID = 'cminus'
source_filename = "/home/mamya/CompileLab/2024ustc-jianmu-compiler/tests/testcases_general/9-assign_cast.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  %op2 = icmp slt i32 1, 3
  %op3 = zext i1 %op2 to i32
  %op5 = sitofp i32 2 to float
  %op6 = fadd float %op5, 0x4003333340000000
  %op8 = fptosi float %op6 to i32
  %op11 = add i32 %op3, %op8
  ret i32 %op11
}
