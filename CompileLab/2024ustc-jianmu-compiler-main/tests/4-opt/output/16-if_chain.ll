; ModuleID = 'cminus'
source_filename = "/home/mamya/CompileLab/2024ustc-jianmu-compiler/tests/testcases_general/16-if_chain.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  %op7 = icmp sgt i32 1, 0
  br i1 %op7, label %label8, label %label11
label8:                                                ; preds = %label_entry
  %op10 = icmp sgt i32 0, 0
  br i1 %op10, label %label13, label %label16
label11:                                                ; preds = %label_entry, %label15
  %op18 = phi i32 [ 2, %label_entry ], [ %op19, %label15 ]
  ret i32 %op18
label13:                                                ; preds = %label8
  br label %label15
label15:                                                ; preds = %label13, %label16
  %op19 = phi i32 [ 4, %label13 ], [ 3, %label16 ]
  br label %label11
label16:                                                ; preds = %label8
  br label %label15
}
