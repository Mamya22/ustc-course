; ModuleID = 'cminus'
source_filename = "/home/mamya/CompileLab/2024ustc-jianmu-compiler/tests/testcases_general/14-while_stmt.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define void @main() {
label_entry:
  br label %label2
label2:                                                ; preds = %label_entry, %label5
  %op10 = phi i32 [ 10, %label_entry ], [ %op7, %label5 ]
  %op4 = icmp ne i32 %op10, 0
  br i1 %op4, label %label5, label %label9
label5:                                                ; preds = %label2
  %op7 = sub i32 %op10, 1
  br label %label2
label9:                                                ; preds = %label2
  ret void
}
