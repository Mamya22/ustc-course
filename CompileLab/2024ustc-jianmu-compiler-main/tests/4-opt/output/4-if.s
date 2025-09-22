	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -48
.main_label_entry:
# %op8 = icmp sgt i32 11, 22
	addi.w $t0, $zero, 11
	addi.w $t1, $zero, 22
	slt $t0, $t1, $t0
	st.b $t0, $fp, -17
# %op9 = zext i1 %op8 to i32
	ld.b $t0, $fp, -17
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -21
# %op10 = icmp sgt i32 %op9, 0
	ld.w $t0, $fp, -21
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -22
# br i1 %op10, label %label11, label %label18
	ld.b $t0, $fp, -22
	bnez $t0, .main_label11
	b .main_label18
.main_label11:
# %op14 = icmp sgt i32 11, 33
	addi.w $t0, $zero, 11
	addi.w $t1, $zero, 33
	slt $t0, $t1, $t0
	st.b $t0, $fp, -23
# %op15 = zext i1 %op14 to i32
	ld.b $t0, $fp, -23
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -27
# %op16 = icmp sgt i32 %op15, 0
	ld.w $t0, $fp, -27
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -28
# br i1 %op16, label %label24, label %label27
	ld.b $t0, $fp, -28
	bnez $t0, .main_label24
	b .main_label27
.main_label17:
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label18:
# %op21 = icmp slt i32 33, 22
	addi.w $t0, $zero, 33
	addi.w $t1, $zero, 22
	slt $t0, $t0, $t1
	st.b $t0, $fp, -29
# %op22 = zext i1 %op21 to i32
	ld.b $t0, $fp, -29
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -33
# %op23 = icmp sgt i32 %op22, 0
	ld.w $t0, $fp, -33
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -34
# br i1 %op23, label %label29, label %label32
	ld.b $t0, $fp, -34
	bnez $t0, .main_label29
	b .main_label32
.main_label24:
# call void @output(i32 11)
	addi.w $a0, $zero, 11
	bl output
# br label %label26
	b .main_label26
.main_label26:
# br label %label17
	b .main_label17
.main_label27:
# call void @output(i32 33)
	addi.w $a0, $zero, 33
	bl output
# br label %label26
	b .main_label26
.main_label29:
# call void @output(i32 22)
	addi.w $a0, $zero, 22
	bl output
# br label %label31
	b .main_label31
.main_label31:
# br label %label17
	b .main_label17
.main_label32:
# call void @output(i32 33)
	addi.w $a0, $zero, 33
	bl output
# br label %label31
	b .main_label31
main_exit:
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
