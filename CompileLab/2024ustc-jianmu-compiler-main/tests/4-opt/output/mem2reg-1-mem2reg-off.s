	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -368
.main_label_entry:
# %op0 = alloca i32
	addi.d $t0, $fp, -28
	st.d $t0, $fp, -24
# %op1 = alloca i32
	addi.d $t0, $fp, -40
	st.d $t0, $fp, -36
# %op2 = alloca i32
	addi.d $t0, $fp, -52
	st.d $t0, $fp, -48
# %op3 = alloca i32
	addi.d $t0, $fp, -64
	st.d $t0, $fp, -60
# %op4 = alloca i32
	addi.d $t0, $fp, -76
	st.d $t0, $fp, -72
# %op5 = alloca i32
	addi.d $t0, $fp, -88
	st.d $t0, $fp, -84
# %op6 = alloca i32
	addi.d $t0, $fp, -100
	st.d $t0, $fp, -96
# %op7 = call i32 @input()
	bl input
	st.w $a0, $fp, -104
# %op8 = load i32, i32* %op6
	ld.d $t0, $fp, -96
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -108
# store i32 %op7, i32* %op6
	ld.d $t0, $fp, -96
	ld.w $t1, $fp, -104
	st.w $t1, $t0, 0
# %op9 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -112
# store i32 0, i32* %op0
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# %op10 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -116
# store i32 0, i32* %op1
	ld.d $t0, $fp, -36
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# %op11 = load i32, i32* %op5
	ld.d $t0, $fp, -84
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -120
# store i32 0, i32* %op5
	ld.d $t0, $fp, -84
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# br label %label12
	b .main_label12
.main_label12:
# %op13 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -124
# %op14 = load i32, i32* %op6
	ld.d $t0, $fp, -96
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -128
# %op15 = icmp slt i32 %op13, %op14
	ld.w $t0, $fp, -124
	ld.w $t1, $fp, -128
	slt $t0, $t0, $t1
	st.b $t0, $fp, -129
# %op16 = zext i1 %op15 to i32
	ld.b $t0, $fp, -129
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -133
# %op17 = icmp ne i32 %op16, 0
	ld.w $t0, $fp, -133
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -134
# br i1 %op17, label %label18, label %label76
	ld.b $t0, $fp, -134
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
	fst.s $ft0, $fp, -138
# %op20 = fmul float %op19, 0x4002aa9940000000
	fld.s $ft1, $fp, -138
	lu12i.w $t8, 262485
	ori $t8, $t8, 1226
	movgr2fr.w $ft2, $t8
	fmul.s $ft0, $ft1, $ft2
	fst.s $ft0, $fp, -142
# %op21 = fmul float %op20, 0x4011781d80000000
	fld.s $ft1, $fp, -142
	lu12i.w $t8, 264380
	ori $t8, $t8, 236
	movgr2fr.w $ft2, $t8
	fmul.s $ft0, $ft1, $ft2
	fst.s $ft0, $fp, -146
# %op22 = fmul float %op21, 0x401962ac40000000
	fld.s $ft1, $fp, -146
	lu12i.w $t8, 265393
	ori $t8, $t8, 1378
	movgr2fr.w $ft2, $t8
	fmul.s $ft0, $ft1, $ft2
	fst.s $ft0, $fp, -150
# %op23 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -154
# %op24 = fptosi float %op22 to i32
	fld.s $ft0, $fp, -150
	ftintrz.w.s $ft1, $ft0
	movfr2gr.s $t0, $ft1
	st.w $t0, $fp, -158
# store i32 %op24, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t1, $fp, -158
	st.w $t1, $t0, 0
# %op25 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -162
# %op26 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -166
# %op27 = mul i32 %op25, %op26
	ld.w $t0, $fp, -162
	ld.w $t1, $fp, -166
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -170
# %op28 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -174
# %op29 = mul i32 %op27, %op28
	ld.w $t0, $fp, -170
	ld.w $t1, $fp, -174
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -178
# %op30 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -182
# %op31 = mul i32 %op29, %op30
	ld.w $t0, $fp, -178
	ld.w $t1, $fp, -182
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -186
# %op32 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -190
# %op33 = mul i32 %op31, %op32
	ld.w $t0, $fp, -186
	ld.w $t1, $fp, -190
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -194
# %op34 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -198
# %op35 = mul i32 %op33, %op34
	ld.w $t0, $fp, -194
	ld.w $t1, $fp, -198
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -202
# %op36 = load i32, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -206
# store i32 %op35, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t1, $fp, -202
	st.w $t1, $t0, 0
# %op37 = load i32, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -210
# %op38 = load i32, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -214
# %op39 = mul i32 %op37, %op38
	ld.w $t0, $fp, -210
	ld.w $t1, $fp, -214
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -218
# %op40 = load i32, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -222
# %op41 = mul i32 %op39, %op40
	ld.w $t0, $fp, -218
	ld.w $t1, $fp, -222
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -226
# %op42 = load i32, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -230
# %op43 = mul i32 %op41, %op42
	ld.w $t0, $fp, -226
	ld.w $t1, $fp, -230
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -234
# %op44 = load i32, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -238
# %op45 = mul i32 %op43, %op44
	ld.w $t0, $fp, -234
	ld.w $t1, $fp, -238
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -242
# %op46 = load i32, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -246
# %op47 = mul i32 %op45, %op46
	ld.w $t0, $fp, -242
	ld.w $t1, $fp, -246
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -250
# %op48 = load i32, i32* %op3
	ld.d $t0, $fp, -60
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -254
# store i32 %op47, i32* %op3
	ld.d $t0, $fp, -60
	ld.w $t1, $fp, -250
	st.w $t1, $t0, 0
# %op49 = load i32, i32* %op3
	ld.d $t0, $fp, -60
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -258
# %op50 = load i32, i32* %op3
	ld.d $t0, $fp, -60
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -262
# %op51 = mul i32 %op49, %op50
	ld.w $t0, $fp, -258
	ld.w $t1, $fp, -262
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -266
# %op52 = load i32, i32* %op3
	ld.d $t0, $fp, -60
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -270
# %op53 = mul i32 %op51, %op52
	ld.w $t0, $fp, -266
	ld.w $t1, $fp, -270
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -274
# %op54 = load i32, i32* %op3
	ld.d $t0, $fp, -60
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -278
# %op55 = mul i32 %op53, %op54
	ld.w $t0, $fp, -274
	ld.w $t1, $fp, -278
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -282
# %op56 = load i32, i32* %op3
	ld.d $t0, $fp, -60
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -286
# %op57 = mul i32 %op55, %op56
	ld.w $t0, $fp, -282
	ld.w $t1, $fp, -286
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -290
# %op58 = load i32, i32* %op3
	ld.d $t0, $fp, -60
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -294
# %op59 = mul i32 %op57, %op58
	ld.w $t0, $fp, -290
	ld.w $t1, $fp, -294
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -298
# %op60 = load i32, i32* %op4
	ld.d $t0, $fp, -72
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -302
# store i32 %op59, i32* %op4
	ld.d $t0, $fp, -72
	ld.w $t1, $fp, -298
	st.w $t1, $t0, 0
# %op61 = load i32, i32* %op4
	ld.d $t0, $fp, -72
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -306
# %op62 = load i32, i32* %op4
	ld.d $t0, $fp, -72
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -310
# %op63 = mul i32 %op61, %op62
	ld.w $t0, $fp, -306
	ld.w $t1, $fp, -310
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -314
# %op64 = load i32, i32* %op4
	ld.d $t0, $fp, -72
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -318
# %op65 = mul i32 %op63, %op64
	ld.w $t0, $fp, -314
	ld.w $t1, $fp, -318
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -322
# %op66 = load i32, i32* %op4
	ld.d $t0, $fp, -72
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -326
# %op67 = mul i32 %op65, %op66
	ld.w $t0, $fp, -322
	ld.w $t1, $fp, -326
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -330
# %op68 = load i32, i32* %op4
	ld.d $t0, $fp, -72
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -334
# %op69 = mul i32 %op67, %op68
	ld.w $t0, $fp, -330
	ld.w $t1, $fp, -334
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -338
# %op70 = load i32, i32* %op4
	ld.d $t0, $fp, -72
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -342
# %op71 = mul i32 %op69, %op70
	ld.w $t0, $fp, -338
	ld.w $t1, $fp, -342
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -346
# %op72 = load i32, i32* %op5
	ld.d $t0, $fp, -84
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -350
# store i32 %op71, i32* %op5
	ld.d $t0, $fp, -84
	ld.w $t1, $fp, -346
	st.w $t1, $t0, 0
# %op73 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -354
# %op74 = add i32 %op73, 1
	ld.w $t0, $fp, -354
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -358
# %op75 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -362
# store i32 %op74, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $fp, -358
	st.w $t1, $t0, 0
# br label %label12
	b .main_label12
.main_label76:
# %op77 = load i32, i32* %op5
	ld.d $t0, $fp, -84
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -366
# call void @output(i32 %op77)
	ld.w $a0, $fp, -366
	bl output
# ret void
	addi.w  $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 368
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
