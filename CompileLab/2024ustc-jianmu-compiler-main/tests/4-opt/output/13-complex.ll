; ModuleID = 'cminus'
source_filename = "/home/mamya/CompileLab/2024ustc-jianmu-compiler/tests/4-opt/testcases/functional-cases/13-complex.cminus"

@n = global i32 zeroinitializer
@m = global i32 zeroinitializer
@w = global [5 x i32] zeroinitializer
@v = global [5 x i32] zeroinitializer
@dp = global [66 x i32] zeroinitializer
declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @max(i32 %arg0, i32 %arg1) {
label_entry:
  %op6 = icmp sgt i32 %arg0, %arg1
  %op7 = zext i1 %op6 to i32
  %op8 = icmp sgt i32 %op7, 0
  br i1 %op8, label %label9, label %label12
label9:                                                ; preds = %label_entry
  ret i32 %arg0
label12:                                                ; preds = %label_entry
  ret i32 %arg1
}
define i32 @knapsack(i32 %arg0, i32 %arg1) {
label_entry:
  %op6 = icmp sle i32 %arg1, 0
  %op7 = zext i1 %op6 to i32
  %op8 = icmp sgt i32 %op7, 0
  br i1 %op8, label %label9, label %label10
label9:                                                ; preds = %label_entry
  ret i32 0
label10:                                                ; preds = %label_entry
  %op12 = icmp eq i32 %arg0, 0
  %op13 = zext i1 %op12 to i32
  %op14 = icmp sgt i32 %op13, 0
  br i1 %op14, label %label15, label %label16
label15:                                                ; preds = %label10
  ret i32 0
label16:                                                ; preds = %label10
  %op18 = mul i32 %arg0, 11
  %op20 = add i32 %op18, %arg1
  %op21 = icmp sge i32 %op20, 0
  br i1 %op21, label %label23, label %label22
label22:                                                ; preds = %label16
  call void @neg_idx_except()
  br label %label26
label23:                                                ; preds = %label16
  %op24 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op20
  %op25 = load i32, i32* %op24
  br label %label26
label26:                                                ; preds = %label23, %label22
  %op27 = icmp sge i32 %op25, 0
  %op28 = zext i1 %op27 to i32
  %op29 = icmp sgt i32 %op28, 0
  br i1 %op29, label %label30, label %label36
label30:                                                ; preds = %label26
  %op32 = mul i32 %arg0, 11
  %op34 = add i32 %op32, %arg1
  %op35 = icmp sge i32 %op34, 0
  br i1 %op35, label %label42, label %label41
label36:                                                ; preds = %label26
  %op39 = sub i32 %arg0, 1
  %op40 = icmp sge i32 %op39, 0
  br i1 %op40, label %label47, label %label46
label41:                                                ; preds = %label30
  call void @neg_idx_except()
  br label %label45
label42:                                                ; preds = %label30
  %op43 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op34
  %op44 = load i32, i32* %op43
  br label %label45
label45:                                                ; preds = %label42, %label41
  ret i32 %op44
label46:                                                ; preds = %label36
  call void @neg_idx_except()
  br label %label50
label47:                                                ; preds = %label36
  %op48 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 %op39
  %op49 = load i32, i32* %op48
  br label %label50
label50:                                                ; preds = %label47, %label46
  %op51 = icmp slt i32 %arg1, %op49
  %op52 = zext i1 %op51 to i32
  %op53 = icmp sgt i32 %op52, 0
  br i1 %op53, label %label54, label %label67
label54:                                                ; preds = %label50
  %op56 = sub i32 %arg0, 1
  %op58 = call i32 @knapsack(i32 %op56, i32 %arg1)
  br label %label60
label60:                                                ; preds = %label54, %label92
  %op102 = phi i32 [ %op58, %label54 ], [ %op94, %label92 ]
  %op63 = mul i32 %arg0, 11
  %op65 = add i32 %op63, %arg1
  %op66 = icmp sge i32 %op65, 0
  br i1 %op66, label %label97, label %label96
label67:                                                ; preds = %label50
  %op69 = sub i32 %arg0, 1
  %op71 = call i32 @knapsack(i32 %op69, i32 %arg1)
  %op73 = sub i32 %arg0, 1
  %op76 = sub i32 %arg0, 1
  %op77 = icmp sge i32 %op76, 0
  br i1 %op77, label %label79, label %label78
label78:                                                ; preds = %label67
  call void @neg_idx_except()
  br label %label82
label79:                                                ; preds = %label67
  %op80 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 %op76
  %op81 = load i32, i32* %op80
  br label %label82
label82:                                                ; preds = %label79, %label78
  %op83 = sub i32 %arg1, %op81
  %op84 = call i32 @knapsack(i32 %op73, i32 %op83)
  %op86 = sub i32 %arg0, 1
  %op87 = icmp sge i32 %op86, 0
  br i1 %op87, label %label89, label %label88
label88:                                                ; preds = %label82
  call void @neg_idx_except()
  br label %label92
label89:                                                ; preds = %label82
  %op90 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 %op86
  %op91 = load i32, i32* %op90
  br label %label92
label92:                                                ; preds = %label89, %label88
  %op93 = add i32 %op84, %op91
  %op94 = call i32 @max(i32 %op71, i32 %op93)
  br label %label60
label96:                                                ; preds = %label60
  call void @neg_idx_except()
  br label %label100
label97:                                                ; preds = %label60
  %op98 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op65
  br label %label100
label100:                                                ; preds = %label97, %label96
  store i32 %op102, i32* %op98
  ret i32 %op102
}
define i32 @main() {
label_entry:
  store i32 5, i32* @n
  store i32 10, i32* @m
  %op4 = icmp sge i32 0, 0
  br i1 %op4, label %label6, label %label5
label5:                                                ; preds = %label_entry
  call void @neg_idx_except()
  br label %label9
label6:                                                ; preds = %label_entry
  %op7 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 0
  br label %label9
label9:                                                ; preds = %label6, %label5
  store i32 2, i32* %op7
  %op10 = icmp sge i32 1, 0
  br i1 %op10, label %label12, label %label11
label11:                                                ; preds = %label9
  call void @neg_idx_except()
  br label %label15
label12:                                                ; preds = %label9
  %op13 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 1
  br label %label15
label15:                                                ; preds = %label12, %label11
  store i32 2, i32* %op13
  %op16 = icmp sge i32 2, 0
  br i1 %op16, label %label18, label %label17
label17:                                                ; preds = %label15
  call void @neg_idx_except()
  br label %label21
label18:                                                ; preds = %label15
  %op19 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 2
  br label %label21
label21:                                                ; preds = %label18, %label17
  store i32 6, i32* %op19
  %op22 = icmp sge i32 3, 0
  br i1 %op22, label %label24, label %label23
label23:                                                ; preds = %label21
  call void @neg_idx_except()
  br label %label27
label24:                                                ; preds = %label21
  %op25 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 3
  br label %label27
label27:                                                ; preds = %label24, %label23
  store i32 5, i32* %op25
  %op28 = icmp sge i32 4, 0
  br i1 %op28, label %label30, label %label29
label29:                                                ; preds = %label27
  call void @neg_idx_except()
  br label %label33
label30:                                                ; preds = %label27
  %op31 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 4
  br label %label33
label33:                                                ; preds = %label30, %label29
  store i32 4, i32* %op31
  %op34 = icmp sge i32 0, 0
  br i1 %op34, label %label36, label %label35
label35:                                                ; preds = %label33
  call void @neg_idx_except()
  br label %label39
label36:                                                ; preds = %label33
  %op37 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 0
  br label %label39
label39:                                                ; preds = %label36, %label35
  store i32 6, i32* %op37
  %op40 = icmp sge i32 1, 0
  br i1 %op40, label %label42, label %label41
label41:                                                ; preds = %label39
  call void @neg_idx_except()
  br label %label45
label42:                                                ; preds = %label39
  %op43 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 1
  br label %label45
label45:                                                ; preds = %label42, %label41
  store i32 3, i32* %op43
  %op46 = icmp sge i32 2, 0
  br i1 %op46, label %label48, label %label47
label47:                                                ; preds = %label45
  call void @neg_idx_except()
  br label %label51
label48:                                                ; preds = %label45
  %op49 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 2
  br label %label51
label51:                                                ; preds = %label48, %label47
  store i32 5, i32* %op49
  %op52 = icmp sge i32 3, 0
  br i1 %op52, label %label54, label %label53
label53:                                                ; preds = %label51
  call void @neg_idx_except()
  br label %label57
label54:                                                ; preds = %label51
  %op55 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 3
  br label %label57
label57:                                                ; preds = %label54, %label53
  store i32 4, i32* %op55
  %op58 = icmp sge i32 4, 0
  br i1 %op58, label %label60, label %label59
label59:                                                ; preds = %label57
  call void @neg_idx_except()
  br label %label63
label60:                                                ; preds = %label57
  %op61 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 4
  br label %label63
label63:                                                ; preds = %label60, %label59
  store i32 6, i32* %op61
  br label %label86
label64:                                                ; preds = %label81, %label86
  %op85 = phi i32 [ %op83, %label81 ], [ %op87, %label86 ]
  %op66 = icmp slt i32 %op85, 66
  %op67 = zext i1 %op66 to i32
  %op68 = icmp ne i32 %op67, 0
  br i1 %op68, label %label69, label %label73
label69:                                                ; preds = %label64
  %op72 = icmp sge i32 %op85, 0
  br i1 %op72, label %label78, label %label77
label73:                                                ; preds = %label64
  %op74 = load i32, i32* @n
  %op75 = load i32, i32* @m
  %op76 = call i32 @knapsack(i32 %op74, i32 %op75)
  call void @output(i32 %op76)
  ret i32 0
label77:                                                ; preds = %label69
  call void @neg_idx_except()
  br label %label81
label78:                                                ; preds = %label69
  %op79 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op85
  br label %label81
label81:                                                ; preds = %label78, %label77
  store i32 %op70, i32* %op79
  %op83 = add i32 %op85, 1
  br label %label64
label86:                                                ; preds = %label63
  %op87 = phi i32 [ 0, %label63 ]
  %op70 = sub i32 0, 1
  br label %label64
}
