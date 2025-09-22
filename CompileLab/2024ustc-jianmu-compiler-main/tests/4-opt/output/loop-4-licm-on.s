	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -304
.main_label_entry:
# br label %label161
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -208
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -208
	b .main_label161
.main_label10:
# %op125 = phi i32 [ %op127, %label26 ], [ undef, %label161 ]
# %op126 = phi i32 [ %op28, %label26 ], [ %op162, %label161 ]
# %op12 = icmp slt i32 %op126, 1000000
	ld.w $t0, $fp, -24
	lu12i.w $t1, 244
	ori $t1, $t1, 576
	slt $t0, $t0, $t1
	st.b $t0, $fp, -25
# %op13 = zext i1 %op12 to i32
	ld.b $t0, $fp, -25
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -29
# %op14 = icmp ne i32 %op13, 0
	ld.w $t0, $fp, -29
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -30
# br i1 %op14, label %label15, label %label17
	ld.b $t0, $fp, -30
	bnez $t0, .main_label15
	b .main_label17
.main_label15:
# br label %label158
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -200
	ld.w $a0, $fp, -20
	st.w $a0, $fp, -204
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -200
	ld.w $a0, $fp, -20
	st.w $a0, $fp, -204
	b .main_label158
.main_label17:
# call void @output(i32 %op125)
	ld.w $a0, $fp, -20
	bl output
# ret void
	addi.w  $a0, $zero, 0
	b main_exit
.main_label19:
# %op127 = phi i32 [ %op129, %label37 ], [ %op160, %label158 ]
# %op128 = phi i32 [ %op39, %label37 ], [ %op159, %label158 ]
# %op21 = icmp slt i32 %op128, 2
	ld.w $t0, $fp, -38
	addi.w $t1, $zero, 2
	slt $t0, $t0, $t1
	st.b $t0, $fp, -39
# %op22 = zext i1 %op21 to i32
	ld.b $t0, $fp, -39
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -43
# %op23 = icmp ne i32 %op22, 0
	ld.w $t0, $fp, -43
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -44
# br i1 %op23, label %label24, label %label26
	ld.b $t0, $fp, -44
	bnez $t0, .main_label24
	b .main_label26
.main_label24:
# br label %label154
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -188
	ld.w $a0, $fp, -38
	st.w $a0, $fp, -192
	ld.w $a0, $fp, -34
	st.w $a0, $fp, -196
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -188
	ld.w $a0, $fp, -38
	st.w $a0, $fp, -192
	ld.w $a0, $fp, -34
	st.w $a0, $fp, -196
	b .main_label154
.main_label26:
# %op28 = add i32 %op126, 1
	ld.w $t0, $fp, -24
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -48
# br label %label10
	ld.w $a0, $fp, -34
	st.w $a0, $fp, -20
	ld.w $a0, $fp, -48
	st.w $a0, $fp, -24
	b .main_label10
.main_label30:
# %op129 = phi i32 [ %op132, %label48 ], [ %op157, %label154 ]
# %op130 = phi i32 [ %op133, %label48 ], [ %op156, %label154 ]
# %op131 = phi i32 [ %op50, %label48 ], [ %op155, %label154 ]
# %op32 = icmp slt i32 %op131, 2
	ld.w $t0, $fp, -60
	addi.w $t1, $zero, 2
	slt $t0, $t0, $t1
	st.b $t0, $fp, -61
# %op33 = zext i1 %op32 to i32
	ld.b $t0, $fp, -61
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -65
# %op34 = icmp ne i32 %op33, 0
	ld.w $t0, $fp, -65
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -66
# br i1 %op34, label %label35, label %label37
	ld.b $t0, $fp, -66
	bnez $t0, .main_label35
	b .main_label37
.main_label35:
# br label %label150
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -176
	ld.w $a0, $fp, -56
	st.w $a0, $fp, -180
	ld.w $a0, $fp, -52
	st.w $a0, $fp, -184
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -176
	ld.w $a0, $fp, -56
	st.w $a0, $fp, -180
	ld.w $a0, $fp, -52
	st.w $a0, $fp, -184
	b .main_label150
.main_label37:
# %op39 = add i32 %op130, 1
	ld.w $t0, $fp, -56
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -70
# br label %label19
	ld.w $a0, $fp, -52
	st.w $a0, $fp, -34
	ld.w $a0, $fp, -70
	st.w $a0, $fp, -38
	b .main_label19
.main_label41:
# %op132 = phi i32 [ %op135, %label59 ], [ %op153, %label150 ]
# %op133 = phi i32 [ %op136, %label59 ], [ %op152, %label150 ]
# %op134 = phi i32 [ %op61, %label59 ], [ %op151, %label150 ]
# %op43 = icmp slt i32 %op134, 2
	ld.w $t0, $fp, -82
	addi.w $t1, $zero, 2
	slt $t0, $t0, $t1
	st.b $t0, $fp, -83
# %op44 = zext i1 %op43 to i32
	ld.b $t0, $fp, -83
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -87
# %op45 = icmp ne i32 %op44, 0
	ld.w $t0, $fp, -87
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -88
# br i1 %op45, label %label46, label %label48
	ld.b $t0, $fp, -88
	bnez $t0, .main_label46
	b .main_label48
.main_label46:
# br label %label146
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -164
	ld.w $a0, $fp, -78
	st.w $a0, $fp, -168
	ld.w $a0, $fp, -74
	st.w $a0, $fp, -172
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -164
	ld.w $a0, $fp, -78
	st.w $a0, $fp, -168
	ld.w $a0, $fp, -74
	st.w $a0, $fp, -172
	b .main_label146
.main_label48:
# %op50 = add i32 %op131, 1
	ld.w $t0, $fp, -60
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -92
# br label %label30
	ld.w $a0, $fp, -74
	st.w $a0, $fp, -52
	ld.w $a0, $fp, -78
	st.w $a0, $fp, -56
	ld.w $a0, $fp, -92
	st.w $a0, $fp, -60
	b .main_label30
.main_label52:
# %op135 = phi i32 [ %op138, %label73 ], [ %op149, %label146 ]
# %op136 = phi i32 [ %op139, %label73 ], [ %op148, %label146 ]
# %op137 = phi i32 [ %op75, %label73 ], [ %op147, %label146 ]
# %op54 = icmp slt i32 %op137, 2
	ld.w $t0, $fp, -104
	addi.w $t1, $zero, 2
	slt $t0, $t0, $t1
	st.b $t0, $fp, -105
# %op55 = zext i1 %op54 to i32
	ld.b $t0, $fp, -105
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -109
# %op56 = icmp ne i32 %op55, 0
	ld.w $t0, $fp, -109
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -110
# br i1 %op56, label %label57, label %label59
	ld.b $t0, $fp, -110
	bnez $t0, .main_label57
	b .main_label59
.main_label57:
# br label %label142
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -152
	ld.w $a0, $fp, -100
	st.w $a0, $fp, -156
	ld.w $a0, $fp, -96
	st.w $a0, $fp, -160
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -152
	ld.w $a0, $fp, -100
	st.w $a0, $fp, -156
	ld.w $a0, $fp, -96
	st.w $a0, $fp, -160
	b .main_label142
.main_label59:
# %op61 = add i32 %op134, 1
	ld.w $t0, $fp, -82
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -114
# br label %label41
	ld.w $a0, $fp, -96
	st.w $a0, $fp, -74
	ld.w $a0, $fp, -100
	st.w $a0, $fp, -78
	ld.w $a0, $fp, -114
	st.w $a0, $fp, -82
	b .main_label41
.main_label63:
# %op138 = phi i32 [ %op120, %label81 ], [ %op145, %label142 ]
# %op139 = phi i32 [ %op141, %label81 ], [ %op144, %label142 ]
# %op140 = phi i32 [ %op123, %label81 ], [ %op143, %label142 ]
# %op65 = icmp slt i32 %op140, 2
	ld.w $t0, $fp, -126
	addi.w $t1, $zero, 2
	slt $t0, $t0, $t1
	st.b $t0, $fp, -127
# %op66 = zext i1 %op65 to i32
	ld.b $t0, $fp, -127
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -131
# %op67 = icmp ne i32 %op66, 0
	ld.w $t0, $fp, -131
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -132
# br i1 %op67, label %label68, label %label73
	ld.b $t0, $fp, -132
	bnez $t0, .main_label68
	b .main_label73
.main_label68:
# br i1 %op72, label %label77, label %label81
	ld.w $a0, $fp, -122
	st.w $a0, $fp, -144
	ld.b $t0, $fp, -214
	bnez $t0, .main_label77
	b .main_label81
.main_label73:
# %op75 = add i32 %op137, 1
	ld.w $t0, $fp, -104
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -136
# br label %label52
	ld.w $a0, $fp, -118
	st.w $a0, $fp, -96
	ld.w $a0, $fp, -122
	st.w $a0, $fp, -100
	ld.w $a0, $fp, -136
	st.w $a0, $fp, -104
	b .main_label52
.main_label77:
# %op79 = add i32 %op139, 1
	ld.w $t0, $fp, -122
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -140
# br label %label81
	ld.w $a0, $fp, -140
	st.w $a0, $fp, -144
	b .main_label81
.main_label81:
# %op141 = phi i32 [ %op139, %label68 ], [ %op79, %label77 ]
# %op123 = add i32 %op140, 1
	ld.w $t0, $fp, -126
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -148
# br label %label63
	ld.w $a0, $fp, -290
	st.w $a0, $fp, -118
	ld.w $a0, $fp, -144
	st.w $a0, $fp, -122
	ld.w $a0, $fp, -148
	st.w $a0, $fp, -126
	b .main_label63
.main_label142:
# %op143 = phi i32 [ 0, %label57 ]
# %op144 = phi i32 [ %op136, %label57 ]
# %op145 = phi i32 [ %op135, %label57 ]
# br label %label63
	ld.w $a0, $fp, -160
	st.w $a0, $fp, -118
	ld.w $a0, $fp, -156
	st.w $a0, $fp, -122
	ld.w $a0, $fp, -152
	st.w $a0, $fp, -126
	b .main_label63
.main_label146:
# %op147 = phi i32 [ 0, %label46 ]
# %op148 = phi i32 [ %op133, %label46 ]
# %op149 = phi i32 [ %op132, %label46 ]
# br label %label52
	ld.w $a0, $fp, -172
	st.w $a0, $fp, -96
	ld.w $a0, $fp, -168
	st.w $a0, $fp, -100
	ld.w $a0, $fp, -164
	st.w $a0, $fp, -104
	b .main_label52
.main_label150:
# %op151 = phi i32 [ 0, %label35 ]
# %op152 = phi i32 [ %op130, %label35 ]
# %op153 = phi i32 [ %op129, %label35 ]
# br label %label41
	ld.w $a0, $fp, -184
	st.w $a0, $fp, -74
	ld.w $a0, $fp, -180
	st.w $a0, $fp, -78
	ld.w $a0, $fp, -176
	st.w $a0, $fp, -82
	b .main_label41
.main_label154:
# %op155 = phi i32 [ 0, %label24 ]
# %op156 = phi i32 [ %op128, %label24 ]
# %op157 = phi i32 [ %op127, %label24 ]
# br label %label30
	ld.w $a0, $fp, -196
	st.w $a0, $fp, -52
	ld.w $a0, $fp, -192
	st.w $a0, $fp, -56
	ld.w $a0, $fp, -188
	st.w $a0, $fp, -60
	b .main_label30
.main_label158:
# %op159 = phi i32 [ 0, %label15 ]
# %op160 = phi i32 [ %op125, %label15 ]
# br label %label19
	ld.w $a0, $fp, -204
	st.w $a0, $fp, -34
	ld.w $a0, $fp, -200
	st.w $a0, $fp, -38
	b .main_label19
.main_label161:
# %op162 = phi i32 [ 0, %label_entry ]
# %op70 = icmp sgt i32 2, 1
	addi.w $t0, $zero, 2
	addi.w $t1, $zero, 1
	slt $t0, $t1, $t0
	st.b $t0, $fp, -209
# %op71 = zext i1 %op70 to i32
	ld.b $t0, $fp, -209
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -213
# %op72 = icmp sgt i32 %op71, 0
	ld.w $t0, $fp, -213
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -214
# %op84 = mul i32 2, 2
	addi.w $t0, $zero, 2
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -218
# %op86 = mul i32 %op84, 2
	ld.w $t0, $fp, -218
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -222
# %op88 = mul i32 %op86, 2
	ld.w $t0, $fp, -222
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -226
# %op90 = mul i32 %op88, 2
	ld.w $t0, $fp, -226
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -230
# %op92 = mul i32 %op90, 2
	ld.w $t0, $fp, -230
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -234
# %op94 = mul i32 %op92, 2
	ld.w $t0, $fp, -234
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -238
# %op96 = mul i32 %op94, 2
	ld.w $t0, $fp, -238
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -242
# %op98 = mul i32 %op96, 2
	ld.w $t0, $fp, -242
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -246
# %op100 = mul i32 %op98, 2
	ld.w $t0, $fp, -246
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -250
# %op102 = sdiv i32 %op100, 2
	ld.w $t0, $fp, -250
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -254
# %op104 = sdiv i32 %op102, 2
	ld.w $t0, $fp, -254
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -258
# %op106 = sdiv i32 %op104, 2
	ld.w $t0, $fp, -258
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -262
# %op108 = sdiv i32 %op106, 2
	ld.w $t0, $fp, -262
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -266
# %op110 = sdiv i32 %op108, 2
	ld.w $t0, $fp, -266
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -270
# %op112 = sdiv i32 %op110, 2
	ld.w $t0, $fp, -270
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -274
# %op114 = sdiv i32 %op112, 2
	ld.w $t0, $fp, -274
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -278
# %op116 = sdiv i32 %op114, 2
	ld.w $t0, $fp, -278
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -282
# %op118 = sdiv i32 %op116, 2
	ld.w $t0, $fp, -282
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -286
# %op120 = sdiv i32 %op118, 2
	ld.w $t0, $fp, -286
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -290
# br label %label10
	ld.w $a0, $fp, -208
	st.w $a0, $fp, -24
	b .main_label10
main_exit:
	addi.d $sp, $sp, 304
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
