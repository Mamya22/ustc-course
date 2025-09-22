	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.main_label_entry:
# br label %label4
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -20
	b .main_label4
.main_label4:
# %op16 = phi i32 [ 0, %label_entry ], [ %op13, %label10 ]
# %op7 = icmp slt i32 %op16, 10
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 10
	slt $t0, $t0, $t1
	st.b $t0, $fp, -21
# %op8 = zext i1 %op7 to i32
	ld.b $t0, $fp, -21
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -25
# %op9 = icmp ne i32 %op8, 0
	ld.w $t0, $fp, -25
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -26
# br i1 %op9, label %label10, label %label15
	ld.b $t0, $fp, -26
	bnez $t0, .main_label10
	b .main_label15
.main_label10:
# call void @output(i32 %op16)
	ld.w $a0, $fp, -20
	bl output
# %op13 = add i32 %op16, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -30
# br label %label4
	ld.w $a0, $fp, -30
	st.w $a0, $fp, -20
	b .main_label4
.main_label15:
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
