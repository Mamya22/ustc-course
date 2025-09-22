; ModuleID = 'cminus'
source_filename = "/home/mamya/CompileLab/2024ustc-jianmu-compiler/tests/testcases_general/20-gcd_array.cminus"

@x = global [1 x i32] zeroinitializer
@y = global [1 x i32] zeroinitializer
declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @gcd(i32 %arg0, i32 %arg1) {
label_entry:
  %op5 = icmp eq i32 %arg1, 0
  %op6 = zext i1 %op5 to i32
  %op7 = icmp sgt i32 %op6, 0
  br i1 %op7, label %label8, label %label11
label8:                                                ; preds = %label_entry
  ret i32 %arg0
label11:                                                ; preds = %label_entry
  %op16 = sdiv i32 %arg0, %arg1
  %op18 = mul i32 %op16, %arg1
  %op19 = sub i32 %arg0, %op18
  %op20 = call i32 @gcd(i32 %arg1, i32 %op19)
  ret i32 %op20
}
define i32 @funArray(i32* %arg0, i32* %arg1) {
label_entry:
  %op9 = icmp sge i32 0, 0
  br i1 %op9, label %label11, label %label10
label10:                                                ; preds = %label_entry
  call void @neg_idx_except()
  br label %label14
label11:                                                ; preds = %label_entry
  %op12 = getelementptr i32, i32* %arg0, i32 0
  %op13 = load i32, i32* %op12
  br label %label14
label14:                                                ; preds = %label11, %label10
  %op16 = icmp sge i32 0, 0
  br i1 %op16, label %label18, label %label17
label17:                                                ; preds = %label14
  call void @neg_idx_except()
  br label %label21
label18:                                                ; preds = %label14
  %op19 = getelementptr i32, i32* %arg1, i32 0
  %op20 = load i32, i32* %op19
  br label %label21
label21:                                                ; preds = %label18, %label17
  %op25 = icmp slt i32 %op13, %op20
  %op26 = zext i1 %op25 to i32
  %op27 = icmp sgt i32 %op26, 0
  br i1 %op27, label %label28, label %label35
label28:                                                ; preds = %label21
  br label %label35
label35:                                                ; preds = %label21, %label28
  %op39 = phi i32 [ %op20, %label21 ], [ %op13, %label28 ]
  %op40 = phi i32 [ %op13, %label21 ], [ %op20, %label28 ]
  %op38 = call i32 @gcd(i32 %op40, i32 %op39)
  ret i32 %op38
}
define i32 @main() {
label_entry:
  %op0 = icmp sge i32 0, 0
  br i1 %op0, label %label2, label %label1
label1:                                                ; preds = %label_entry
  call void @neg_idx_except()
  br label %label5
label2:                                                ; preds = %label_entry
  %op3 = getelementptr [1 x i32], [1 x i32]* @x, i32 0, i32 0
  br label %label5
label5:                                                ; preds = %label2, %label1
  store i32 90, i32* %op3
  %op6 = icmp sge i32 0, 0
  br i1 %op6, label %label8, label %label7
label7:                                                ; preds = %label5
  call void @neg_idx_except()
  br label %label11
label8:                                                ; preds = %label5
  %op9 = getelementptr [1 x i32], [1 x i32]* @y, i32 0, i32 0
  br label %label11
label11:                                                ; preds = %label8, %label7
  store i32 18, i32* %op9
  %op12 = getelementptr [1 x i32], [1 x i32]* @x, i32 0, i32 0
  %op13 = getelementptr [1 x i32], [1 x i32]* @y, i32 0, i32 0
  %op14 = call i32 @funArray(i32* %op12, i32* %op13)
  ret i32 %op14
}
