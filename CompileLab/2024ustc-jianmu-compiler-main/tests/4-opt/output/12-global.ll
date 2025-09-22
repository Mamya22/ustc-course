; ModuleID = 'cminus'
source_filename = "/home/mamya/CompileLab/2024ustc-jianmu-compiler/tests/4-opt/testcases/functional-cases/12-global.cminus"

@seed = global i32 zeroinitializer
declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @randomLCG() {
label_entry:
  %op0 = load i32, i32* @seed
  %op1 = mul i32 %op0, 1103515245
  %op2 = add i32 %op1, 12345
  store i32 %op2, i32* @seed
  %op4 = load i32, i32* @seed
  ret i32 %op4
}
define i32 @randBin() {
label_entry:
  %op0 = call i32 @randomLCG()
  %op1 = icmp sgt i32 %op0, 0
  %op2 = zext i1 %op1 to i32
  %op3 = icmp sgt i32 %op2, 0
  br i1 %op3, label %label4, label %label6
label4:                                                ; preds = %label_entry
  ret i32 1
label6:                                                ; preds = %label_entry
  ret i32 0
}
define i32 @returnToZeroSteps() {
label_entry:
  br label %label4
label4:                                                ; preds = %label_entry, %label31
  %op32 = phi i32 [ 0, %label_entry ], [ %op19, %label31 ]
  %op33 = phi i32 [ 0, %label_entry ], [ %op34, %label31 ]
  %op6 = icmp slt i32 %op32, 20
  %op7 = zext i1 %op6 to i32
  %op8 = icmp ne i32 %op7, 0
  br i1 %op8, label %label9, label %label12
label9:                                                ; preds = %label4
  %op10 = call i32 @randBin()
  %op11 = icmp sgt i32 %op10, 0
  br i1 %op11, label %label13, label %label25
label12:                                                ; preds = %label4
  ret i32 20
label13:                                                ; preds = %label9
  %op15 = add i32 %op33, 1
  br label %label17
label17:                                                ; preds = %label13, %label25
  %op34 = phi i32 [ %op15, %label13 ], [ %op27, %label25 ]
  %op19 = add i32 %op32, 1
  %op22 = icmp eq i32 %op34, 0
  %op23 = zext i1 %op22 to i32
  %op24 = icmp sgt i32 %op23, 0
  br i1 %op24, label %label29, label %label31
label25:                                                ; preds = %label9
  %op27 = sub i32 %op33, 1
  br label %label17
label29:                                                ; preds = %label17
  ret i32 %op19
label31:                                                ; preds = %label17
  br label %label4
}
define i32 @main() {
label_entry:
  store i32 3407, i32* @seed
  br label %label3
label3:                                                ; preds = %label_entry, %label8
  %op14 = phi i32 [ 0, %label_entry ], [ %op11, %label8 ]
  %op5 = icmp slt i32 %op14, 20
  %op6 = zext i1 %op5 to i32
  %op7 = icmp ne i32 %op6, 0
  br i1 %op7, label %label8, label %label13
label8:                                                ; preds = %label3
  %op9 = call i32 @returnToZeroSteps()
  call void @output(i32 %op9)
  %op11 = add i32 %op14, 1
  br label %label3
label13:                                                ; preds = %label3
  ret i32 0
}
