	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.main_label_entry:
# %op7 = icmp sgt i32 1, 0
	addi.w $t0, $zero, 1
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -17
# br i1 %op7, label %label8, label %label11
	addi.w $a0, $zero, 2
	st.w $a0, $fp, -22
	ld.b $t0, $fp, -17
	bnez $t0, .main_label8
	b .main_label11
.main_label8:
# %op10 = icmp sgt i32 0, 0
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -18
# br i1 %op10, label %label13, label %label16
	ld.b $t0, $fp, -18
	bnez $t0, .main_label13
	b .main_label16
.main_label11:
# %op18 = phi i32 [ 2, %label_entry ], [ %op19, %label15 ]
# ret i32 %op18
	ld.w $a0, $fp, -22
	b main_exit
.main_label13:
# br label %label15
	addi.w $a0, $zero, 4
	st.w $a0, $fp, -26
	b .main_label15
.main_label15:
# %op19 = phi i32 [ 4, %label13 ], [ 3, %label16 ]
# br label %label11
	ld.w $a0, $fp, -26
	st.w $a0, $fp, -22
	b .main_label11
.main_label16:
# br label %label15
	addi.w $a0, $zero, 3
	st.w $a0, $fp, -26
	b .main_label15
main_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
