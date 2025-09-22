; ModuleID = 'cminus'
source_filename = "/home/mamya/CompileLab/2024ustc-jianmu-compiler/tests/4-opt/testcases/functional-cases/8-store.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @store(i32* %arg0, i32 %arg1, i32 %arg2) {
label_entry:
  %op3 = alloca i32*
  store i32* %arg0, i32** %op3
  %op4 = load i32*, i32** %op3
  %op5 = alloca i32
  store i32 %arg1, i32* %op5
  %op6 = alloca i32
  store i32 %arg2, i32* %op6
  %op7 = load i32, i32* %op6
  %op8 = load i32, i32* %op5
  %op9 = icmp sge i32 %op8, 0
  br i1 %op9, label %label11, label %label10
label10:                                                ; preds = %label_entry
  call void @neg_idx_except()
  br label %label14
label11:                                                ; preds = %label_entry
  %op12 = getelementptr i32, i32* %op4, i32 %op8
  %op13 = load i32, i32* %op12
  br label %label14
label14:                                                ; preds = %label11, %label10
  store i32 %op7, i32* %op12
  %op15 = load i32, i32* %op6
  ret i32 %op15
}
define i32 @main() {
label_entry:
  %op0 = alloca [10 x i32]
  %op1 = alloca i32
  %op2 = alloca i32
  %op3 = load i32, i32* %op1
  store i32 0, i32* %op1
  br label %label4
label4:                                                ; preds = %label_entry, %label9
  %op5 = load i32, i32* %op1
  %op6 = icmp slt i32 %op5, 10
  %op7 = zext i1 %op6 to i32
  %op8 = icmp ne i32 %op7, 0
  br i1 %op8, label %label9, label %label18
label9:                                                ; preds = %label4
  %op10 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
  %op11 = load i32, i32* %op1
  %op12 = load i32, i32* %op1
  %op13 = mul i32 %op12, 2
  %op14 = call i32 @store(i32* %op10, i32 %op11, i32 %op13)
  %op15 = load i32, i32* %op1
  %op16 = add i32 %op15, 1
  %op17 = load i32, i32* %op1
  store i32 %op16, i32* %op1
  br label %label4
label18:                                                ; preds = %label4
  %op19 = load i32, i32* %op2
  store i32 0, i32* %op2
  %op20 = load i32, i32* %op1
  store i32 0, i32* %op1
  br label %label21
label21:                                                ; preds = %label18, %label36
  %op22 = load i32, i32* %op1
  %op23 = icmp slt i32 %op22, 10
  %op24 = zext i1 %op23 to i32
  %op25 = icmp ne i32 %op24, 0
  br i1 %op25, label %label26, label %label30
label26:                                                ; preds = %label21
  %op27 = load i32, i32* %op2
  %op28 = load i32, i32* %op1
  %op29 = icmp sge i32 %op28, 0
  br i1 %op29, label %label33, label %label32
label30:                                                ; preds = %label21
  %op31 = load i32, i32* %op2
  call void @output(i32 %op31)
  ret i32 0
label32:                                                ; preds = %label26
  call void @neg_idx_except()
  br label %label36
label33:                                                ; preds = %label26
  %op34 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 %op28
  %op35 = load i32, i32* %op34
  br label %label36
label36:                                                ; preds = %label33, %label32
  %op37 = add i32 %op27, %op35
  %op38 = load i32, i32* %op2
  store i32 %op37, i32* %op2
  %op39 = load i32, i32* %op1
  %op40 = add i32 %op39, 1
  %op41 = load i32, i32* %op1
  store i32 %op40, i32* %op1
  br label %label21
}
