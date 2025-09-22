; ModuleID = 'cminus'
source_filename = "/home/mamya/CompileLab/2024ustc-jianmu-compiler/tests/4-opt/testcases/loop/loop-1.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define void @main() {
label_entry:
  br label %label4
label4:                                                ; preds = %label62, %label71, %label71
  %op67 = phi i32 [ %op69, %label62 ], [ undef, %label71 ], [ undef, %label71 ]
  br i1 %op8, label %label9, label %label11
label9:                                                ; preds = %label4
  br label %label13
label11:                                                ; preds = %label4
  call void @output(i32 %op67)
  ret void
label13:                                                ; preds = %label18, %label70, %label70
  %op69 = phi i32 [ %op67, %label9 ], [ %op57, %label18 ], [ undef, %label70 ], [ undef, %label70 ]
  br i1 %op17, label %label18, label %label62
label18:                                                ; preds = %label13
  br label %label13
label62:                                                ; preds = %label13
  br label %label4
label70:                                                ; preds = %label9
  br label %label13
label71:                                                ; preds = %label_entry
  %op6 = icmp slt i32 1, 10000
  %op7 = zext i1 %op6 to i32
  %op8 = icmp ne i32 %op7, 0
  %op15 = icmp slt i32 0, 10000
  %op16 = zext i1 %op15 to i32
  %op17 = icmp ne i32 %op16, 0
  %op21 = mul i32 1, 1
  %op23 = mul i32 %op21, 1
  %op25 = mul i32 %op23, 1
  %op27 = mul i32 %op25, 1
  %op29 = mul i32 %op27, 1
  %op31 = mul i32 %op29, 1
  %op33 = mul i32 %op31, 1
  %op35 = mul i32 %op33, 1
  %op37 = mul i32 %op35, 1
  %op39 = sdiv i32 %op37, 1
  %op41 = sdiv i32 %op39, 1
  %op43 = sdiv i32 %op41, 1
  %op45 = sdiv i32 %op43, 1
  %op47 = sdiv i32 %op45, 1
  %op49 = sdiv i32 %op47, 1
  %op51 = sdiv i32 %op49, 1
  %op53 = sdiv i32 %op51, 1
  %op55 = sdiv i32 %op53, 1
  %op57 = sdiv i32 %op55, 1
  br label %label4
}
