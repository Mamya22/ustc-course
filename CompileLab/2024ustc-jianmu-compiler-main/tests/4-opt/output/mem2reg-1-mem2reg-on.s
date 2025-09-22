	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -144
.main_label_entry:
# %op7 = call i32 @input()
	bl input
	st.w $a0, $fp, -20
# br label %label12
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -24
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -28
	b .main_label12
.main_label12:
# %op78 = phi i32 [ 0, %label_entry ], [ %op74, %label18 ]
# %op79 = phi i32 [ 0, %label_entry ], [ %op71, %label18 ]
# %op15 = icmp slt i32 %op78, %op7
	ld.w $t0, $fp, -24
	ld.w $t1, $fp, -20
	slt $t0, $t0, $t1
	st.b $t0, $fp, -29
# %op16 = zext i1 %op15 to i32
	ld.b $t0, $fp, -29
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -33
# %op17 = icmp ne i32 %op16, 0
	ld.w $t0, $fp, -33
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -34
# br i1 %op17, label %label18, label %label76
	ld.b $t0, $fp, -34
	bnez $t0, .main_label18
	b .main_label76
.main_label18:
# %op19 = fmul float 0x3ff3c0c200000000, 0x4016f06a20000000
	lu12i.w $t8, 260576
	ori $t8, $t8, 1552
	movgr2fr.w $ft1, $t8
	lu12i.w $t8, 265080
	ori $t8, $t8, 849
	movgr2fr.w $ft2, $t8
	fmul.s $ft0, $ft1, $ft2
	fst.s $ft0, $fp, -38
# %op20 = fmul float %op19, 0x4002aa9940000000
	fld.s $ft1, $fp, -38
	lu12i.w $t8, 262485
	ori $t8, $t8, 1226
	movgr2fr.w $ft2, $t8
	fmul.s $ft0, $ft1, $ft2
	fst.s $ft0, $fp, -42
# %op21 = fmul float %op20, 0x4011781d80000000
	fld.s $ft1, $fp, -42
	lu12i.w $t8, 264380
	ori $t8, $t8, 236
	movgr2fr.w $ft2, $t8
	fmul.s $ft0, $ft1, $ft2
	fst.s $ft0, $fp, -46
# %op22 = fmul float %op21, 0x401962ac40000000
	fld.s $ft1, $fp, -46
	lu12i.w $t8, 265393
	ori $t8, $t8, 1378
	movgr2fr.w $ft2, $t8
	fmul.s $ft0, $ft1, $ft2
	fst.s $ft0, $fp, -50
# %op24 = fptosi float %op22 to i32
	fld.s $ft0, $fp, -50
	ftintrz.w.s $ft1, $ft0
	movfr2gr.s $t0, $ft1
	st.w $t0, $fp, -54
# %op27 = mul i32 %op24, %op24
	ld.w $t0, $fp, -54
	ld.w $t1, $fp, -54
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -58
# %op29 = mul i32 %op27, %op24
	ld.w $t0, $fp, -58
	ld.w $t1, $fp, -54
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -62
# %op31 = mul i32 %op29, %op24
	ld.w $t0, $fp, -62
	ld.w $t1, $fp, -54
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -66
# %op33 = mul i32 %op31, %op24
	ld.w $t0, $fp, -66
	ld.w $t1, $fp, -54
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -70
# %op35 = mul i32 %op33, %op24
	ld.w $t0, $fp, -70
	ld.w $t1, $fp, -54
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -74
# %op39 = mul i32 %op35, %op35
	ld.w $t0, $fp, -74
	ld.w $t1, $fp, -74
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -78
# %op41 = mul i32 %op39, %op35
	ld.w $t0, $fp, -78
	ld.w $t1, $fp, -74
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -82
# %op43 = mul i32 %op41, %op35
	ld.w $t0, $fp, -82
	ld.w $t1, $fp, -74
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -86
# %op45 = mul i32 %op43, %op35
	ld.w $t0, $fp, -86
	ld.w $t1, $fp, -74
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -90
# %op47 = mul i32 %op45, %op35
	ld.w $t0, $fp, -90
	ld.w $t1, $fp, -74
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -94
# %op51 = mul i32 %op47, %op47
	ld.w $t0, $fp, -94
	ld.w $t1, $fp, -94
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -98
# %op53 = mul i32 %op51, %op47
	ld.w $t0, $fp, -98
	ld.w $t1, $fp, -94
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -102
# %op55 = mul i32 %op53, %op47
	ld.w $t0, $fp, -102
	ld.w $t1, $fp, -94
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -106
# %op57 = mul i32 %op55, %op47
	ld.w $t0, $fp, -106
	ld.w $t1, $fp, -94
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -110
# %op59 = mul i32 %op57, %op47
	ld.w $t0, $fp, -110
	ld.w $t1, $fp, -94
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -114
# %op63 = mul i32 %op59, %op59
	ld.w $t0, $fp, -114
	ld.w $t1, $fp, -114
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -118
# %op65 = mul i32 %op63, %op59
	ld.w $t0, $fp, -118
	ld.w $t1, $fp, -114
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -122
# %op67 = mul i32 %op65, %op59
	ld.w $t0, $fp, -122
	ld.w $t1, $fp, -114
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -126
# %op69 = mul i32 %op67, %op59
	ld.w $t0, $fp, -126
	ld.w $t1, $fp, -114
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -130
# %op71 = mul i32 %op69, %op59
	ld.w $t0, $fp, -130
	ld.w $t1, $fp, -114
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -134
# %op74 = add i32 %op78, 1
	ld.w $t0, $fp, -24
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -138
# br label %label12
	ld.w $a0, $fp, -138
	st.w $a0, $fp, -24
	ld.w $a0, $fp, -134
	st.w $a0, $fp, -28
	b .main_label12
.main_label76:
# call void @output(i32 %op79)
	ld.w $a0, $fp, -28
	bl output
# ret void
	addi.w  $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 144
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
