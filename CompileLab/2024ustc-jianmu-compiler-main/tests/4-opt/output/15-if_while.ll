; ModuleID = 'cminus'
source_filename = "/home/mamya/CompileLab/2024ustc-jianmu-compiler/tests/testcases_general/15-if_while.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  br label %label6
label6:                                                ; preds = %label_entry, %label26
  %op32 = phi i32 [ 0, %label_entry ], [ %op35, %label26 ]
  %op33 = phi i32 [ 10, %label_entry ], [ %op11, %label26 ]
  %op34 = phi i32 [ 0, %label_entry ], [ %op36, %label26 ]
  %op8 = icmp ne i32 %op33, 0
  br i1 %op8, label %label9, label %label17
label9:                                                ; preds = %label6
  %op11 = sub i32 %op33, 1
  %op14 = icmp slt i32 %op11, 5
  %op15 = zext i1 %op14 to i32
  %op16 = icmp sgt i32 %op15, 0
  br i1 %op16, label %label21, label %label27
label17:                                                ; preds = %label6
  %op20 = add i32 %op32, %op34
  ret i32 %op20
label21:                                                ; preds = %label9
  %op24 = add i32 %op32, %op11
  br label %label26
label26:                                                ; preds = %label21, %label27
  %op35 = phi i32 [ %op24, %label21 ], [ %op32, %label27 ]
  %op36 = phi i32 [ %op34, %label21 ], [ %op30, %label27 ]
  br label %label6
label27:                                                ; preds = %label9
  %op30 = add i32 %op34, %op11
  br label %label26
}
