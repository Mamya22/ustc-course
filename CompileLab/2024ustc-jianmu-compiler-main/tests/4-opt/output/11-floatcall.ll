; ModuleID = 'cminus'
source_filename = "/home/mamya/CompileLab/2024ustc-jianmu-compiler/tests/4-opt/testcases/functional-cases/11-floatcall.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define float @mod(float %arg0, float %arg1) {
label_entry:
  %op7 = fdiv float %arg0, %arg1
  %op9 = fptosi float %op7 to i32
  %op13 = sitofp i32 %op9 to float
  %op14 = fmul float %op13, %arg1
  %op15 = fsub float %arg0, %op14
  ret float %op15
}
define i32 @main() {
label_entry:
  %op6 = call float @mod(float 0x4026666660000000, float 0x40019999a0000000)
  call void @outputFloat(float %op6)
  ret i32 0
}
