	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -48
.main_label_entry:
# br label %label3
	addi.w $a0, $zero, 10
	st.w $a0, $fp, -24
	b .main_label3
.main_label3:
# %op24 = phi i32 [ %op26, %label23 ], [ undef, %label_entry ]
# %op25 = phi i32 [ 10, %label_entry ], [ %op8, %label23 ]
# %op5 = icmp ne i32 %op25, 0
	ld.w $t0, $fp, -24
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -25
# br i1 %op5, label %label6, label %label12
	ld.b $t0, $fp, -25
	bnez $t0, .main_label6
	b .main_label12
.main_label6:
# %op8 = sub i32 %op25, 1
	ld.w $t0, $fp, -24
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -29
# br label %label16
	ld.w $a0, $fp, -29
	st.w $a0, $fp, -37
	b .main_label16
.main_label12:
# %op15 = add i32 %op25, %op24
	ld.w $t0, $fp, -24
	ld.w $t1, $fp, -20
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -33
# ret i32 %op15
	ld.w $a0, $fp, -33
	b main_exit
.main_label16:
# %op26 = phi i32 [ %op8, %label6 ], [ %op21, %label19 ]
# %op18 = icmp ne i32 %op26, 0
	ld.w $t0, $fp, -37
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -38
# br i1 %op18, label %label19, label %label23
	ld.b $t0, $fp, -38
	bnez $t0, .main_label19
	b .main_label23
.main_label19:
# %op21 = sub i32 %op26, 1
	ld.w $t0, $fp, -37
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -42
# br label %label16
	ld.w $a0, $fp, -42
	st.w $a0, $fp, -37
	b .main_label16
.main_label23:
# br label %label3
	ld.w $a0, $fp, -37
	st.w $a0, $fp, -20
	ld.w $a0, $fp, -29
	st.w $a0, $fp, -24
	b .main_label3
main_exit:
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
