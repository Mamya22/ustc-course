; ModuleID = 'cminus'
source_filename = "/home/mamya/CompileLab/2024ustc-jianmu-compiler/tests/4-opt/testcases/functional-cases/6-array.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  %op0 = alloca [10 x i32]
  %op3 = icmp sge i32 0, 0
  br i1 %op3, label %label5, label %label4
label4:                                                ; preds = %label_entry
  call void @neg_idx_except()
  br label %label8
label5:                                                ; preds = %label_entry
  %op6 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
  br label %label8
label8:                                                ; preds = %label5, %label4
  store i32 11, i32* %op6
  %op9 = icmp sge i32 4, 0
  br i1 %op9, label %label11, label %label10
label10:                                                ; preds = %label8
  call void @neg_idx_except()
  br label %label14
label11:                                                ; preds = %label8
  %op12 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 4
  br label %label14
label14:                                                ; preds = %label11, %label10
  store i32 22, i32* %op12
  %op15 = icmp sge i32 9, 0
  br i1 %op15, label %label17, label %label16
label16:                                                ; preds = %label14
  call void @neg_idx_except()
  br label %label20
label17:                                                ; preds = %label14
  %op18 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 9
  br label %label20
label20:                                                ; preds = %label17, %label16
  store i32 33, i32* %op18
  %op21 = icmp sge i32 0, 0
  br i1 %op21, label %label23, label %label22
label22:                                                ; preds = %label20
  call void @neg_idx_except()
  br label %label26
label23:                                                ; preds = %label20
  %op24 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
  %op25 = load i32, i32* %op24
  br label %label26
label26:                                                ; preds = %label23, %label22
  call void @output(i32 %op25)
  %op27 = icmp sge i32 4, 0
  br i1 %op27, label %label29, label %label28
label28:                                                ; preds = %label26
  call void @neg_idx_except()
  br label %label32
label29:                                                ; preds = %label26
  %op30 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 4
  %op31 = load i32, i32* %op30
  br label %label32
label32:                                                ; preds = %label29, %label28
  call void @output(i32 %op31)
  %op33 = icmp sge i32 9, 0
  br i1 %op33, label %label35, label %label34
label34:                                                ; preds = %label32
  call void @neg_idx_except()
  br label %label38
label35:                                                ; preds = %label32
  %op36 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 9
  %op37 = load i32, i32* %op36
  br label %label38
label38:                                                ; preds = %label35, %label34
  call void @output(i32 %op37)
  ret i32 0
}
