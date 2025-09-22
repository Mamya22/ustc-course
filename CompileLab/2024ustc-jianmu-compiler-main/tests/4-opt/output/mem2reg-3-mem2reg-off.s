# Global variables
	.text
	.section .bss, "aw", @nobits
	.globl matrix
	.type matrix, @object
	.size matrix, 80000000
matrix:
	.space 80000000
	.globl ad
	.type ad, @object
	.size ad, 400000
ad:
	.space 400000
	.globl len
	.type len, @object
	.size len, 4
len:
	.space 4
	.text
	.globl readarray
	.type readarray, @function
readarray:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -80
.readarray_label_entry:
# %op0 = alloca i32
	addi.d $t0, $fp, -28
	st.d $t0, $fp, -24
# %op1 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -32
# store i32 0, i32* %op0
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# br label %label2
	b .readarray_label2
.readarray_label2:
# %op3 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -36
# %op4 = load i32, i32* @len
	la.local $t0, len
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -40
# %op5 = icmp slt i32 %op3, %op4
	ld.w $t0, $fp, -36
	ld.w $t1, $fp, -40
	slt $t0, $t0, $t1
	st.b $t0, $fp, -41
# %op6 = zext i1 %op5 to i32
	ld.b $t0, $fp, -41
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -45
# %op7 = icmp ne i32 %op6, 0
	ld.w $t0, $fp, -45
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -46
# br i1 %op7, label %label8, label %label12
	ld.b $t0, $fp, -46
	bnez $t0, .readarray_label8
	b .readarray_label12
.readarray_label8:
# %op9 = call i32 @input()
	bl input
	st.w $a0, $fp, -50
# %op10 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -54
# %op11 = icmp sge i32 %op10, 0
	ld.w $t0, $fp, -54
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -55
# br i1 %op11, label %label14, label %label13
	ld.b $t0, $fp, -55
	bnez $t0, .readarray_label14
	b .readarray_label13
.readarray_label12:
# ret void
	addi.w  $a0, $zero, 0
	b readarray_exit
.readarray_label13:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label17
	b .readarray_label17
.readarray_label14:
# %op15 = getelementptr [100000 x i32], [100000 x i32]* @ad, i32 0, i32 %op10
	la.local $t0, ad
	ld.w $t1, $fp, -54
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -63
# %op16 = load i32, i32* %op15
	ld.d $t0, $fp, -63
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -67
# br label %label17
	b .readarray_label17
.readarray_label17:
# store i32 %op9, i32* %op15
	ld.d $t0, $fp, -63
	ld.w $t1, $fp, -50
	st.w $t1, $t0, 0
# %op18 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -71
# %op19 = add i32 %op18, 1
	ld.w $t0, $fp, -71
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -75
# %op20 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -79
# store i32 %op19, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $fp, -75
	st.w $t1, $t0, 0
# br label %label2
	b .readarray_label2
readarray_exit:
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl transpose
	.type transpose, @function
transpose:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -384
	st.w $a0, $fp, -20
	st.d $a1, $fp, -28
	st.w $a2, $fp, -32
.transpose_label_entry:
# %op3 = alloca i32
	addi.d $t0, $fp, -44
	st.d $t0, $fp, -40
# store i32 %arg0, i32* %op3
	ld.d $t0, $fp, -40
	ld.w $t1, $fp, -20
	st.w $t1, $t0, 0
# %op4 = alloca i32*
	addi.d $t0, $fp, -60
	st.d $t0, $fp, -52
# store i32* %arg1, i32** %op4
	ld.d $t0, $fp, -52
	ld.d $t1, $fp, -28
	st.d $t1, $t0, 0
# %op5 = load i32*, i32** %op4
	ld.d $t0, $fp, -52
	ld.d $t0, $t0, 0
	st.d $t0, $fp, -68
# %op6 = alloca i32
	addi.d $t0, $fp, -80
	st.d $t0, $fp, -76
# store i32 %arg2, i32* %op6
	ld.d $t0, $fp, -76
	ld.w $t1, $fp, -32
	st.w $t1, $t0, 0
# %op7 = alloca i32
	addi.d $t0, $fp, -92
	st.d $t0, $fp, -88
# %op8 = alloca i32
	addi.d $t0, $fp, -104
	st.d $t0, $fp, -100
# %op9 = alloca i32
	addi.d $t0, $fp, -116
	st.d $t0, $fp, -112
# %op10 = alloca i32
	addi.d $t0, $fp, -128
	st.d $t0, $fp, -124
# %op11 = load i32, i32* %op3
	ld.d $t0, $fp, -40
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -132
# %op12 = load i32, i32* %op6
	ld.d $t0, $fp, -76
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -136
# %op13 = sdiv i32 %op11, %op12
	ld.w $t0, $fp, -132
	ld.w $t1, $fp, -136
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -140
# %op14 = load i32, i32* %op7
	ld.d $t0, $fp, -88
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -144
# store i32 %op13, i32* %op7
	ld.d $t0, $fp, -88
	ld.w $t1, $fp, -140
	st.w $t1, $t0, 0
# %op15 = load i32, i32* %op8
	ld.d $t0, $fp, -100
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -148
# store i32 0, i32* %op8
	ld.d $t0, $fp, -100
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# %op16 = load i32, i32* %op9
	ld.d $t0, $fp, -112
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -152
# store i32 0, i32* %op9
	ld.d $t0, $fp, -112
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# br label %label17
	b .transpose_label17
.transpose_label17:
# %op18 = load i32, i32* %op8
	ld.d $t0, $fp, -100
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -156
# %op19 = load i32, i32* %op7
	ld.d $t0, $fp, -88
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -160
# %op20 = icmp slt i32 %op18, %op19
	ld.w $t0, $fp, -156
	ld.w $t1, $fp, -160
	slt $t0, $t0, $t1
	st.b $t0, $fp, -161
# %op21 = zext i1 %op20 to i32
	ld.b $t0, $fp, -161
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -165
# %op22 = icmp ne i32 %op21, 0
	ld.w $t0, $fp, -165
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -166
# br i1 %op22, label %label23, label %label25
	ld.b $t0, $fp, -166
	bnez $t0, .transpose_label23
	b .transpose_label25
.transpose_label23:
# %op24 = load i32, i32* %op9
	ld.d $t0, $fp, -112
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -170
# store i32 0, i32* %op9
	ld.d $t0, $fp, -112
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# br label %label27
	b .transpose_label27
.transpose_label25:
# %op26 = sub i32 0, 1
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -174
# ret i32 %op26
	ld.w $a0, $fp, -174
	b transpose_exit
.transpose_label27:
# %op28 = load i32, i32* %op9
	ld.d $t0, $fp, -112
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -178
# %op29 = load i32, i32* %op6
	ld.d $t0, $fp, -76
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -182
# %op30 = icmp slt i32 %op28, %op29
	ld.w $t0, $fp, -178
	ld.w $t1, $fp, -182
	slt $t0, $t0, $t1
	st.b $t0, $fp, -183
# %op31 = zext i1 %op30 to i32
	ld.b $t0, $fp, -183
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -187
# %op32 = icmp ne i32 %op31, 0
	ld.w $t0, $fp, -187
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -188
# br i1 %op32, label %label33, label %label39
	ld.b $t0, $fp, -188
	bnez $t0, .transpose_label33
	b .transpose_label39
.transpose_label33:
# %op34 = load i32, i32* %op8
	ld.d $t0, $fp, -100
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -192
# %op35 = load i32, i32* %op9
	ld.d $t0, $fp, -112
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -196
# %op36 = icmp slt i32 %op34, %op35
	ld.w $t0, $fp, -192
	ld.w $t1, $fp, -196
	slt $t0, $t0, $t1
	st.b $t0, $fp, -197
# %op37 = zext i1 %op36 to i32
	ld.b $t0, $fp, -197
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -201
# %op38 = icmp sgt i32 %op37, 0
	ld.w $t0, $fp, -201
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -202
# br i1 %op38, label %label43, label %label48
	ld.b $t0, $fp, -202
	bnez $t0, .transpose_label43
	b .transpose_label48
.transpose_label39:
# %op40 = load i32, i32* %op8
	ld.d $t0, $fp, -100
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -206
# %op41 = add i32 %op40, 1
	ld.w $t0, $fp, -206
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -210
# %op42 = load i32, i32* %op8
	ld.d $t0, $fp, -100
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -214
# store i32 %op41, i32* %op8
	ld.d $t0, $fp, -100
	ld.w $t1, $fp, -210
	st.w $t1, $t0, 0
# br label %label17
	b .transpose_label17
.transpose_label43:
# %op44 = load i32, i32* %op9
	ld.d $t0, $fp, -112
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -218
# %op45 = add i32 %op44, 1
	ld.w $t0, $fp, -218
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -222
# %op46 = load i32, i32* %op9
	ld.d $t0, $fp, -112
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -226
# store i32 %op45, i32* %op9
	ld.d $t0, $fp, -112
	ld.w $t1, $fp, -222
	st.w $t1, $t0, 0
# br label %label47
	b .transpose_label47
.transpose_label47:
# br label %label27
	b .transpose_label27
.transpose_label48:
# %op49 = load i32, i32* %op8
	ld.d $t0, $fp, -100
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -230
# %op50 = load i32, i32* %op6
	ld.d $t0, $fp, -76
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -234
# %op51 = mul i32 %op49, %op50
	ld.w $t0, $fp, -230
	ld.w $t1, $fp, -234
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -238
# %op52 = load i32, i32* %op9
	ld.d $t0, $fp, -112
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -242
# %op53 = add i32 %op51, %op52
	ld.w $t0, $fp, -238
	ld.w $t1, $fp, -242
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -246
# %op54 = icmp sge i32 %op53, 0
	ld.w $t0, $fp, -246
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -247
# br i1 %op54, label %label56, label %label55
	ld.b $t0, $fp, -247
	bnez $t0, .transpose_label56
	b .transpose_label55
.transpose_label55:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label59
	b .transpose_label59
.transpose_label56:
# %op57 = getelementptr i32, i32* %op5, i32 %op53
	ld.d $t0, $fp, -68
	ld.w $t1, $fp, -246
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -255
# %op58 = load i32, i32* %op57
	ld.d $t0, $fp, -255
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -259
# br label %label59
	b .transpose_label59
.transpose_label59:
# %op60 = load i32, i32* %op10
	ld.d $t0, $fp, -124
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -263
# store i32 %op58, i32* %op10
	ld.d $t0, $fp, -124
	ld.w $t1, $fp, -259
	st.w $t1, $t0, 0
# %op61 = load i32, i32* %op8
	ld.d $t0, $fp, -100
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -267
# %op62 = load i32, i32* %op6
	ld.d $t0, $fp, -76
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -271
# %op63 = mul i32 %op61, %op62
	ld.w $t0, $fp, -267
	ld.w $t1, $fp, -271
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -275
# %op64 = load i32, i32* %op9
	ld.d $t0, $fp, -112
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -279
# %op65 = add i32 %op63, %op64
	ld.w $t0, $fp, -275
	ld.w $t1, $fp, -279
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -283
# %op66 = icmp sge i32 %op65, 0
	ld.w $t0, $fp, -283
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -284
# br i1 %op66, label %label68, label %label67
	ld.b $t0, $fp, -284
	bnez $t0, .transpose_label68
	b .transpose_label67
.transpose_label67:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label71
	b .transpose_label71
.transpose_label68:
# %op69 = getelementptr i32, i32* %op5, i32 %op65
	ld.d $t0, $fp, -68
	ld.w $t1, $fp, -283
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -292
# %op70 = load i32, i32* %op69
	ld.d $t0, $fp, -292
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -296
# br label %label71
	b .transpose_label71
.transpose_label71:
# %op72 = load i32, i32* %op9
	ld.d $t0, $fp, -112
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -300
# %op73 = load i32, i32* %op7
	ld.d $t0, $fp, -88
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -304
# %op74 = mul i32 %op72, %op73
	ld.w $t0, $fp, -300
	ld.w $t1, $fp, -304
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -308
# %op75 = load i32, i32* %op8
	ld.d $t0, $fp, -100
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -312
# %op76 = add i32 %op74, %op75
	ld.w $t0, $fp, -308
	ld.w $t1, $fp, -312
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -316
# %op77 = icmp sge i32 %op76, 0
	ld.w $t0, $fp, -316
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -317
# br i1 %op77, label %label79, label %label78
	ld.b $t0, $fp, -317
	bnez $t0, .transpose_label79
	b .transpose_label78
.transpose_label78:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label82
	b .transpose_label82
.transpose_label79:
# %op80 = getelementptr i32, i32* %op5, i32 %op76
	ld.d $t0, $fp, -68
	ld.w $t1, $fp, -316
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -325
# %op81 = load i32, i32* %op80
	ld.d $t0, $fp, -325
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -329
# br label %label82
	b .transpose_label82
.transpose_label82:
# store i32 %op70, i32* %op80
	ld.d $t0, $fp, -325
	ld.w $t1, $fp, -296
	st.w $t1, $t0, 0
# %op83 = load i32, i32* %op10
	ld.d $t0, $fp, -124
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -333
# %op84 = load i32, i32* %op8
	ld.d $t0, $fp, -100
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -337
# %op85 = load i32, i32* %op6
	ld.d $t0, $fp, -76
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -341
# %op86 = mul i32 %op84, %op85
	ld.w $t0, $fp, -337
	ld.w $t1, $fp, -341
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -345
# %op87 = load i32, i32* %op9
	ld.d $t0, $fp, -112
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -349
# %op88 = add i32 %op86, %op87
	ld.w $t0, $fp, -345
	ld.w $t1, $fp, -349
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -353
# %op89 = icmp sge i32 %op88, 0
	ld.w $t0, $fp, -353
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -354
# br i1 %op89, label %label91, label %label90
	ld.b $t0, $fp, -354
	bnez $t0, .transpose_label91
	b .transpose_label90
.transpose_label90:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label94
	b .transpose_label94
.transpose_label91:
# %op92 = getelementptr i32, i32* %op5, i32 %op88
	ld.d $t0, $fp, -68
	ld.w $t1, $fp, -353
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -362
# %op93 = load i32, i32* %op92
	ld.d $t0, $fp, -362
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -366
# br label %label94
	b .transpose_label94
.transpose_label94:
# store i32 %op83, i32* %op92
	ld.d $t0, $fp, -362
	ld.w $t1, $fp, -333
	st.w $t1, $t0, 0
# %op95 = load i32, i32* %op9
	ld.d $t0, $fp, -112
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -370
# %op96 = add i32 %op95, 1
	ld.w $t0, $fp, -370
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -374
# %op97 = load i32, i32* %op9
	ld.d $t0, $fp, -112
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -378
# store i32 %op96, i32* %op9
	ld.d $t0, $fp, -112
	ld.w $t1, $fp, -374
	st.w $t1, $t0, 0
# br label %label47
	b .transpose_label47
transpose_exit:
	addi.d $sp, $sp, 384
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -288
.main_label_entry:
# %op0 = alloca i32
	addi.d $t0, $fp, -28
	st.d $t0, $fp, -24
# %op1 = alloca i32
	addi.d $t0, $fp, -40
	st.d $t0, $fp, -36
# %op2 = alloca i32
	addi.d $t0, $fp, -52
	st.d $t0, $fp, -48
# %op3 = call i32 @input()
	bl input
	st.w $a0, $fp, -56
# %op4 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -60
# store i32 %op3, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $fp, -56
	st.w $t1, $t0, 0
# %op5 = call i32 @input()
	bl input
	st.w $a0, $fp, -64
# %op6 = load i32, i32* @len
	la.local $t0, len
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -68
# store i32 %op5, i32* @len
	la.local $t0, len
	ld.w $t1, $fp, -64
	st.w $t1, $t0, 0
# call void @readarray()
	bl readarray
# %op7 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -72
# store i32 0, i32* %op1
	ld.d $t0, $fp, -36
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# br label %label8
	b .main_label8
.main_label8:
# %op9 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -76
# %op10 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -80
# %op11 = icmp slt i32 %op9, %op10
	ld.w $t0, $fp, -76
	ld.w $t1, $fp, -80
	slt $t0, $t0, $t1
	st.b $t0, $fp, -81
# %op12 = zext i1 %op11 to i32
	ld.b $t0, $fp, -81
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -85
# %op13 = icmp ne i32 %op12, 0
	ld.w $t0, $fp, -85
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -86
# br i1 %op13, label %label14, label %label18
	ld.b $t0, $fp, -86
	bnez $t0, .main_label14
	b .main_label18
.main_label14:
# %op15 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -90
# %op16 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -94
# %op17 = icmp sge i32 %op16, 0
	ld.w $t0, $fp, -94
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -95
# br i1 %op17, label %label21, label %label20
	ld.b $t0, $fp, -95
	bnez $t0, .main_label21
	b .main_label20
.main_label18:
# %op19 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -99
# store i32 0, i32* %op1
	ld.d $t0, $fp, -36
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# br label %label28
	b .main_label28
.main_label20:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label24
	b .main_label24
.main_label21:
# %op22 = getelementptr [20000000 x i32], [20000000 x i32]* @matrix, i32 0, i32 %op16
	la.local $t0, matrix
	ld.w $t1, $fp, -94
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -107
# %op23 = load i32, i32* %op22
	ld.d $t0, $fp, -107
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -111
# br label %label24
	b .main_label24
.main_label24:
# store i32 %op15, i32* %op22
	ld.d $t0, $fp, -107
	ld.w $t1, $fp, -90
	st.w $t1, $t0, 0
# %op25 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -115
# %op26 = add i32 %op25, 1
	ld.w $t0, $fp, -115
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -119
# %op27 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -123
# store i32 %op26, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t1, $fp, -119
	st.w $t1, $t0, 0
# br label %label8
	b .main_label8
.main_label28:
# %op29 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -127
# %op30 = load i32, i32* @len
	la.local $t0, len
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -131
# %op31 = icmp slt i32 %op29, %op30
	ld.w $t0, $fp, -127
	ld.w $t1, $fp, -131
	slt $t0, $t0, $t1
	st.b $t0, $fp, -132
# %op32 = zext i1 %op31 to i32
	ld.b $t0, $fp, -132
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -136
# %op33 = icmp ne i32 %op32, 0
	ld.w $t0, $fp, -136
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -137
# br i1 %op33, label %label34, label %label39
	ld.b $t0, $fp, -137
	bnez $t0, .main_label34
	b .main_label39
.main_label34:
# %op35 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -141
# %op36 = getelementptr [20000000 x i32], [20000000 x i32]* @matrix, i32 0, i32 0
	la.local $t0, matrix
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -149
# %op37 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -153
# %op38 = icmp sge i32 %op37, 0
	ld.w $t0, $fp, -153
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -154
# br i1 %op38, label %label43, label %label42
	ld.b $t0, $fp, -154
	bnez $t0, .main_label43
	b .main_label42
.main_label39:
# %op40 = load i32, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -158
# store i32 0, i32* %op2
	ld.d $t0, $fp, -48
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# %op41 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -162
# store i32 0, i32* %op1
	ld.d $t0, $fp, -36
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# br label %label51
	b .main_label51
.main_label42:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label46
	b .main_label46
.main_label43:
# %op44 = getelementptr [100000 x i32], [100000 x i32]* @ad, i32 0, i32 %op37
	la.local $t0, ad
	ld.w $t1, $fp, -153
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -170
# %op45 = load i32, i32* %op44
	ld.d $t0, $fp, -170
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -174
# br label %label46
	b .main_label46
.main_label46:
# %op47 = call i32 @transpose(i32 %op35, i32* %op36, i32 %op45)
	ld.w $a0, $fp, -141
	ld.d $a1, $fp, -149
	ld.w $a2, $fp, -174
	bl transpose
	st.w $a0, $fp, -178
# %op48 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -182
# %op49 = add i32 %op48, 1
	ld.w $t0, $fp, -182
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -186
# %op50 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -190
# store i32 %op49, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t1, $fp, -186
	st.w $t1, $t0, 0
# br label %label28
	b .main_label28
.main_label51:
# %op52 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -194
# %op53 = load i32, i32* @len
	la.local $t0, len
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -198
# %op54 = icmp slt i32 %op52, %op53
	ld.w $t0, $fp, -194
	ld.w $t1, $fp, -198
	slt $t0, $t0, $t1
	st.b $t0, $fp, -199
# %op55 = zext i1 %op54 to i32
	ld.b $t0, $fp, -199
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -203
# %op56 = icmp ne i32 %op55, 0
	ld.w $t0, $fp, -203
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -204
# br i1 %op56, label %label57, label %label64
	ld.b $t0, $fp, -204
	bnez $t0, .main_label57
	b .main_label64
.main_label57:
# %op58 = load i32, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -208
# %op59 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -212
# %op60 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -216
# %op61 = mul i32 %op59, %op60
	ld.w $t0, $fp, -212
	ld.w $t1, $fp, -216
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -220
# %op62 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -224
# %op63 = icmp sge i32 %op62, 0
	ld.w $t0, $fp, -224
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -225
# br i1 %op63, label %label70, label %label69
	ld.b $t0, $fp, -225
	bnez $t0, .main_label70
	b .main_label69
.main_label64:
# %op65 = load i32, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -229
# %op66 = icmp slt i32 %op65, 0
	ld.w $t0, $fp, -229
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	st.b $t0, $fp, -230
# %op67 = zext i1 %op66 to i32
	ld.b $t0, $fp, -230
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -234
# %op68 = icmp sgt i32 %op67, 0
	ld.w $t0, $fp, -234
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -235
# br i1 %op68, label %label80, label %label84
	ld.b $t0, $fp, -235
	bnez $t0, .main_label80
	b .main_label84
.main_label69:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label73
	b .main_label73
.main_label70:
# %op71 = getelementptr [20000000 x i32], [20000000 x i32]* @matrix, i32 0, i32 %op62
	la.local $t0, matrix
	ld.w $t1, $fp, -224
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -243
# %op72 = load i32, i32* %op71
	ld.d $t0, $fp, -243
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -247
# br label %label73
	b .main_label73
.main_label73:
# %op74 = mul i32 %op61, %op72
	ld.w $t0, $fp, -220
	ld.w $t1, $fp, -247
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -251
# %op75 = add i32 %op58, %op74
	ld.w $t0, $fp, -208
	ld.w $t1, $fp, -251
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -255
# %op76 = load i32, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -259
# store i32 %op75, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t1, $fp, -255
	st.w $t1, $t0, 0
# %op77 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -263
# %op78 = add i32 %op77, 1
	ld.w $t0, $fp, -263
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -267
# %op79 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -271
# store i32 %op78, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t1, $fp, -267
	st.w $t1, $t0, 0
# br label %label51
	b .main_label51
.main_label80:
# %op81 = load i32, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -275
# %op82 = sub i32 0, %op81
	addi.w $t0, $zero, 0
	ld.w $t1, $fp, -275
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -279
# %op83 = load i32, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -283
# store i32 %op82, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t1, $fp, -279
	st.w $t1, $t0, 0
# br label %label84
	b .main_label84
.main_label84:
# %op85 = load i32, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -287
# call void @output(i32 %op85)
	ld.w $a0, $fp, -287
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 288
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
