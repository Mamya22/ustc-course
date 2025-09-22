; ModuleID = 'cminus'
source_filename = "/home/mamya/CompileLab/2024ustc-jianmu-compiler/tests/testcases_general/17-while_chain.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  br label %label3
label3:                                                ; preds = %label_entry, %label23
  %op24 = phi i32 [ %op26, %label23 ], [ undef, %label_entry ]
  %op25 = phi i32 [ 10, %label_entry ], [ %op8, %label23 ]
  %op5 = icmp ne i32 %op25, 0
  br i1 %op5, label %label6, label %label12
label6:                                                ; preds = %label3
  %op8 = sub i32 %op25, 1
  br label %label16
label12:                                                ; preds = %label3
  %op15 = add i32 %op25, %op24
  ret i32 %op15
label16:                                                ; preds = %label6, %label19
  %op26 = phi i32 [ %op8, %label6 ], [ %op21, %label19 ]
  %op18 = icmp ne i32 %op26, 0
  br i1 %op18, label %label19, label %label23
label19:                                                ; preds = %label16
  %op21 = sub i32 %op26, 1
  br label %label16
label23:                                                ; preds = %label16
  br label %label3
}
