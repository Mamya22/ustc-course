	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -64
.main_label_entry:
# %op0 = alloca i32
	addi.d $t0, $fp, -28
	st.d $t0, $fp, -24
# %op1 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -32
# store i32 1, i32* %op0
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 1
	st.w $t1, $t0, 0
# br label %label2
	b .main_label2
.main_label2:
# %op3 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -36
# %op4 = icmp slt i32 %op3, 999999999
	ld.w $t0, $fp, -36
	lu12i.w $t1, 244140
	ori $t1, $t1, 2559
	slt $t0, $t0, $t1
	st.b $t0, $fp, -37
# %op5 = zext i1 %op4 to i32
	ld.b $t0, $fp, -37
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -41
# %op6 = icmp ne i32 %op5, 0
	ld.w $t0, $fp, -41
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -42
# br i1 %op6, label %label7, label %label11
	ld.b $t0, $fp, -42
	bnez $t0, .main_label7
	b .main_label11
.main_label7:
# %op8 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -46
# %op9 = add i32 %op8, 1
	ld.w $t0, $fp, -46
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -50
# %op10 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -54
# store i32 %op9, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $fp, -50
	st.w $t1, $t0, 0
# br label %label2
	b .main_label2
.main_label11:
# %op12 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -58
# ret i32 %op12
	ld.w $a0, $fp, -58
	b main_exit
main_exit:
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
