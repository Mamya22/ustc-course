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
	addi.d $sp, $sp, -48
.readarray_label_entry:
# br label %label2
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -20
	b .readarray_label2
.readarray_label2:
# %op21 = phi i32 [ 0, %label_entry ], [ %op19, %label17 ]
# %op4 = load i32, i32* @len
	la.local $t0, len
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -24
# %op5 = icmp slt i32 %op21, %op4
	ld.w $t0, $fp, -20
	ld.w $t1, $fp, -24
	slt $t0, $t0, $t1
	st.b $t0, $fp, -25
# %op6 = zext i1 %op5 to i32
	ld.b $t0, $fp, -25
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -29
# %op7 = icmp ne i32 %op6, 0
	ld.w $t0, $fp, -29
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -30
# br i1 %op7, label %label8, label %label12
	ld.b $t0, $fp, -30
	bnez $t0, .readarray_label8
	b .readarray_label12
.readarray_label8:
# %op9 = call i32 @input()
	bl input
	st.w $a0, $fp, -34
# %op11 = icmp sge i32 %op21, 0
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -35
# br i1 %op11, label %label14, label %label13
	ld.b $t0, $fp, -35
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
# %op15 = getelementptr [100000 x i32], [100000 x i32]* @ad, i32 0, i32 %op21
	la.local $t0, ad
	ld.w $t1, $fp, -20
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -43
# br label %label17
	b .readarray_label17
.readarray_label17:
# store i32 %op9, i32* %op15
	ld.d $t0, $fp, -43
	ld.w $t1, $fp, -34
	st.w $t1, $t0, 0
# %op19 = add i32 %op21, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -47
# br label %label2
	ld.w $a0, $fp, -47
	st.w $a0, $fp, -20
	b .readarray_label2
readarray_exit:
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl transpose
	.type transpose, @function
transpose:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -160
	st.w $a0, $fp, -20
	st.d $a1, $fp, -28
	st.w $a2, $fp, -32
.transpose_label_entry:
# %op13 = sdiv i32 %arg0, %arg2
	ld.w $t0, $fp, -20
	ld.w $t1, $fp, -32
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -36
# br label %label17
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -40
	b .transpose_label17
.transpose_label17:
# %op98 = phi i32 [ 0, %label_entry ], [ %op41, %label39 ]
# %op20 = icmp slt i32 %op98, %op13
	ld.w $t0, $fp, -40
	ld.w $t1, $fp, -36
	slt $t0, $t0, $t1
	st.b $t0, $fp, -41
# %op21 = zext i1 %op20 to i32
	ld.b $t0, $fp, -41
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -45
# %op22 = icmp ne i32 %op21, 0
	ld.w $t0, $fp, -45
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -46
# br i1 %op22, label %label23, label %label25
	ld.b $t0, $fp, -46
	bnez $t0, .transpose_label23
	b .transpose_label25
.transpose_label23:
# br label %label27
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -54
	b .transpose_label27
.transpose_label25:
# %op26 = sub i32 0, 1
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -50
# ret i32 %op26
	ld.w $a0, $fp, -50
	b transpose_exit
.transpose_label27:
# %op99 = phi i32 [ 0, %label23 ], [ %op100, %label47 ]
# %op30 = icmp slt i32 %op99, %arg2
	ld.w $t0, $fp, -54
	ld.w $t1, $fp, -32
	slt $t0, $t0, $t1
	st.b $t0, $fp, -55
# %op31 = zext i1 %op30 to i32
	ld.b $t0, $fp, -55
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -59
# %op32 = icmp ne i32 %op31, 0
	ld.w $t0, $fp, -59
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -60
# br i1 %op32, label %label33, label %label39
	ld.b $t0, $fp, -60
	bnez $t0, .transpose_label33
	b .transpose_label39
.transpose_label33:
# %op36 = icmp slt i32 %op98, %op99
	ld.w $t0, $fp, -40
	ld.w $t1, $fp, -54
	slt $t0, $t0, $t1
	st.b $t0, $fp, -61
# %op37 = zext i1 %op36 to i32
	ld.b $t0, $fp, -61
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -65
# %op38 = icmp sgt i32 %op37, 0
	ld.w $t0, $fp, -65
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -66
# br i1 %op38, label %label43, label %label48
	ld.b $t0, $fp, -66
	bnez $t0, .transpose_label43
	b .transpose_label48
.transpose_label39:
# %op41 = add i32 %op98, 1
	ld.w $t0, $fp, -40
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -70
# br label %label17
	ld.w $a0, $fp, -70
	st.w $a0, $fp, -40
	b .transpose_label17
.transpose_label43:
# %op45 = add i32 %op99, 1
	ld.w $t0, $fp, -54
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -74
# br label %label47
	ld.w $a0, $fp, -74
	st.w $a0, $fp, -78
	b .transpose_label47
.transpose_label47:
# %op100 = phi i32 [ %op45, %label43 ], [ %op96, %label94 ]
# br label %label27
	ld.w $a0, $fp, -78
	st.w $a0, $fp, -54
	b .transpose_label27
.transpose_label48:
# %op51 = mul i32 %op98, %arg2
	ld.w $t0, $fp, -40
	ld.w $t1, $fp, -32
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -82
# %op53 = add i32 %op51, %op99
	ld.w $t0, $fp, -82
	ld.w $t1, $fp, -54
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -86
# %op54 = icmp sge i32 %op53, 0
	ld.w $t0, $fp, -86
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -87
# br i1 %op54, label %label56, label %label55
	ld.b $t0, $fp, -87
	bnez $t0, .transpose_label56
	b .transpose_label55
.transpose_label55:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label59
	b .transpose_label59
.transpose_label56:
# %op57 = getelementptr i32, i32* %arg1, i32 %op53
	ld.d $t0, $fp, -28
	ld.w $t1, $fp, -86
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -95
# %op58 = load i32, i32* %op57
	ld.d $t0, $fp, -95
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -99
# br label %label59
	b .transpose_label59
.transpose_label59:
# %op63 = mul i32 %op98, %arg2
	ld.w $t0, $fp, -40
	ld.w $t1, $fp, -32
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -103
# %op65 = add i32 %op63, %op99
	ld.w $t0, $fp, -103
	ld.w $t1, $fp, -54
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -107
# %op66 = icmp sge i32 %op65, 0
	ld.w $t0, $fp, -107
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -108
# br i1 %op66, label %label68, label %label67
	ld.b $t0, $fp, -108
	bnez $t0, .transpose_label68
	b .transpose_label67
.transpose_label67:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label71
	b .transpose_label71
.transpose_label68:
# %op69 = getelementptr i32, i32* %arg1, i32 %op65
	ld.d $t0, $fp, -28
	ld.w $t1, $fp, -107
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -116
# %op70 = load i32, i32* %op69
	ld.d $t0, $fp, -116
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -120
# br label %label71
	b .transpose_label71
.transpose_label71:
# %op74 = mul i32 %op99, %op13
	ld.w $t0, $fp, -54
	ld.w $t1, $fp, -36
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -124
# %op76 = add i32 %op74, %op98
	ld.w $t0, $fp, -124
	ld.w $t1, $fp, -40
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -128
# %op77 = icmp sge i32 %op76, 0
	ld.w $t0, $fp, -128
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -129
# br i1 %op77, label %label79, label %label78
	ld.b $t0, $fp, -129
	bnez $t0, .transpose_label79
	b .transpose_label78
.transpose_label78:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label82
	b .transpose_label82
.transpose_label79:
# %op80 = getelementptr i32, i32* %arg1, i32 %op76
	ld.d $t0, $fp, -28
	ld.w $t1, $fp, -128
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -137
# br label %label82
	b .transpose_label82
.transpose_label82:
# store i32 %op70, i32* %op80
	ld.d $t0, $fp, -137
	ld.w $t1, $fp, -120
	st.w $t1, $t0, 0
# %op86 = mul i32 %op98, %arg2
	ld.w $t0, $fp, -40
	ld.w $t1, $fp, -32
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -141
# %op88 = add i32 %op86, %op99
	ld.w $t0, $fp, -141
	ld.w $t1, $fp, -54
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -145
# %op89 = icmp sge i32 %op88, 0
	ld.w $t0, $fp, -145
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -146
# br i1 %op89, label %label91, label %label90
	ld.b $t0, $fp, -146
	bnez $t0, .transpose_label91
	b .transpose_label90
.transpose_label90:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label94
	b .transpose_label94
.transpose_label91:
# %op92 = getelementptr i32, i32* %arg1, i32 %op88
	ld.d $t0, $fp, -28
	ld.w $t1, $fp, -145
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -154
# br label %label94
	b .transpose_label94
.transpose_label94:
# store i32 %op58, i32* %op92
	ld.d $t0, $fp, -154
	ld.w $t1, $fp, -99
	st.w $t1, $t0, 0
# %op96 = add i32 %op99, 1
	ld.w $t0, $fp, -54
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -158
# br label %label47
	ld.w $a0, $fp, -158
	st.w $a0, $fp, -78
	b .transpose_label47
transpose_exit:
	addi.d $sp, $sp, 160
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
# %op3 = call i32 @input()
	bl input
	st.w $a0, $fp, -20
# %op5 = call i32 @input()
	bl input
	st.w $a0, $fp, -24
# store i32 %op5, i32* @len
	la.local $t0, len
	ld.w $t1, $fp, -24
	st.w $t1, $t0, 0
# call void @readarray()
	bl readarray
# br label %label8
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -28
	b .main_label8
.main_label8:
# %op86 = phi i32 [ 0, %label_entry ], [ %op26, %label24 ]
# %op11 = icmp slt i32 %op86, %op3
	ld.w $t0, $fp, -28
	ld.w $t1, $fp, -20
	slt $t0, $t0, $t1
	st.b $t0, $fp, -29
# %op12 = zext i1 %op11 to i32
	ld.b $t0, $fp, -29
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -33
# %op13 = icmp ne i32 %op12, 0
	ld.w $t0, $fp, -33
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -34
# br i1 %op13, label %label14, label %label18
	ld.b $t0, $fp, -34
	bnez $t0, .main_label14
	b .main_label18
.main_label14:
# %op17 = icmp sge i32 %op86, 0
	ld.w $t0, $fp, -28
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -35
# br i1 %op17, label %label21, label %label20
	ld.b $t0, $fp, -35
	bnez $t0, .main_label21
	b .main_label20
.main_label18:
# br label %label28
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -51
	b .main_label28
.main_label20:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label24
	b .main_label24
.main_label21:
# %op22 = getelementptr [20000000 x i32], [20000000 x i32]* @matrix, i32 0, i32 %op86
	la.local $t0, matrix
	ld.w $t1, $fp, -28
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -43
# br label %label24
	b .main_label24
.main_label24:
# store i32 %op86, i32* %op22
	ld.d $t0, $fp, -43
	ld.w $t1, $fp, -28
	st.w $t1, $t0, 0
# %op26 = add i32 %op86, 1
	ld.w $t0, $fp, -28
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -47
# br label %label8
	ld.w $a0, $fp, -47
	st.w $a0, $fp, -28
	b .main_label8
.main_label28:
# %op87 = phi i32 [ 0, %label18 ], [ %op49, %label46 ]
# %op30 = load i32, i32* @len
	la.local $t0, len
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -55
# %op31 = icmp slt i32 %op87, %op30
	ld.w $t0, $fp, -51
	ld.w $t1, $fp, -55
	slt $t0, $t0, $t1
	st.b $t0, $fp, -56
# %op32 = zext i1 %op31 to i32
	ld.b $t0, $fp, -56
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -60
# %op33 = icmp ne i32 %op32, 0
	ld.w $t0, $fp, -60
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -61
# br i1 %op33, label %label34, label %label39
	ld.b $t0, $fp, -61
	bnez $t0, .main_label34
	b .main_label39
.main_label34:
# %op36 = getelementptr [20000000 x i32], [20000000 x i32]* @matrix, i32 0, i32 0
	la.local $t0, matrix
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -69
# %op38 = icmp sge i32 %op87, 0
	ld.w $t0, $fp, -51
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -70
# br i1 %op38, label %label43, label %label42
	ld.b $t0, $fp, -70
	bnez $t0, .main_label43
	b .main_label42
.main_label39:
# br label %label51
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -94
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -98
	b .main_label51
.main_label42:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label46
	b .main_label46
.main_label43:
# %op44 = getelementptr [100000 x i32], [100000 x i32]* @ad, i32 0, i32 %op87
	la.local $t0, ad
	ld.w $t1, $fp, -51
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -78
# %op45 = load i32, i32* %op44
	ld.d $t0, $fp, -78
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -82
# br label %label46
	b .main_label46
.main_label46:
# %op47 = call i32 @transpose(i32 %op3, i32* %op36, i32 %op45)
	ld.w $a0, $fp, -20
	ld.d $a1, $fp, -69
	ld.w $a2, $fp, -82
	bl transpose
	st.w $a0, $fp, -86
# %op49 = add i32 %op87, 1
	ld.w $t0, $fp, -51
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -90
# br label %label28
	ld.w $a0, $fp, -90
	st.w $a0, $fp, -51
	b .main_label28
.main_label51:
# %op88 = phi i32 [ 0, %label39 ], [ %op75, %label73 ]
# %op89 = phi i32 [ 0, %label39 ], [ %op78, %label73 ]
# %op53 = load i32, i32* @len
	la.local $t0, len
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -102
# %op54 = icmp slt i32 %op89, %op53
	ld.w $t0, $fp, -98
	ld.w $t1, $fp, -102
	slt $t0, $t0, $t1
	st.b $t0, $fp, -103
# %op55 = zext i1 %op54 to i32
	ld.b $t0, $fp, -103
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -107
# %op56 = icmp ne i32 %op55, 0
	ld.w $t0, $fp, -107
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -108
# br i1 %op56, label %label57, label %label64
	ld.b $t0, $fp, -108
	bnez $t0, .main_label57
	b .main_label64
.main_label57:
# %op61 = mul i32 %op89, %op89
	ld.w $t0, $fp, -98
	ld.w $t1, $fp, -98
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -112
# %op63 = icmp sge i32 %op89, 0
	ld.w $t0, $fp, -98
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -113
# br i1 %op63, label %label70, label %label69
	ld.b $t0, $fp, -113
	bnez $t0, .main_label70
	b .main_label69
.main_label64:
# %op66 = icmp slt i32 %op88, 0
	ld.w $t0, $fp, -94
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	st.b $t0, $fp, -114
# %op67 = zext i1 %op66 to i32
	ld.b $t0, $fp, -114
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -118
# %op68 = icmp sgt i32 %op67, 0
	ld.w $t0, $fp, -118
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -119
# br i1 %op68, label %label80, label %label84
	ld.w $a0, $fp, -94
	st.w $a0, $fp, -151
	ld.b $t0, $fp, -119
	bnez $t0, .main_label80
	b .main_label84
.main_label69:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label73
	b .main_label73
.main_label70:
# %op71 = getelementptr [20000000 x i32], [20000000 x i32]* @matrix, i32 0, i32 %op89
	la.local $t0, matrix
	ld.w $t1, $fp, -98
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -127
# %op72 = load i32, i32* %op71
	ld.d $t0, $fp, -127
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -131
# br label %label73
	b .main_label73
.main_label73:
# %op74 = mul i32 %op61, %op72
	ld.w $t0, $fp, -112
	ld.w $t1, $fp, -131
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -135
# %op75 = add i32 %op88, %op74
	ld.w $t0, $fp, -94
	ld.w $t1, $fp, -135
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -139
# %op78 = add i32 %op89, 1
	ld.w $t0, $fp, -98
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -143
# br label %label51
	ld.w $a0, $fp, -139
	st.w $a0, $fp, -94
	ld.w $a0, $fp, -143
	st.w $a0, $fp, -98
	b .main_label51
.main_label80:
# %op82 = sub i32 0, %op88
	addi.w $t0, $zero, 0
	ld.w $t1, $fp, -94
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -147
# br label %label84
	ld.w $a0, $fp, -147
	st.w $a0, $fp, -151
	b .main_label84
.main_label84:
# %op90 = phi i32 [ %op88, %label64 ], [ %op82, %label80 ]
# call void @output(i32 %op90)
	ld.w $a0, $fp, -151
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 160
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
