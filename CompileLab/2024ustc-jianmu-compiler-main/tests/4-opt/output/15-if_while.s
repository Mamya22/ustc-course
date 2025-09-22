	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -64
.main_label_entry:
# br label %label6
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -20
	addi.w $a0, $zero, 10
	st.w $a0, $fp, -24
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -28
	b .main_label6
.main_label6:
# %op32 = phi i32 [ 0, %label_entry ], [ %op35, %label26 ]
# %op33 = phi i32 [ 10, %label_entry ], [ %op11, %label26 ]
# %op34 = phi i32 [ 0, %label_entry ], [ %op36, %label26 ]
# %op8 = icmp ne i32 %op33, 0
	ld.w $t0, $fp, -24
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -29
# br i1 %op8, label %label9, label %label17
	ld.b $t0, $fp, -29
	bnez $t0, .main_label9
	b .main_label17
.main_label9:
# %op11 = sub i32 %op33, 1
	ld.w $t0, $fp, -24
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -33
# %op14 = icmp slt i32 %op11, 5
	ld.w $t0, $fp, -33
	addi.w $t1, $zero, 5
	slt $t0, $t0, $t1
	st.b $t0, $fp, -34
# %op15 = zext i1 %op14 to i32
	ld.b $t0, $fp, -34
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -38
# %op16 = icmp sgt i32 %op15, 0
	ld.w $t0, $fp, -38
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -39
# br i1 %op16, label %label21, label %label27
	ld.b $t0, $fp, -39
	bnez $t0, .main_label21
	b .main_label27
.main_label17:
# %op20 = add i32 %op32, %op34
	ld.w $t0, $fp, -20
	ld.w $t1, $fp, -28
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -43
# ret i32 %op20
	ld.w $a0, $fp, -43
	b main_exit
.main_label21:
# %op24 = add i32 %op32, %op11
	ld.w $t0, $fp, -20
	ld.w $t1, $fp, -33
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -47
# br label %label26
	ld.w $a0, $fp, -47
	st.w $a0, $fp, -51
	ld.w $a0, $fp, -28
	st.w $a0, $fp, -55
	b .main_label26
.main_label26:
# %op35 = phi i32 [ %op24, %label21 ], [ %op32, %label27 ]
# %op36 = phi i32 [ %op34, %label21 ], [ %op30, %label27 ]
# br label %label6
	ld.w $a0, $fp, -51
	st.w $a0, $fp, -20
	ld.w $a0, $fp, -33
	st.w $a0, $fp, -24
	ld.w $a0, $fp, -55
	st.w $a0, $fp, -28
	b .main_label6
.main_label27:
# %op30 = add i32 %op34, %op11
	ld.w $t0, $fp, -28
	ld.w $t1, $fp, -33
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -59
# br label %label26
	ld.w $a0, $fp, -20
	st.w $a0, $fp, -51
	ld.w $a0, $fp, -59
	st.w $a0, $fp, -55
	b .main_label26
main_exit:
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
