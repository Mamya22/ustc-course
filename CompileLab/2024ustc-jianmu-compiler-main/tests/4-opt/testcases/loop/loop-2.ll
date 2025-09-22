; ModuleID = 'cminus'
source_filename = "/home/mamya/CompileLab/2024ustc-jianmu-compiler/tests/4-opt/testcases/loop/loop-2.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define void @main() {
label_entry:
  br label %label6
label6:                                                ; preds = %label_entry, %label64
  %op68 = phi i32 [ 0, %label_entry ], [ %op66, %label64 ]
  %op69 = phi i32 [ %op71, %label64 ], [ undef, %label_entry ]
  %op8 = icmp slt i32 %op68, 10000000
  %op9 = zext i1 %op8 to i32
  %op10 = icmp ne i32 %op9, 0
  br i1 %op10, label %label11, label %label13
label11:                                                ; preds = %label6
  br label %label15
label13:                                                ; preds = %label6
  call void @output(i32 %op69)
  ret void
label15:                                                ; preds = %label11, %label20
  %op70 = phi i32 [ 0, %label11 ], [ %op62, %label20 ]
  %op71 = phi i32 [ %op69, %label11 ], [ %op59, %label20 ]
  %op17 = icmp slt i32 %op70, 2
  %op18 = zext i1 %op17 to i32
  %op19 = icmp ne i32 %op18, 0
  br i1 %op19, label %label20, label %label64
label20:                                                ; preds = %label15
  %op23 = mul i32 2, 2
  %op25 = mul i32 %op23, 2
  %op27 = mul i32 %op25, 2
  %op29 = mul i32 %op27, 2
  %op31 = mul i32 %op29, 2
  %op33 = mul i32 %op31, 2
  %op35 = mul i32 %op33, 2
  %op37 = mul i32 %op35, 2
  %op39 = mul i32 %op37, 2
  %op41 = sdiv i32 %op39, 2
  %op43 = sdiv i32 %op41, 2
  %op45 = sdiv i32 %op43, 2
  %op47 = sdiv i32 %op45, 2
  %op49 = sdiv i32 %op47, 2
  %op51 = sdiv i32 %op49, 2
  %op53 = sdiv i32 %op51, 2
  %op55 = sdiv i32 %op53, 2
  %op57 = sdiv i32 %op55, 2
  %op59 = sdiv i32 %op57, 2
  %op62 = add i32 %op70, 1
  br label %label15
label64:                                                ; preds = %label15
  %op66 = add i32 %op68, 1
  br label %label6
}
