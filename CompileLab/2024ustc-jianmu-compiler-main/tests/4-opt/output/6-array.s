	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -144
.main_label_entry:
# %op0 = alloca [10 x i32]
	addi.d $t0, $fp, -64
	st.d $t0, $fp, -24
# %op3 = icmp sge i32 0, 0
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -65
# br i1 %op3, label %label5, label %label4
	ld.b $t0, $fp, -65
	bnez $t0, .main_label5
	b .main_label4
.main_label4:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label8
	b .main_label8
.main_label5:
# %op6 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -73
# br label %label8
	b .main_label8
.main_label8:
# store i32 11, i32* %op6
	ld.d $t0, $fp, -73
	addi.w $t1, $zero, 11
	st.w $t1, $t0, 0
# %op9 = icmp sge i32 4, 0
	addi.w $t0, $zero, 4
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -74
# br i1 %op9, label %label11, label %label10
	ld.b $t0, $fp, -74
	bnez $t0, .main_label11
	b .main_label10
.main_label10:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label14
	b .main_label14
.main_label11:
# %op12 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 4
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 4
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -82
# br label %label14
	b .main_label14
.main_label14:
# store i32 22, i32* %op12
	ld.d $t0, $fp, -82
	addi.w $t1, $zero, 22
	st.w $t1, $t0, 0
# %op15 = icmp sge i32 9, 0
	addi.w $t0, $zero, 9
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -83
# br i1 %op15, label %label17, label %label16
	ld.b $t0, $fp, -83
	bnez $t0, .main_label17
	b .main_label16
.main_label16:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label20
	b .main_label20
.main_label17:
# %op18 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 9
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 9
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -91
# br label %label20
	b .main_label20
.main_label20:
# store i32 33, i32* %op18
	ld.d $t0, $fp, -91
	addi.w $t1, $zero, 33
	st.w $t1, $t0, 0
# %op21 = icmp sge i32 0, 0
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -92
# br i1 %op21, label %label23, label %label22
	ld.b $t0, $fp, -92
	bnez $t0, .main_label23
	b .main_label22
.main_label22:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label26
	b .main_label26
.main_label23:
# %op24 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -100
# %op25 = load i32, i32* %op24
	ld.d $t0, $fp, -100
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -104
# br label %label26
	b .main_label26
.main_label26:
# call void @output(i32 %op25)
	ld.w $a0, $fp, -104
	bl output
# %op27 = icmp sge i32 4, 0
	addi.w $t0, $zero, 4
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -105
# br i1 %op27, label %label29, label %label28
	ld.b $t0, $fp, -105
	bnez $t0, .main_label29
	b .main_label28
.main_label28:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label32
	b .main_label32
.main_label29:
# %op30 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 4
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 4
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -113
# %op31 = load i32, i32* %op30
	ld.d $t0, $fp, -113
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -117
# br label %label32
	b .main_label32
.main_label32:
# call void @output(i32 %op31)
	ld.w $a0, $fp, -117
	bl output
# %op33 = icmp sge i32 9, 0
	addi.w $t0, $zero, 9
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -118
# br i1 %op33, label %label35, label %label34
	ld.b $t0, $fp, -118
	bnez $t0, .main_label35
	b .main_label34
.main_label34:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label38
	b .main_label38
.main_label35:
# %op36 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 9
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 9
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -126
# %op37 = load i32, i32* %op36
	ld.d $t0, $fp, -126
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -130
# br label %label38
	b .main_label38
.main_label38:
# call void @output(i32 %op37)
	ld.w $a0, $fp, -130
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 144
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
