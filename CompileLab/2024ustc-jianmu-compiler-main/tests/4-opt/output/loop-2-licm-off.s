	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -128
.main_label_entry:
# br label %label6
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -20
	b .main_label6
.main_label6:
# %op68 = phi i32 [ 0, %label_entry ], [ %op66, %label64 ]
# %op69 = phi i32 [ %op71, %label64 ], [ undef, %label_entry ]
# %op8 = icmp slt i32 %op68, 10000000
	ld.w $t0, $fp, -20
	lu12i.w $t1, 2441
	ori $t1, $t1, 1664
	slt $t0, $t0, $t1
	st.b $t0, $fp, -25
# %op9 = zext i1 %op8 to i32
	ld.b $t0, $fp, -25
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -29
# %op10 = icmp ne i32 %op9, 0
	ld.w $t0, $fp, -29
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -30
# br i1 %op10, label %label11, label %label13
	ld.b $t0, $fp, -30
	bnez $t0, .main_label11
	b .main_label13
.main_label11:
# br label %label15
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -34
	ld.w $a0, $fp, -24
	st.w $a0, $fp, -38
	b .main_label15
.main_label13:
# call void @output(i32 %op69)
	ld.w $a0, $fp, -24
	bl output
# ret void
	addi.w  $a0, $zero, 0
	b main_exit
.main_label15:
# %op70 = phi i32 [ 0, %label11 ], [ %op62, %label20 ]
# %op71 = phi i32 [ %op69, %label11 ], [ %op59, %label20 ]
# %op17 = icmp slt i32 %op70, 2
	ld.w $t0, $fp, -34
	addi.w $t1, $zero, 2
	slt $t0, $t0, $t1
	st.b $t0, $fp, -39
# %op18 = zext i1 %op17 to i32
	ld.b $t0, $fp, -39
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -43
# %op19 = icmp ne i32 %op18, 0
	ld.w $t0, $fp, -43
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -44
# br i1 %op19, label %label20, label %label64
	ld.b $t0, $fp, -44
	bnez $t0, .main_label20
	b .main_label64
.main_label20:
# %op23 = mul i32 2, 2
	addi.w $t0, $zero, 2
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -48
# %op25 = mul i32 %op23, 2
	ld.w $t0, $fp, -48
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -52
# %op27 = mul i32 %op25, 2
	ld.w $t0, $fp, -52
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -56
# %op29 = mul i32 %op27, 2
	ld.w $t0, $fp, -56
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -60
# %op31 = mul i32 %op29, 2
	ld.w $t0, $fp, -60
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -64
# %op33 = mul i32 %op31, 2
	ld.w $t0, $fp, -64
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -68
# %op35 = mul i32 %op33, 2
	ld.w $t0, $fp, -68
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -72
# %op37 = mul i32 %op35, 2
	ld.w $t0, $fp, -72
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -76
# %op39 = mul i32 %op37, 2
	ld.w $t0, $fp, -76
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -80
# %op41 = sdiv i32 %op39, 2
	ld.w $t0, $fp, -80
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -84
# %op43 = sdiv i32 %op41, 2
	ld.w $t0, $fp, -84
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -88
# %op45 = sdiv i32 %op43, 2
	ld.w $t0, $fp, -88
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -92
# %op47 = sdiv i32 %op45, 2
	ld.w $t0, $fp, -92
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -96
# %op49 = sdiv i32 %op47, 2
	ld.w $t0, $fp, -96
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -100
# %op51 = sdiv i32 %op49, 2
	ld.w $t0, $fp, -100
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -104
# %op53 = sdiv i32 %op51, 2
	ld.w $t0, $fp, -104
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -108
# %op55 = sdiv i32 %op53, 2
	ld.w $t0, $fp, -108
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -112
# %op57 = sdiv i32 %op55, 2
	ld.w $t0, $fp, -112
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -116
# %op59 = sdiv i32 %op57, 2
	ld.w $t0, $fp, -116
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -120
# %op62 = add i32 %op70, 1
	ld.w $t0, $fp, -34
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -124
# br label %label15
	ld.w $a0, $fp, -124
	st.w $a0, $fp, -34
	ld.w $a0, $fp, -120
	st.w $a0, $fp, -38
	b .main_label15
.main_label64:
# %op66 = add i32 %op68, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -128
# br label %label6
	ld.w $a0, $fp, -128
	st.w $a0, $fp, -20
	ld.w $a0, $fp, -38
	st.w $a0, $fp, -24
	b .main_label6
main_exit:
	addi.d $sp, $sp, 128
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
