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
	addi.w $a0, $zero, 1
	st.w $a0, $fp, -20
	b .main_label2
.main_label2:
# %op13 = phi i32 [ 1, %label_entry ], [ %op9, %label7 ]
# %op4 = icmp slt i32 %op13, 999999999
	ld.w $t0, $fp, -20
	lu12i.w $t1, 244140
	ori $t1, $t1, 2559
	slt $t0, $t0, $t1
	st.b $t0, $fp, -21
# %op5 = zext i1 %op4 to i32
	ld.b $t0, $fp, -21
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -25
# %op6 = icmp ne i32 %op5, 0
	ld.w $t0, $fp, -25
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -26
# br i1 %op6, label %label7, label %label11
	ld.b $t0, $fp, -26
	bnez $t0, .main_label7
	b .main_label11
.main_label7:
# %op9 = add i32 %op13, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -30
# br label %label2
	ld.w $a0, $fp, -30
	st.w $a0, $fp, -20
	b .main_label2
.main_label11:
# ret i32 %op13
	ld.w $a0, $fp, -20
	b main_exit
main_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
