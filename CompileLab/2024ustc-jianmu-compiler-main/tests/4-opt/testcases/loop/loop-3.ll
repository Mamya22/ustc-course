; ModuleID = 'cminus'
source_filename = "/home/mamya/CompileLab/2024ustc-jianmu-compiler/tests/4-opt/testcases/loop/loop-3.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define void @main() {
label_entry:
  br label %label10
label10:                                                ; preds = %label_entry, %label26
  %op116 = phi i32 [ %op118, %label26 ], [ undef, %label_entry ]
  %op117 = phi i32 [ 0, %label_entry ], [ %op28, %label26 ]
  %op12 = icmp slt i32 %op117, 1000000
  %op13 = zext i1 %op12 to i32
  %op14 = icmp ne i32 %op13, 0
  br i1 %op14, label %label15, label %label17
label15:                                                ; preds = %label10
  br label %label19
label17:                                                ; preds = %label10
  call void @output(i32 %op116)
  ret void
label19:                                                ; preds = %label15, %label37
  %op118 = phi i32 [ %op116, %label15 ], [ %op120, %label37 ]
  %op119 = phi i32 [ 0, %label15 ], [ %op39, %label37 ]
  %op21 = icmp slt i32 %op119, 2
  %op22 = zext i1 %op21 to i32
  %op23 = icmp ne i32 %op22, 0
  br i1 %op23, label %label24, label %label26
label24:                                                ; preds = %label19
  br label %label30
label26:                                                ; preds = %label19
  %op28 = add i32 %op117, 1
  br label %label10
label30:                                                ; preds = %label24, %label48
  %op120 = phi i32 [ %op118, %label24 ], [ %op122, %label48 ]
  %op121 = phi i32 [ 0, %label24 ], [ %op50, %label48 ]
  %op32 = icmp slt i32 %op121, 2
  %op33 = zext i1 %op32 to i32
  %op34 = icmp ne i32 %op33, 0
  br i1 %op34, label %label35, label %label37
label35:                                                ; preds = %label30
  br label %label41
label37:                                                ; preds = %label30
  %op39 = add i32 %op119, 1
  br label %label19
label41:                                                ; preds = %label35, %label59
  %op122 = phi i32 [ %op120, %label35 ], [ %op124, %label59 ]
  %op123 = phi i32 [ 0, %label35 ], [ %op61, %label59 ]
  %op43 = icmp slt i32 %op123, 2
  %op44 = zext i1 %op43 to i32
  %op45 = icmp ne i32 %op44, 0
  br i1 %op45, label %label46, label %label48
label46:                                                ; preds = %label41
  br label %label52
label48:                                                ; preds = %label41
  %op50 = add i32 %op121, 1
  br label %label30
label52:                                                ; preds = %label46, %label112
  %op124 = phi i32 [ %op122, %label46 ], [ %op126, %label112 ]
  %op125 = phi i32 [ 0, %label46 ], [ %op114, %label112 ]
  %op54 = icmp slt i32 %op125, 2
  %op55 = zext i1 %op54 to i32
  %op56 = icmp ne i32 %op55, 0
  br i1 %op56, label %label57, label %label59
label57:                                                ; preds = %label52
  br label %label63
label59:                                                ; preds = %label52
  %op61 = add i32 %op123, 1
  br label %label41
label63:                                                ; preds = %label57, %label68
  %op126 = phi i32 [ %op124, %label57 ], [ %op107, %label68 ]
  %op127 = phi i32 [ 0, %label57 ], [ %op110, %label68 ]
  %op65 = icmp slt i32 %op127, 2
  %op66 = zext i1 %op65 to i32
  %op67 = icmp ne i32 %op66, 0
  br i1 %op67, label %label68, label %label112
label68:                                                ; preds = %label63
  %op71 = mul i32 2, 2
  %op73 = mul i32 %op71, 2
  %op75 = mul i32 %op73, 2
  %op77 = mul i32 %op75, 2
  %op79 = mul i32 %op77, 2
  %op81 = mul i32 %op79, 2
  %op83 = mul i32 %op81, 2
  %op85 = mul i32 %op83, 2
  %op87 = mul i32 %op85, 2
  %op89 = sdiv i32 %op87, 2
  %op91 = sdiv i32 %op89, 2
  %op93 = sdiv i32 %op91, 2
  %op95 = sdiv i32 %op93, 2
  %op97 = sdiv i32 %op95, 2
  %op99 = sdiv i32 %op97, 2
  %op101 = sdiv i32 %op99, 2
  %op103 = sdiv i32 %op101, 2
  %op105 = sdiv i32 %op103, 2
  %op107 = sdiv i32 %op105, 2
  %op110 = add i32 %op127, 1
  br label %label63
label112:                                                ; preds = %label63
  %op114 = add i32 %op125, 1
  br label %label52
}
