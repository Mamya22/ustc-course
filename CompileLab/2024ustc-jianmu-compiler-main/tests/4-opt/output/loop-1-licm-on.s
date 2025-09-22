	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -144
.main_label_entry:
# br label %label4
	addi.w $a0, $zero, 1
	st.w $a0, $fp, -20
	b .main_label4
.main_label4:
# %op66 = phi i32 [ 1, %label_entry ], [ %op64, %label62 ]
# %op67 = phi i32 [ %op69, %label62 ], [ undef, %label_entry ]
# %op6 = icmp slt i32 %op66, 10000
	ld.w $t0, $fp, -20
	lu12i.w $t1, 2
	ori $t1, $t1, 1808
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
# br i1 %op8, label %label9, label %label11
	ld.b $t0, $fp, -30
	bnez $t0, .main_label9
	b .main_label11
.main_label9:
# br label %label70
	ld.w $a0, $fp, -24
	st.w $a0, $fp, -56
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -60
	ld.w $a0, $fp, -24
	st.w $a0, $fp, -56
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -60
	b .main_label70
.main_label11:
# call void @output(i32 %op67)
	ld.w $a0, $fp, -24
	bl output
# ret void
	addi.w  $a0, $zero, 0
	b main_exit
.main_label13:
# %op68 = phi i32 [ %op60, %label18 ], [ %op72, %label70 ]
# %op69 = phi i32 [ %op57, %label18 ], [ %op71, %label70 ]
# %op15 = icmp slt i32 %op68, 10000
	ld.w $t0, $fp, -34
	lu12i.w $t1, 2
	ori $t1, $t1, 1808
	slt $t0, $t0, $t1
	st.b $t0, $fp, -39
# %op16 = zext i1 %op15 to i32
	ld.b $t0, $fp, -39
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -43
# %op17 = icmp ne i32 %op16, 0
	ld.w $t0, $fp, -43
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -44
# br i1 %op17, label %label18, label %label62
	ld.b $t0, $fp, -44
	bnez $t0, .main_label18
	b .main_label62
.main_label18:
# %op60 = add i32 %op68, 1
	ld.w $t0, $fp, -34
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -48
# br label %label13
	ld.w $a0, $fp, -48
	st.w $a0, $fp, -34
	ld.w $a0, $fp, -136
	st.w $a0, $fp, -38
	b .main_label13
.main_label62:
# %op64 = add i32 %op66, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -52
# br label %label4
	ld.w $a0, $fp, -52
	st.w $a0, $fp, -20
	ld.w $a0, $fp, -38
	st.w $a0, $fp, -24
	b .main_label4
.main_label70:
# %op71 = phi i32 [ %op67, %label9 ]
# %op72 = phi i32 [ 0, %label9 ]
# %op21 = mul i32 %op66, %op66
	ld.w $t0, $fp, -20
	ld.w $t1, $fp, -20
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -64
# %op23 = mul i32 %op21, %op66
	ld.w $t0, $fp, -64
	ld.w $t1, $fp, -20
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -68
# %op25 = mul i32 %op23, %op66
	ld.w $t0, $fp, -68
	ld.w $t1, $fp, -20
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -72
# %op27 = mul i32 %op25, %op66
	ld.w $t0, $fp, -72
	ld.w $t1, $fp, -20
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -76
# %op29 = mul i32 %op27, %op66
	ld.w $t0, $fp, -76
	ld.w $t1, $fp, -20
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -80
# %op31 = mul i32 %op29, %op66
	ld.w $t0, $fp, -80
	ld.w $t1, $fp, -20
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -84
# %op33 = mul i32 %op31, %op66
	ld.w $t0, $fp, -84
	ld.w $t1, $fp, -20
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -88
# %op35 = mul i32 %op33, %op66
	ld.w $t0, $fp, -88
	ld.w $t1, $fp, -20
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -92
# %op37 = mul i32 %op35, %op66
	ld.w $t0, $fp, -92
	ld.w $t1, $fp, -20
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -96
# %op39 = sdiv i32 %op37, %op66
	ld.w $t0, $fp, -96
	ld.w $t1, $fp, -20
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -100
# %op41 = sdiv i32 %op39, %op66
	ld.w $t0, $fp, -100
	ld.w $t1, $fp, -20
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -104
# %op43 = sdiv i32 %op41, %op66
	ld.w $t0, $fp, -104
	ld.w $t1, $fp, -20
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -108
# %op45 = sdiv i32 %op43, %op66
	ld.w $t0, $fp, -108
	ld.w $t1, $fp, -20
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -112
# %op47 = sdiv i32 %op45, %op66
	ld.w $t0, $fp, -112
	ld.w $t1, $fp, -20
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -116
# %op49 = sdiv i32 %op47, %op66
	ld.w $t0, $fp, -116
	ld.w $t1, $fp, -20
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -120
# %op51 = sdiv i32 %op49, %op66
	ld.w $t0, $fp, -120
	ld.w $t1, $fp, -20
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -124
# %op53 = sdiv i32 %op51, %op66
	ld.w $t0, $fp, -124
	ld.w $t1, $fp, -20
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -128
# %op55 = sdiv i32 %op53, %op66
	ld.w $t0, $fp, -128
	ld.w $t1, $fp, -20
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -132
# %op57 = sdiv i32 %op55, %op66
	ld.w $t0, $fp, -132
	ld.w $t1, $fp, -20
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -136
# br label %label13
	ld.w $a0, $fp, -60
	st.w $a0, $fp, -34
	ld.w $a0, $fp, -56
	st.w $a0, $fp, -38
	b .main_label13
main_exit:
	addi.d $sp, $sp, 144
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
