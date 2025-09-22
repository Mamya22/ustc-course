# Global variables
	.text
	.section .bss, "aw", @nobits
	.globl n
	.type n, @object
	.size n, 4
n:
	.space 4
	.globl m
	.type m, @object
	.size m, 4
m:
	.space 4
	.globl w
	.type w, @object
	.size w, 20
w:
	.space 20
	.globl v
	.type v, @object
	.size v, 20
v:
	.space 20
	.globl dp
	.type dp, @object
	.size dp, 264
dp:
	.space 264
	.text
	.globl max
	.type max, @function
max:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
	st.w $a0, $fp, -20
	st.w $a1, $fp, -24
.max_label_entry:
# %op6 = icmp sgt i32 %arg0, %arg1
	ld.w $t0, $fp, -20
	ld.w $t1, $fp, -24
	slt $t0, $t1, $t0
	st.b $t0, $fp, -25
# %op7 = zext i1 %op6 to i32
	ld.b $t0, $fp, -25
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -29
# %op8 = icmp sgt i32 %op7, 0
	ld.w $t0, $fp, -29
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -30
# br i1 %op8, label %label9, label %label12
	ld.b $t0, $fp, -30
	bnez $t0, .max_label9
	b .max_label12
.max_label9:
# ret i32 %arg0
	ld.w $a0, $fp, -20
	b max_exit
.max_label12:
# ret i32 %arg1
	ld.w $a0, $fp, -24
	b max_exit
max_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl knapsack
	.type knapsack, @function
knapsack:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -208
	st.w $a0, $fp, -20
	st.w $a1, $fp, -24
.knapsack_label_entry:
# %op6 = icmp sle i32 %arg1, 0
	ld.w $t0, $fp, -24
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -25
# %op7 = zext i1 %op6 to i32
	ld.b $t0, $fp, -25
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -29
# %op8 = icmp sgt i32 %op7, 0
	ld.w $t0, $fp, -29
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -30
# br i1 %op8, label %label9, label %label10
	ld.b $t0, $fp, -30
	bnez $t0, .knapsack_label9
	b .knapsack_label10
.knapsack_label9:
# ret i32 0
	addi.w $a0, $zero, 0
	b knapsack_exit
.knapsack_label10:
# %op12 = icmp eq i32 %arg0, 0
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -31
# %op13 = zext i1 %op12 to i32
	ld.b $t0, $fp, -31
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -35
# %op14 = icmp sgt i32 %op13, 0
	ld.w $t0, $fp, -35
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -36
# br i1 %op14, label %label15, label %label16
	ld.b $t0, $fp, -36
	bnez $t0, .knapsack_label15
	b .knapsack_label16
.knapsack_label15:
# ret i32 0
	addi.w $a0, $zero, 0
	b knapsack_exit
.knapsack_label16:
# %op18 = mul i32 %arg0, 11
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 11
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -40
# %op20 = add i32 %op18, %arg1
	ld.w $t0, $fp, -40
	ld.w $t1, $fp, -24
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -44
# %op21 = icmp sge i32 %op20, 0
	ld.w $t0, $fp, -44
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -45
# br i1 %op21, label %label23, label %label22
	ld.b $t0, $fp, -45
	bnez $t0, .knapsack_label23
	b .knapsack_label22
.knapsack_label22:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label26
	b .knapsack_label26
.knapsack_label23:
# %op24 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op20
	la.local $t0, dp
	ld.w $t1, $fp, -44
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -53
# %op25 = load i32, i32* %op24
	ld.d $t0, $fp, -53
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -57
# br label %label26
	b .knapsack_label26
.knapsack_label26:
# %op27 = icmp sge i32 %op25, 0
	ld.w $t0, $fp, -57
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -58
# %op28 = zext i1 %op27 to i32
	ld.b $t0, $fp, -58
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -62
# %op29 = icmp sgt i32 %op28, 0
	ld.w $t0, $fp, -62
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -63
# br i1 %op29, label %label30, label %label36
	ld.b $t0, $fp, -63
	bnez $t0, .knapsack_label30
	b .knapsack_label36
.knapsack_label30:
# %op32 = mul i32 %arg0, 11
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 11
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -67
# %op34 = add i32 %op32, %arg1
	ld.w $t0, $fp, -67
	ld.w $t1, $fp, -24
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -71
# %op35 = icmp sge i32 %op34, 0
	ld.w $t0, $fp, -71
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -72
# br i1 %op35, label %label42, label %label41
	ld.b $t0, $fp, -72
	bnez $t0, .knapsack_label42
	b .knapsack_label41
.knapsack_label36:
# %op39 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -76
# %op40 = icmp sge i32 %op39, 0
	ld.w $t0, $fp, -76
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -77
# br i1 %op40, label %label47, label %label46
	ld.b $t0, $fp, -77
	bnez $t0, .knapsack_label47
	b .knapsack_label46
.knapsack_label41:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label45
	b .knapsack_label45
.knapsack_label42:
# %op43 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op34
	la.local $t0, dp
	ld.w $t1, $fp, -71
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -85
# %op44 = load i32, i32* %op43
	ld.d $t0, $fp, -85
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -89
# br label %label45
	b .knapsack_label45
.knapsack_label45:
# ret i32 %op44
	ld.w $a0, $fp, -89
	b knapsack_exit
.knapsack_label46:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label50
	b .knapsack_label50
.knapsack_label47:
# %op48 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 %op39
	la.local $t0, w
	ld.w $t1, $fp, -76
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -97
# %op49 = load i32, i32* %op48
	ld.d $t0, $fp, -97
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -101
# br label %label50
	b .knapsack_label50
.knapsack_label50:
# %op51 = icmp slt i32 %arg1, %op49
	ld.w $t0, $fp, -24
	ld.w $t1, $fp, -101
	slt $t0, $t0, $t1
	st.b $t0, $fp, -102
# %op52 = zext i1 %op51 to i32
	ld.b $t0, $fp, -102
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -106
# %op53 = icmp sgt i32 %op52, 0
	ld.w $t0, $fp, -106
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -107
# br i1 %op53, label %label54, label %label67
	ld.b $t0, $fp, -107
	bnez $t0, .knapsack_label54
	b .knapsack_label67
.knapsack_label54:
# %op56 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -111
# %op58 = call i32 @knapsack(i32 %op56, i32 %arg1)
	ld.w $a0, $fp, -111
	ld.w $a1, $fp, -24
	bl knapsack
	st.w $a0, $fp, -115
# br label %label60
	ld.w $a0, $fp, -115
	st.w $a0, $fp, -119
	b .knapsack_label60
.knapsack_label60:
# %op102 = phi i32 [ %op58, %label54 ], [ %op94, %label92 ]
# %op63 = mul i32 %arg0, 11
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 11
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -123
# %op65 = add i32 %op63, %arg1
	ld.w $t0, $fp, -123
	ld.w $t1, $fp, -24
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -127
# %op66 = icmp sge i32 %op65, 0
	ld.w $t0, $fp, -127
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -128
# br i1 %op66, label %label97, label %label96
	ld.b $t0, $fp, -128
	bnez $t0, .knapsack_label97
	b .knapsack_label96
.knapsack_label67:
# %op69 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -132
# %op71 = call i32 @knapsack(i32 %op69, i32 %arg1)
	ld.w $a0, $fp, -132
	ld.w $a1, $fp, -24
	bl knapsack
	st.w $a0, $fp, -136
# %op73 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -140
# %op76 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -144
# %op77 = icmp sge i32 %op76, 0
	ld.w $t0, $fp, -144
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -145
# br i1 %op77, label %label79, label %label78
	ld.b $t0, $fp, -145
	bnez $t0, .knapsack_label79
	b .knapsack_label78
.knapsack_label78:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label82
	b .knapsack_label82
.knapsack_label79:
# %op80 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 %op76
	la.local $t0, w
	ld.w $t1, $fp, -144
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -153
# %op81 = load i32, i32* %op80
	ld.d $t0, $fp, -153
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -157
# br label %label82
	b .knapsack_label82
.knapsack_label82:
# %op83 = sub i32 %arg1, %op81
	ld.w $t0, $fp, -24
	ld.w $t1, $fp, -157
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -161
# %op84 = call i32 @knapsack(i32 %op73, i32 %op83)
	ld.w $a0, $fp, -140
	ld.w $a1, $fp, -161
	bl knapsack
	st.w $a0, $fp, -165
# %op86 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -169
# %op87 = icmp sge i32 %op86, 0
	ld.w $t0, $fp, -169
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -170
# br i1 %op87, label %label89, label %label88
	ld.b $t0, $fp, -170
	bnez $t0, .knapsack_label89
	b .knapsack_label88
.knapsack_label88:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label92
	b .knapsack_label92
.knapsack_label89:
# %op90 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 %op86
	la.local $t0, v
	ld.w $t1, $fp, -169
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -178
# %op91 = load i32, i32* %op90
	ld.d $t0, $fp, -178
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -182
# br label %label92
	b .knapsack_label92
.knapsack_label92:
# %op93 = add i32 %op84, %op91
	ld.w $t0, $fp, -165
	ld.w $t1, $fp, -182
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -186
# %op94 = call i32 @max(i32 %op71, i32 %op93)
	ld.w $a0, $fp, -136
	ld.w $a1, $fp, -186
	bl max
	st.w $a0, $fp, -190
# br label %label60
	ld.w $a0, $fp, -190
	st.w $a0, $fp, -119
	b .knapsack_label60
.knapsack_label96:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label100
	b .knapsack_label100
.knapsack_label97:
# %op98 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op65
	la.local $t0, dp
	ld.w $t1, $fp, -127
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -198
# br label %label100
	b .knapsack_label100
.knapsack_label100:
# store i32 %op102, i32* %op98
	ld.d $t0, $fp, -198
	ld.w $t1, $fp, -119
	st.w $t1, $t0, 0
# ret i32 %op102
	ld.w $a0, $fp, -119
	b knapsack_exit
knapsack_exit:
	addi.d $sp, $sp, 208
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -160
.main_label_entry:
# store i32 5, i32* @n
	la.local $t0, n
	addi.w $t1, $zero, 5
	st.w $t1, $t0, 0
# store i32 10, i32* @m
	la.local $t0, m
	addi.w $t1, $zero, 10
	st.w $t1, $t0, 0
# %op4 = icmp sge i32 0, 0
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -17
# br i1 %op4, label %label6, label %label5
	ld.b $t0, $fp, -17
	bnez $t0, .main_label6
	b .main_label5
.main_label5:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label9
	b .main_label9
.main_label6:
# %op7 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 0
	la.local $t0, w
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -25
# br label %label9
	b .main_label9
.main_label9:
# store i32 2, i32* %op7
	ld.d $t0, $fp, -25
	addi.w $t1, $zero, 2
	st.w $t1, $t0, 0
# %op10 = icmp sge i32 1, 0
	addi.w $t0, $zero, 1
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -26
# br i1 %op10, label %label12, label %label11
	ld.b $t0, $fp, -26
	bnez $t0, .main_label12
	b .main_label11
.main_label11:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label15
	b .main_label15
.main_label12:
# %op13 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 1
	la.local $t0, w
	addi.w $t1, $zero, 1
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -34
# br label %label15
	b .main_label15
.main_label15:
# store i32 2, i32* %op13
	ld.d $t0, $fp, -34
	addi.w $t1, $zero, 2
	st.w $t1, $t0, 0
# %op16 = icmp sge i32 2, 0
	addi.w $t0, $zero, 2
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -35
# br i1 %op16, label %label18, label %label17
	ld.b $t0, $fp, -35
	bnez $t0, .main_label18
	b .main_label17
.main_label17:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label21
	b .main_label21
.main_label18:
# %op19 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 2
	la.local $t0, w
	addi.w $t1, $zero, 2
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -43
# br label %label21
	b .main_label21
.main_label21:
# store i32 6, i32* %op19
	ld.d $t0, $fp, -43
	addi.w $t1, $zero, 6
	st.w $t1, $t0, 0
# %op22 = icmp sge i32 3, 0
	addi.w $t0, $zero, 3
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -44
# br i1 %op22, label %label24, label %label23
	ld.b $t0, $fp, -44
	bnez $t0, .main_label24
	b .main_label23
.main_label23:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label27
	b .main_label27
.main_label24:
# %op25 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 3
	la.local $t0, w
	addi.w $t1, $zero, 3
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -52
# br label %label27
	b .main_label27
.main_label27:
# store i32 5, i32* %op25
	ld.d $t0, $fp, -52
	addi.w $t1, $zero, 5
	st.w $t1, $t0, 0
# %op28 = icmp sge i32 4, 0
	addi.w $t0, $zero, 4
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -53
# br i1 %op28, label %label30, label %label29
	ld.b $t0, $fp, -53
	bnez $t0, .main_label30
	b .main_label29
.main_label29:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label33
	b .main_label33
.main_label30:
# %op31 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 4
	la.local $t0, w
	addi.w $t1, $zero, 4
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -61
# br label %label33
	b .main_label33
.main_label33:
# store i32 4, i32* %op31
	ld.d $t0, $fp, -61
	addi.w $t1, $zero, 4
	st.w $t1, $t0, 0
# %op34 = icmp sge i32 0, 0
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -62
# br i1 %op34, label %label36, label %label35
	ld.b $t0, $fp, -62
	bnez $t0, .main_label36
	b .main_label35
.main_label35:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label39
	b .main_label39
.main_label36:
# %op37 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 0
	la.local $t0, v
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -70
# br label %label39
	b .main_label39
.main_label39:
# store i32 6, i32* %op37
	ld.d $t0, $fp, -70
	addi.w $t1, $zero, 6
	st.w $t1, $t0, 0
# %op40 = icmp sge i32 1, 0
	addi.w $t0, $zero, 1
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -71
# br i1 %op40, label %label42, label %label41
	ld.b $t0, $fp, -71
	bnez $t0, .main_label42
	b .main_label41
.main_label41:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label45
	b .main_label45
.main_label42:
# %op43 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 1
	la.local $t0, v
	addi.w $t1, $zero, 1
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -79
# br label %label45
	b .main_label45
.main_label45:
# store i32 3, i32* %op43
	ld.d $t0, $fp, -79
	addi.w $t1, $zero, 3
	st.w $t1, $t0, 0
# %op46 = icmp sge i32 2, 0
	addi.w $t0, $zero, 2
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -80
# br i1 %op46, label %label48, label %label47
	ld.b $t0, $fp, -80
	bnez $t0, .main_label48
	b .main_label47
.main_label47:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label51
	b .main_label51
.main_label48:
# %op49 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 2
	la.local $t0, v
	addi.w $t1, $zero, 2
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -88
# br label %label51
	b .main_label51
.main_label51:
# store i32 5, i32* %op49
	ld.d $t0, $fp, -88
	addi.w $t1, $zero, 5
	st.w $t1, $t0, 0
# %op52 = icmp sge i32 3, 0
	addi.w $t0, $zero, 3
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -89
# br i1 %op52, label %label54, label %label53
	ld.b $t0, $fp, -89
	bnez $t0, .main_label54
	b .main_label53
.main_label53:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label57
	b .main_label57
.main_label54:
# %op55 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 3
	la.local $t0, v
	addi.w $t1, $zero, 3
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -97
# br label %label57
	b .main_label57
.main_label57:
# store i32 4, i32* %op55
	ld.d $t0, $fp, -97
	addi.w $t1, $zero, 4
	st.w $t1, $t0, 0
# %op58 = icmp sge i32 4, 0
	addi.w $t0, $zero, 4
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -98
# br i1 %op58, label %label60, label %label59
	ld.b $t0, $fp, -98
	bnez $t0, .main_label60
	b .main_label59
.main_label59:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label63
	b .main_label63
.main_label60:
# %op61 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 4
	la.local $t0, v
	addi.w $t1, $zero, 4
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -106
# br label %label63
	b .main_label63
.main_label63:
# store i32 6, i32* %op61
	ld.d $t0, $fp, -106
	addi.w $t1, $zero, 6
	st.w $t1, $t0, 0
# br label %label86
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -145
	b .main_label86
.main_label64:
# %op85 = phi i32 [ %op83, %label81 ], [ %op87, %label86 ]
# %op66 = icmp slt i32 %op85, 66
	ld.w $t0, $fp, -110
	addi.w $t1, $zero, 66
	slt $t0, $t0, $t1
	st.b $t0, $fp, -111
# %op67 = zext i1 %op66 to i32
	ld.b $t0, $fp, -111
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -115
# %op68 = icmp ne i32 %op67, 0
	ld.w $t0, $fp, -115
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -116
# br i1 %op68, label %label69, label %label73
	ld.b $t0, $fp, -116
	bnez $t0, .main_label69
	b .main_label73
.main_label69:
# %op72 = icmp sge i32 %op85, 0
	ld.w $t0, $fp, -110
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -117
# br i1 %op72, label %label78, label %label77
	ld.b $t0, $fp, -117
	bnez $t0, .main_label78
	b .main_label77
.main_label73:
# %op74 = load i32, i32* @n
	la.local $t0, n
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -121
# %op75 = load i32, i32* @m
	la.local $t0, m
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -125
# %op76 = call i32 @knapsack(i32 %op74, i32 %op75)
	ld.w $a0, $fp, -121
	ld.w $a1, $fp, -125
	bl knapsack
	st.w $a0, $fp, -129
# call void @output(i32 %op76)
	ld.w $a0, $fp, -129
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label77:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label81
	b .main_label81
.main_label78:
# %op79 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op85
	la.local $t0, dp
	ld.w $t1, $fp, -110
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -137
# br label %label81
	b .main_label81
.main_label81:
# store i32 %op70, i32* %op79
	ld.d $t0, $fp, -137
	ld.w $t1, $fp, -149
	st.w $t1, $t0, 0
# %op83 = add i32 %op85, 1
	ld.w $t0, $fp, -110
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -141
# br label %label64
	ld.w $a0, $fp, -141
	st.w $a0, $fp, -110
	b .main_label64
.main_label86:
# %op87 = phi i32 [ 0, %label63 ]
# %op70 = sub i32 0, 1
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -149
# br label %label64
	ld.w $a0, $fp, -145
	st.w $a0, $fp, -110
	b .main_label64
main_exit:
	addi.d $sp, $sp, 160
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
