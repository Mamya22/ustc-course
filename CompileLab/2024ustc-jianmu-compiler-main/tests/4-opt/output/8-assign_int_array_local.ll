; ModuleID = 'cminus'
source_filename = "/home/mamya/CompileLab/2024ustc-jianmu-compiler/tests/testcases_general/8-assign_int_array_local.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  %op0 = alloca [10 x i32]
  %op1 = icmp sge i32 3, 0
  br i1 %op1, label %label3, label %label2
label2:                                                ; preds = %label_entry
  call void @neg_idx_except()
  br label %label6
label3:                                                ; preds = %label_entry
  %op4 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 3
  br label %label6
label6:                                                ; preds = %label3, %label2
  store i32 1234, i32* %op4
  %op7 = icmp sge i32 3, 0
  br i1 %op7, label %label9, label %label8
label8:                                                ; preds = %label6
  call void @neg_idx_except()
  br label %label12
label9:                                                ; preds = %label6
  %op10 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 3
  %op11 = load i32, i32* %op10
  br label %label12
label12:                                                ; preds = %label9, %label8
  ret i32 %op11
}
