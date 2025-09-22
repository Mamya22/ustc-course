; ModuleID = 'cminus'
source_filename = "/home/zox/compiler/2024ustc-jianmu-compiler-ta/tests/4-mem2reg/performance-cases/testcase-3.cminus"

@matrix = global [20000000 x i32] zeroinitializer
@ad = global [100000 x i32] zeroinitializer
@len = global i32 zeroinitializer
declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define void @readarray() {
label_entry:
  br label %label0
label0:                                                ; preds = %label_entry, %label11
  %op1 = phi i32 [ 0, %label_entry ], [ %op13, %label11 ]
  %op2 = load i32, i32* @len
  %op3 = icmp slt i32 %op1, %op2
  %op4 = zext i1 %op3 to i32
  %op5 = icmp ne i32 %op4, 0
  br i1 %op5, label %label6, label %label9
label6:                                                ; preds = %label0
  %op7 = call i32 @input()
  %op8 = icmp slt i32 %op1, 0
  br i1 %op8, label %label10, label %label11
label9:                                                ; preds = %label0
  ret void
label10:                                                ; preds = %label6
  call void @neg_idx_except()
  ret void
label11:                                                ; preds = %label6
  %op12 = getelementptr [100000 x i32], [100000 x i32]* @ad, i32 0, i32 %op1
  store i32 %op7, i32* %op12
  %op13 = add i32 %op1, 1
  br label %label0
}
define i32 @transpose(i32 %arg0, i32* %arg1, i32 %arg2) {
label_entry:
  %op3 = sdiv i32 %arg0, %arg2
  br label %label4
label4:                                                ; preds = %label_entry, %label21
  %op5 = phi i32 [ 0, %label_entry ], [ %op22, %label21 ]
  %op6 = icmp slt i32 %op5, %op3
  %op7 = zext i1 %op6 to i32
  %op8 = icmp ne i32 %op7, 0
  br i1 %op8, label %label9, label %label10
label9:                                                ; preds = %label4
  br label %label12
label10:                                                ; preds = %label4
  %op11 = sub i32 0, 1
  ret i32 %op11
label12:                                                ; preds = %label9, %label25
  %op13 = phi i32 [ 0, %label9 ], [ %op26, %label25 ]
  %op14 = icmp slt i32 %op13, %arg2
  %op15 = zext i1 %op14 to i32
  %op16 = icmp ne i32 %op15, 0
  br i1 %op16, label %label17, label %label21
label17:                                                ; preds = %label12
  %op18 = icmp slt i32 %op5, %op13
  %op19 = zext i1 %op18 to i32
  %op20 = icmp ne i32 %op19, 0
  br i1 %op20, label %label23, label %label27
label21:                                                ; preds = %label12
  %op22 = add i32 %op5, 1
  br label %label4
label23:                                                ; preds = %label17
  %op24 = add i32 %op13, 1
  br label %label25
label25:                                                ; preds = %label23, %label52
  %op26 = phi i32 [ %op24, %label23 ], [ %op54, %label52 ]
  br label %label12
label27:                                                ; preds = %label17
  %op28 = mul i32 %op5, %arg2
  %op29 = add i32 %op28, %op13
  %op30 = icmp slt i32 %op29, 0
  br i1 %op30, label %label31, label %label32
label31:                                                ; preds = %label27
  call void @neg_idx_except()
  ret i32 0
label32:                                                ; preds = %label27
  %op33 = getelementptr i32, i32* %arg1, i32 %op29
  %op34 = load i32, i32* %op33
  %op35 = mul i32 %op5, %arg2
  %op36 = add i32 %op35, %op13
  %op37 = icmp slt i32 %op36, 0
  br i1 %op37, label %label38, label %label39
label38:                                                ; preds = %label32
  call void @neg_idx_except()
  ret i32 0
label39:                                                ; preds = %label32
  %op40 = getelementptr i32, i32* %arg1, i32 %op36
  %op41 = load i32, i32* %op40
  %op42 = mul i32 %op13, %op3
  %op43 = add i32 %op42, %op5
  %op44 = icmp slt i32 %op43, 0
  br i1 %op44, label %label45, label %label46
label45:                                                ; preds = %label39
  call void @neg_idx_except()
  ret i32 0
label46:                                                ; preds = %label39
  %op47 = getelementptr i32, i32* %arg1, i32 %op43
  store i32 %op41, i32* %op47
  %op48 = mul i32 %op5, %arg2
  %op49 = add i32 %op48, %op13
  %op50 = icmp slt i32 %op49, 0
  br i1 %op50, label %label51, label %label52
label51:                                                ; preds = %label46
  call void @neg_idx_except()
  ret i32 0
label52:                                                ; preds = %label46
  %op53 = getelementptr i32, i32* %arg1, i32 %op49
  store i32 %op34, i32* %op53
  %op54 = add i32 %op13, 1
  br label %label25
}
define i32 @main() {
label_entry:
  %op0 = call i32 @input()
  %op1 = call i32 @input()
  store i32 %op1, i32* @len
  call void @readarray()
  br label %label2
label2:                                                ; preds = %label_entry, %label11
  %op3 = phi i32 [ 0, %label_entry ], [ %op13, %label11 ]
  %op4 = icmp slt i32 %op3, %op0
  %op5 = zext i1 %op4 to i32
  %op6 = icmp ne i32 %op5, 0
  br i1 %op6, label %label7, label %label9
label7:                                                ; preds = %label2
  %op8 = icmp slt i32 %op3, 0
  br i1 %op8, label %label10, label %label11
label9:                                                ; preds = %label2
  br label %label14
label10:                                                ; preds = %label7
  call void @neg_idx_except()
  ret i32 0
label11:                                                ; preds = %label7
  %op12 = getelementptr [20000000 x i32], [20000000 x i32]* @matrix, i32 0, i32 %op3
  store i32 %op3, i32* %op12
  %op13 = add i32 %op3, 1
  br label %label2
label14:                                                ; preds = %label9, %label25
  %op15 = phi i32 [ 0, %label9 ], [ %op29, %label25 ]
  %op16 = load i32, i32* @len
  %op17 = icmp slt i32 %op15, %op16
  %op18 = zext i1 %op17 to i32
  %op19 = icmp ne i32 %op18, 0
  br i1 %op19, label %label20, label %label23
label20:                                                ; preds = %label14
  %op21 = getelementptr [20000000 x i32], [20000000 x i32]* @matrix, i32 0, i32 0
  %op22 = icmp slt i32 %op15, 0
  br i1 %op22, label %label24, label %label25
label23:                                                ; preds = %label14
  br label %label30
label24:                                                ; preds = %label20
  call void @neg_idx_except()
  ret i32 0
label25:                                                ; preds = %label20
  %op26 = getelementptr [100000 x i32], [100000 x i32]* @ad, i32 0, i32 %op15
  %op27 = load i32, i32* %op26
  %op28 = call i32 @transpose(i32 %op0, i32* %op21, i32 %op27)
  %op29 = add i32 %op15, 1
  br label %label14
label30:                                                ; preds = %label23, %label45
  %op31 = phi i32 [ 0, %label23 ], [ %op49, %label45 ]
  %op32 = phi i32 [ 0, %label23 ], [ %op50, %label45 ]
  %op33 = load i32, i32* @len
  %op34 = icmp slt i32 %op32, %op33
  %op35 = zext i1 %op34 to i32
  %op36 = icmp ne i32 %op35, 0
  br i1 %op36, label %label37, label %label40
label37:                                                ; preds = %label30
  %op38 = mul i32 %op32, %op32
  %op39 = icmp slt i32 %op32, 0
  br i1 %op39, label %label44, label %label45
label40:                                                ; preds = %label30
  %op41 = icmp slt i32 %op31, 0
  %op42 = zext i1 %op41 to i32
  %op43 = icmp ne i32 %op42, 0
  br i1 %op43, label %label51, label %label53
label44:                                                ; preds = %label37
  call void @neg_idx_except()
  ret i32 0
label45:                                                ; preds = %label37
  %op46 = getelementptr [20000000 x i32], [20000000 x i32]* @matrix, i32 0, i32 %op32
  %op47 = load i32, i32* %op46
  %op48 = mul i32 %op38, %op47
  %op49 = add i32 %op31, %op48
  %op50 = add i32 %op32, 1
  br label %label30
label51:                                                ; preds = %label40
  %op52 = sub i32 0, %op31
  br label %label53
label53:                                                ; preds = %label40, %label51
  %op54 = phi i32 [ %op31, %label40 ], [ %op52, %label51 ]
  call void @output(i32 %op54)
  ret i32 0
}
