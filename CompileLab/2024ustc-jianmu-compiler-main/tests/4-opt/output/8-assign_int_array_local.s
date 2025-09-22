	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -96
.main_label_entry:
# %op0 = alloca [10 x i32]
	addi.d $t0, $fp, -64
	st.d $t0, $fp, -24
# %op1 = icmp sge i32 3, 0
	addi.w $t0, $zero, 3
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -65
# br i1 %op1, label %label3, label %label2
	ld.b $t0, $fp, -65
	bnez $t0, .main_label3
	b .main_label2
.main_label2:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label6
	b .main_label6
.main_label3:
# %op4 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 3
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 3
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -73
# br label %label6
	b .main_label6
.main_label6:
# store i32 1234, i32* %op4
	ld.d $t0, $fp, -73
	addi.w $t1, $zero, 1234
	st.w $t1, $t0, 0
# %op7 = icmp sge i32 3, 0
	addi.w $t0, $zero, 3
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -74
# br i1 %op7, label %label9, label %label8
	ld.b $t0, $fp, -74
	bnez $t0, .main_label9
	b .main_label8
.main_label8:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label12
	b .main_label12
.main_label9:
# %op10 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 3
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 3
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -82
# %op11 = load i32, i32* %op10
	ld.d $t0, $fp, -82
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -86
# br label %label12
	b .main_label12
.main_label12:
# ret i32 %op11
	ld.w $a0, $fp, -86
	b main_exit
main_exit:
	addi.d $sp, $sp, 96
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
