; ModuleID = 'cminus'
source_filename = "/home/mamya/CompileLab/2024ustc-jianmu-compiler/tests/4-opt/testcases/loop/loop-1.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define void @main() {
label_entry:
  br label %label4
label4:                                                ; preds = %label_entry, %label62
  %op66 = phi i32 [ 1, %label_entry ], [ %op64, %label62 ]
  %op67 = phi i32 [ %op69, %label62 ], [ undef, %label_entry ]
  %op6 = icmp slt i32 %op66, 10000
  %op7 = zext i1 %op6 to i32
  %op8 = icmp ne i32 %op7, 0
  br i1 %op8, label %label9, label %label11
label9:                                                ; preds = %label4
  br label %label70
label11:                                                ; preds = %label4
  call void @output(i32 %op67)
  ret void
label13:                                                ; preds = %label18, %label70
  %op68 = phi i32 [ %op60, %label18 ], [ %op72, %label70 ]
  %op69 = phi i32 [ %op57, %label18 ], [ %op71, %label70 ]
  %op15 = icmp slt i32 %op68, 10000
  %op16 = zext i1 %op15 to i32
  %op17 = icmp ne i32 %op16, 0
  br i1 %op17, label %label18, label %label62
label18:                                                ; preds = %label13
  %op23 = mul i32 %op21, %op66
  %op25 = mul i32 %op23, %op66
  %op27 = mul i32 %op25, %op66
  %op29 = mul i32 %op27, %op66
  %op31 = mul i32 %op29, %op66
  %op33 = mul i32 %op31, %op66
  %op35 = mul i32 %op33, %op66
  %op37 = mul i32 %op35, %op66
  %op39 = sdiv i32 %op37, %op66
  %op41 = sdiv i32 %op39, %op66
  %op43 = sdiv i32 %op41, %op66
  %op45 = sdiv i32 %op43, %op66
  %op47 = sdiv i32 %op45, %op66
  %op49 = sdiv i32 %op47, %op66
  %op51 = sdiv i32 %op49, %op66
  %op53 = sdiv i32 %op51, %op66
  %op55 = sdiv i32 %op53, %op66
  %op57 = sdiv i32 %op55, %op66
  %op60 = add i32 %op68, 1
  br label %label13
label62:                                                ; preds = %label13
  %op64 = add i32 %op66, 1
  br label %label4
label70:                                                ; preds = %label9%label9
  %op71 = phi i32 [ %op67, %label9 ]
  %op72 = phi i32 [ 0, %label9 ]
  %op21 = mul i32 %op66, %op66
  br label %label13
}
