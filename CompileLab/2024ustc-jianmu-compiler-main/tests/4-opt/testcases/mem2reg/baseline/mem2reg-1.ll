; ModuleID = 'cminus'
source_filename = "/home/zox/compiler/2024ustc-jianmu-compiler-ta/tests/4-mem2reg/performance-cases/testcase-1.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define void @main() {
label_entry:
  %op0 = call i32 @input()
  br label %label1
label1:                                                ; preds = %label_entry, %label7
  %op2 = phi i32 [ 0, %label_entry ], [ %op33, %label7 ]
  %op3 = phi i32 [ 0, %label_entry ], [ %op32, %label7 ]
  %op4 = icmp slt i32 %op2, %op0
  %op5 = zext i1 %op4 to i32
  %op6 = icmp ne i32 %op5, 0
  br i1 %op6, label %label7, label %label34
label7:                                                ; preds = %label1
  %op8 = fmul float 0x3ff3c0c200000000, 0x4016f06a20000000
  %op9 = fmul float %op8, 0x4002aa9940000000
  %op10 = fmul float %op9, 0x4011781d80000000
  %op11 = fmul float %op10, 0x401962ac40000000
  %op12 = fptosi float %op11 to i32
  %op13 = mul i32 %op12, %op12
  %op14 = mul i32 %op13, %op12
  %op15 = mul i32 %op14, %op12
  %op16 = mul i32 %op15, %op12
  %op17 = mul i32 %op16, %op12
  %op18 = mul i32 %op17, %op17
  %op19 = mul i32 %op18, %op17
  %op20 = mul i32 %op19, %op17
  %op21 = mul i32 %op20, %op17
  %op22 = mul i32 %op21, %op17
  %op23 = mul i32 %op22, %op22
  %op24 = mul i32 %op23, %op22
  %op25 = mul i32 %op24, %op22
  %op26 = mul i32 %op25, %op22
  %op27 = mul i32 %op26, %op22
  %op28 = mul i32 %op27, %op27
  %op29 = mul i32 %op28, %op27
  %op30 = mul i32 %op29, %op27
  %op31 = mul i32 %op30, %op27
  %op32 = mul i32 %op31, %op27
  %op33 = add i32 %op2, 1
  br label %label1
label34:                                                ; preds = %label1
  call void @output(i32 %op3)
  ret void
}
