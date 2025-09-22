	.text
	.globl factorial
	.type factorial, @function
factorial:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -48
	st.w $a0, $fp, -20
.factorial_label_entry:
# %op3 = icmp eq i32 %arg0, 0
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -21
# %op4 = zext i1 %op3 to i32
	ld.b $t0, $fp, -21
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -25
# %op5 = icmp sgt i32 %op4, 0
	ld.w $t0, $fp, -25
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -26
# br i1 %op5, label %label6, label %label8
	ld.b $t0, $fp, -26
	bnez $t0, .factorial_label6
	b .factorial_label8
.factorial_label6:
# ret i32 1
	addi.w $a0, $zero, 1
	b factorial_exit
.factorial_label8:
# %op11 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -30
# %op12 = call i32 @factorial(i32 %op11)
	ld.w $a0, $fp, -30
	bl factorial
	st.w $a0, $fp, -34
# %op13 = mul i32 %arg0, %op12
	ld.w $t0, $fp, -20
	ld.w $t1, $fp, -34
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -38
# ret i32 %op13
	ld.w $a0, $fp, -38
	b factorial_exit
factorial_exit:
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.main_label_entry:
# %op1 = call i32 @factorial(i32 10)
	addi.w $a0, $zero, 10
	bl factorial
	st.w $a0, $fp, -20
# ret i32 %op1
	ld.w $a0, $fp, -20
	b main_exit
main_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
