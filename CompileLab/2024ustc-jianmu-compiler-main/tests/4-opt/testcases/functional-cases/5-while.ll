; ModuleID = 'cminus'
source_filename = "/home/mamya/CompileLab/2024ustc-jianmu-compiler/tests/4-opt/testcases/functional-cases/5-while.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  br label %label4
label4:                                                ; preds = %label10, %label17, %label17
  br i1 %op9, label %label10, label %label15
label10:                                                ; preds = %label4
  br label %label4
label15:                                                ; preds = %label4
  ret i32 0
label17:                                                ; preds = %label_entry
  %op7 = icmp slt i32 0, 10
  %op8 = zext i1 %op7 to i32
  %op9 = icmp ne i32 %op8, 0
  call void @output(i32 0)
  br label %label4
}
