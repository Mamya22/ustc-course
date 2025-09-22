; ModuleID = 'cminus'
source_filename = "/home/mamya/CompileLab/2024ustc-jianmu-compiler/tests/4-opt/testcases/functional-cases/10-float.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  %op8 = fmul float 0x3ff19999a0000000, 0x3ff8000000000000
  %op10 = fadd float %op8, 0x3ff3333340000000
  call void @outputFloat(float %op10)
  ret i32 0
}
