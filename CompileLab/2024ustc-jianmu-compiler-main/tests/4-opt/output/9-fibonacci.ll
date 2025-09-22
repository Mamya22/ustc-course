; ModuleID = 'cminus'
source_filename = "/home/mamya/CompileLab/2024ustc-jianmu-compiler/tests/4-opt/testcases/functional-cases/9-fibonacci.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @fibonacci(i32 %arg0) {
label_entry:
  %op3 = icmp eq i32 %arg0, 0
  %op4 = zext i1 %op3 to i32
  %op5 = icmp sgt i32 %op4, 0
  br i1 %op5, label %label6, label %label8
label6:                                                ; preds = %label_entry
  ret i32 0
label8:                                                ; preds = %label_entry
  %op10 = icmp eq i32 %arg0, 1
  %op11 = zext i1 %op10 to i32
  %op12 = icmp sgt i32 %op11, 0
  br i1 %op12, label %label13, label %label15
label13:                                                ; preds = %label8
  ret i32 1
label15:                                                ; preds = %label8
  %op17 = sub i32 %arg0, 1
  %op18 = call i32 @fibonacci(i32 %op17)
  %op20 = sub i32 %arg0, 2
  %op21 = call i32 @fibonacci(i32 %op20)
  %op22 = add i32 %op18, %op21
  ret i32 %op22
}
define i32 @main() {
label_entry:
  br label %label4
label4:                                                ; preds = %label_entry, %label10
  %op17 = phi i32 [ 0, %label_entry ], [ %op14, %label10 ]
  %op7 = icmp slt i32 %op17, 10
  %op8 = zext i1 %op7 to i32
  %op9 = icmp ne i32 %op8, 0
  br i1 %op9, label %label10, label %label16
label10:                                                ; preds = %label4
  %op12 = call i32 @fibonacci(i32 %op17)
  call void @output(i32 %op12)
  %op14 = add i32 %op17, 1
  br label %label4
label16:                                                ; preds = %label4
  ret i32 0
}
