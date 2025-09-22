	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.main_label_entry:
# %op3 = icmp sgt i32 2, 0
	addi.w $t0, $zero, 2
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -17
# br i1 %op3, label %label4, label %label6
	ld.b $t0, $fp, -17
	bnez $t0, .main_label4
	b .main_label6
.main_label4:
# br label %label6
	b .main_label6
.main_label6:
# ret void
	addi.w  $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
