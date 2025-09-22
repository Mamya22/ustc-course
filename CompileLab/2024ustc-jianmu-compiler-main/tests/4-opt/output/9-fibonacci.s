	.text
	.globl fibonacci
	.type fibonacci, @function
fibonacci:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -64
	st.w $a0, $fp, -20
.fibonacci_label_entry:
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
	bnez $t0, .fibonacci_label6
	b .fibonacci_label8
.fibonacci_label6:
# ret i32 0
	addi.w $a0, $zero, 0
	b fibonacci_exit
.fibonacci_label8:
# %op10 = icmp eq i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -27
# %op11 = zext i1 %op10 to i32
	ld.b $t0, $fp, -27
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -31
# %op12 = icmp sgt i32 %op11, 0
	ld.w $t0, $fp, -31
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -32
# br i1 %op12, label %label13, label %label15
	ld.b $t0, $fp, -32
	bnez $t0, .fibonacci_label13
	b .fibonacci_label15
.fibonacci_label13:
# ret i32 1
	addi.w $a0, $zero, 1
	b fibonacci_exit
.fibonacci_label15:
# %op17 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -36
# %op18 = call i32 @fibonacci(i32 %op17)
	ld.w $a0, $fp, -36
	bl fibonacci
	st.w $a0, $fp, -40
# %op20 = sub i32 %arg0, 2
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 2
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -44
# %op21 = call i32 @fibonacci(i32 %op20)
	ld.w $a0, $fp, -44
	bl fibonacci
	st.w $a0, $fp, -48
# %op22 = add i32 %op18, %op21
	ld.w $t0, $fp, -40
	ld.w $t1, $fp, -48
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -52
# ret i32 %op22
	ld.w $a0, $fp, -52
	b fibonacci_exit
fibonacci_exit:
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -48
.main_label_entry:
# br label %label4
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -20
	b .main_label4
.main_label4:
# %op17 = phi i32 [ 0, %label_entry ], [ %op14, %label10 ]
# %op7 = icmp slt i32 %op17, 10
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
# br i1 %op9, label %label10, label %label16
	ld.b $t0, $fp, -26
	bnez $t0, .main_label10
	b .main_label16
.main_label10:
# %op12 = call i32 @fibonacci(i32 %op17)
	ld.w $a0, $fp, -20
	bl fibonacci
	st.w $a0, $fp, -30
# call void @output(i32 %op12)
	ld.w $a0, $fp, -30
	bl output
# %op14 = add i32 %op17, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -34
# br label %label4
	ld.w $a0, $fp, -34
	st.w $a0, $fp, -20
	b .main_label4
.main_label16:
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
