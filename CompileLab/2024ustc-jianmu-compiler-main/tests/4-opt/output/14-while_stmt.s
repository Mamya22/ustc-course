	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.main_label_entry:
# br label %label2
	addi.w $a0, $zero, 10
	st.w $a0, $fp, -20
	b .main_label2
.main_label2:
# %op10 = phi i32 [ 10, %label_entry ], [ %op7, %label5 ]
# %op4 = icmp ne i32 %op10, 0
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -21
# br i1 %op4, label %label5, label %label9
	ld.b $t0, $fp, -21
	bnez $t0, .main_label5
	b .main_label9
.main_label5:
# %op7 = sub i32 %op10, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -25
# br label %label2
	ld.w $a0, $fp, -25
	st.w $a0, $fp, -20
	b .main_label2
.main_label9:
# ret void
	addi.w  $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
