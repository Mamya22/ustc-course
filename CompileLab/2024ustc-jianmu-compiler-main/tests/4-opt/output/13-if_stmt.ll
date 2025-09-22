; ModuleID = 'cminus'
source_filename = "/home/mamya/CompileLab/2024ustc-jianmu-compiler/tests/testcases_general/13-if_stmt.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define void @main() {
label_entry:
  %op3 = icmp sgt i32 2, 0
  br i1 %op3, label %label4, label %label6
label4:                                                ; preds = %label_entry
  br label %label6
label6:                                                ; preds = %label_entry, %label4
  ret void
}
