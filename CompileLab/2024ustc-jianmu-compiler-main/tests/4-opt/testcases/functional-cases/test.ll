; ModuleID = 'cminus'
source_filename = "/home/mamya/CompileLab/2024ustc-jianmu-compiler/tests/4-opt/testcases/functional-cases/8-store.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @store(i32* %arg0, i32 %arg1, i32 %arg2) {
label_entry:
  %op9 = icmp sge i32 %arg1, 0
  br i1 %op9, label %label11, label %label10
label10:                                                ; preds = %label_entry
  call void @neg_idx_except()
  br label %label14
label11:                                                ; preds = %label_entry
  %op12 = getelementptr i32, i32* %arg0, i32 %arg1
  br label %label14
label14:                                                ; preds = %label11, %label10
  store i32 %arg2, i32* %op12
  ret i32 %arg2
}
define i32 @main() {
label_entry:
  %op0 = alloca [10 x i32]
  br label %label45
label4:                                                ; preds = %label9, %label45
  %op42 = phi i32 [ %op16, %label9 ], [ %op46, %label45 ]
  %op6 = icmp slt i32 %op42, 10
  %op7 = zext i1 %op6 to i32
  %op8 = icmp ne i32 %op7, 0
  br i1 %op8, label %label9, label %label18
label9:                                                ; preds = %label4
  %op13 = mul i32 %op42, 2
  %op14 = call i32 @store(i32* %op10, i32 %op42, i32 %op13)
  %op16 = add i32 %op42, 1
  br label %label4
label18:                                                ; preds = %label4
  br label %label21
label21:                                                ; preds = %label18, %label36
  %op43 = phi i32 [ 0, %label18 ], [ %op37, %label36 ]
  %op44 = phi i32 [ 0, %label18 ], [ %op40, %label36 ]
  %op23 = icmp slt i32 %op44, 10
  %op24 = zext i1 %op23 to i32
  %op25 = icmp ne i32 %op24, 0
  br i1 %op25, label %label26, label %label30
label26:                                                ; preds = %label21
  %op29 = icmp sge i32 %op44, 0
  br i1 %op29, label %label33, label %label32
label30:                                                ; preds = %label21
  call void @output(i32 %op43)
  ret i32 0
label32:                                                ; preds = %label26
  call void @neg_idx_except()
  br label %label36
label33:                                                ; preds = %label26
  %op34 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 %op44
  %op35 = load i32, i32* %op34
  br label %label36
label36:                                                ; preds = %label33, %label32
  %op37 = add i32 %op43, %op35
  %op40 = add i32 %op44, 1
  br label %label21
label45:                                                ; preds = %label_entry%label_entry
  %op46 = phi i32 [ 0, %label_entry ]
  %op10 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
  br label %label4
}
