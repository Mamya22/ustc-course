# Global variables
	.text
	.section .bss, "aw", @nobits
	.globl seed
	.type seed, @object
	.size seed, 4
seed:
	.space 4
	.text
	.globl randomLCG
	.type randomLCG, @function
randomLCG:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.randomLCG_label_entry:
# %op0 = load i32, i32* @seed
	la.local $t0, seed
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -20
# %op1 = mul i32 %op0, 1103515245
	ld.w $t0, $fp, -20
	lu12i.w $t1, 269412
	ori $t1, $t1, 3693
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -24
# %op2 = add i32 %op1, 12345
	ld.w $t0, $fp, -24
	lu12i.w $t1, 3
	ori $t1, $t1, 57
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -28
# store i32 %op2, i32* @seed
	la.local $t0, seed
	ld.w $t1, $fp, -28
	st.w $t1, $t0, 0
# %op4 = load i32, i32* @seed
	la.local $t0, seed
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -32
# ret i32 %op4
	ld.w $a0, $fp, -32
	b randomLCG_exit
randomLCG_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl randBin
	.type randBin, @function
randBin:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.randBin_label_entry:
# %op0 = call i32 @randomLCG()
	bl randomLCG
	st.w $a0, $fp, -20
# %op1 = icmp sgt i32 %op0, 0
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -21
# %op2 = zext i1 %op1 to i32
	ld.b $t0, $fp, -21
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -25
# %op3 = icmp sgt i32 %op2, 0
	ld.w $t0, $fp, -25
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -26
# br i1 %op3, label %label4, label %label6
	ld.b $t0, $fp, -26
	bnez $t0, .randBin_label4
	b .randBin_label6
.randBin_label4:
# ret i32 1
	addi.w $a0, $zero, 1
	b randBin_exit
.randBin_label6:
# ret i32 0
	addi.w $a0, $zero, 0
	b randBin_exit
randBin_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl returnToZeroSteps
	.type returnToZeroSteps, @function
returnToZeroSteps:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -64
.returnToZeroSteps_label_entry:
# br label %label4
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -20
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -24
	b .returnToZeroSteps_label4
.returnToZeroSteps_label4:
# %op32 = phi i32 [ 0, %label_entry ], [ %op19, %label31 ]
# %op33 = phi i32 [ 0, %label_entry ], [ %op34, %label31 ]
# %op6 = icmp slt i32 %op32, 20
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 20
	slt $t0, $t0, $t1
	st.b $t0, $fp, -25
# %op7 = zext i1 %op6 to i32
	ld.b $t0, $fp, -25
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -29
# %op8 = icmp ne i32 %op7, 0
	ld.w $t0, $fp, -29
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -30
# br i1 %op8, label %label9, label %label12
	ld.b $t0, $fp, -30
	bnez $t0, .returnToZeroSteps_label9
	b .returnToZeroSteps_label12
.returnToZeroSteps_label9:
# %op10 = call i32 @randBin()
	bl randBin
	st.w $a0, $fp, -34
# %op11 = icmp sgt i32 %op10, 0
	ld.w $t0, $fp, -34
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -35
# br i1 %op11, label %label13, label %label25
	ld.b $t0, $fp, -35
	bnez $t0, .returnToZeroSteps_label13
	b .returnToZeroSteps_label25
.returnToZeroSteps_label12:
# ret i32 20
	addi.w $a0, $zero, 20
	b returnToZeroSteps_exit
.returnToZeroSteps_label13:
# %op15 = add i32 %op33, 1
	ld.w $t0, $fp, -24
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -39
# br label %label17
	ld.w $a0, $fp, -39
	st.w $a0, $fp, -43
	b .returnToZeroSteps_label17
.returnToZeroSteps_label17:
# %op34 = phi i32 [ %op15, %label13 ], [ %op27, %label25 ]
# %op19 = add i32 %op32, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -47
# %op22 = icmp eq i32 %op34, 0
	ld.w $t0, $fp, -43
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -48
# %op23 = zext i1 %op22 to i32
	ld.b $t0, $fp, -48
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -52
# %op24 = icmp sgt i32 %op23, 0
	ld.w $t0, $fp, -52
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -53
# br i1 %op24, label %label29, label %label31
	ld.b $t0, $fp, -53
	bnez $t0, .returnToZeroSteps_label29
	b .returnToZeroSteps_label31
.returnToZeroSteps_label25:
# %op27 = sub i32 %op33, 1
	ld.w $t0, $fp, -24
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -57
# br label %label17
	ld.w $a0, $fp, -57
	st.w $a0, $fp, -43
	b .returnToZeroSteps_label17
.returnToZeroSteps_label29:
# ret i32 %op19
	ld.w $a0, $fp, -47
	b returnToZeroSteps_exit
.returnToZeroSteps_label31:
# br label %label4
	ld.w $a0, $fp, -47
	st.w $a0, $fp, -20
	ld.w $a0, $fp, -43
	st.w $a0, $fp, -24
	b .returnToZeroSteps_label4
returnToZeroSteps_exit:
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
# store i32 3407, i32* @seed
	la.local $t0, seed
	lu12i.w $t1, 0
	ori $t1, $t1, 3407
	st.w $t1, $t0, 0
# br label %label3
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -20
	b .main_label3
.main_label3:
# %op14 = phi i32 [ 0, %label_entry ], [ %op11, %label8 ]
# %op5 = icmp slt i32 %op14, 20
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 20
	slt $t0, $t0, $t1
	st.b $t0, $fp, -21
# %op6 = zext i1 %op5 to i32
	ld.b $t0, $fp, -21
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -25
# %op7 = icmp ne i32 %op6, 0
	ld.w $t0, $fp, -25
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -26
# br i1 %op7, label %label8, label %label13
	ld.b $t0, $fp, -26
	bnez $t0, .main_label8
	b .main_label13
.main_label8:
# %op9 = call i32 @returnToZeroSteps()
	bl returnToZeroSteps
	st.w $a0, $fp, -30
# call void @output(i32 %op9)
	ld.w $a0, $fp, -30
	bl output
# %op11 = add i32 %op14, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -34
# br label %label3
	ld.w $a0, $fp, -34
	st.w $a0, $fp, -20
	b .main_label3
.main_label13:
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
