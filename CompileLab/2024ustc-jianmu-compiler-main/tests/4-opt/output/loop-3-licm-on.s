	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -256
.main_label_entry:
# br label %label143
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -168
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -168
	b .main_label143
.main_label10:
# %op116 = phi i32 [ %op118, %label26 ], [ undef, %label143 ]
# %op117 = phi i32 [ %op28, %label26 ], [ %op144, %label143 ]
# %op12 = icmp slt i32 %op117, 1000000
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
# br label %label140
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -160
	ld.w $a0, $fp, -20
	st.w $a0, $fp, -164
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -160
	ld.w $a0, $fp, -20
	st.w $a0, $fp, -164
	b .main_label140
.main_label17:
# call void @output(i32 %op116)
	ld.w $a0, $fp, -20
	bl output
# ret void
	addi.w  $a0, $zero, 0
	b main_exit
.main_label19:
# %op118 = phi i32 [ %op120, %label37 ], [ %op142, %label140 ]
# %op119 = phi i32 [ %op39, %label37 ], [ %op141, %label140 ]
# %op21 = icmp slt i32 %op119, 2
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
# br label %label137
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -152
	ld.w $a0, $fp, -34
	st.w $a0, $fp, -156
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -152
	ld.w $a0, $fp, -34
	st.w $a0, $fp, -156
	b .main_label137
.main_label26:
# %op28 = add i32 %op117, 1
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
# %op120 = phi i32 [ %op122, %label48 ], [ %op139, %label137 ]
# %op121 = phi i32 [ %op50, %label48 ], [ %op138, %label137 ]
# %op32 = icmp slt i32 %op121, 2
	ld.w $t0, $fp, -56
	addi.w $t1, $zero, 2
	slt $t0, $t0, $t1
	st.b $t0, $fp, -57
# %op33 = zext i1 %op32 to i32
	ld.b $t0, $fp, -57
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -61
# %op34 = icmp ne i32 %op33, 0
	ld.w $t0, $fp, -61
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -62
# br i1 %op34, label %label35, label %label37
	ld.b $t0, $fp, -62
	bnez $t0, .main_label35
	b .main_label37
.main_label35:
# br label %label134
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -144
	ld.w $a0, $fp, -52
	st.w $a0, $fp, -148
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -144
	ld.w $a0, $fp, -52
	st.w $a0, $fp, -148
	b .main_label134
.main_label37:
# %op39 = add i32 %op119, 1
	ld.w $t0, $fp, -38
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -66
# br label %label19
	ld.w $a0, $fp, -52
	st.w $a0, $fp, -34
	ld.w $a0, $fp, -66
	st.w $a0, $fp, -38
	b .main_label19
.main_label41:
# %op122 = phi i32 [ %op124, %label59 ], [ %op136, %label134 ]
# %op123 = phi i32 [ %op61, %label59 ], [ %op135, %label134 ]
# %op43 = icmp slt i32 %op123, 2
	ld.w $t0, $fp, -74
	addi.w $t1, $zero, 2
	slt $t0, $t0, $t1
	st.b $t0, $fp, -75
# %op44 = zext i1 %op43 to i32
	ld.b $t0, $fp, -75
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -79
# %op45 = icmp ne i32 %op44, 0
	ld.w $t0, $fp, -79
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -80
# br i1 %op45, label %label46, label %label48
	ld.b $t0, $fp, -80
	bnez $t0, .main_label46
	b .main_label48
.main_label46:
# br label %label131
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -136
	ld.w $a0, $fp, -70
	st.w $a0, $fp, -140
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -136
	ld.w $a0, $fp, -70
	st.w $a0, $fp, -140
	b .main_label131
.main_label48:
# %op50 = add i32 %op121, 1
	ld.w $t0, $fp, -56
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -84
# br label %label30
	ld.w $a0, $fp, -70
	st.w $a0, $fp, -52
	ld.w $a0, $fp, -84
	st.w $a0, $fp, -56
	b .main_label30
.main_label52:
# %op124 = phi i32 [ %op126, %label112 ], [ %op133, %label131 ]
# %op125 = phi i32 [ %op114, %label112 ], [ %op132, %label131 ]
# %op54 = icmp slt i32 %op125, 2
	ld.w $t0, $fp, -92
	addi.w $t1, $zero, 2
	slt $t0, $t0, $t1
	st.b $t0, $fp, -93
# %op55 = zext i1 %op54 to i32
	ld.b $t0, $fp, -93
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -97
# %op56 = icmp ne i32 %op55, 0
	ld.w $t0, $fp, -97
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -98
# br i1 %op56, label %label57, label %label59
	ld.b $t0, $fp, -98
	bnez $t0, .main_label57
	b .main_label59
.main_label57:
# br label %label128
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -128
	ld.w $a0, $fp, -88
	st.w $a0, $fp, -132
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -128
	ld.w $a0, $fp, -88
	st.w $a0, $fp, -132
	b .main_label128
.main_label59:
# %op61 = add i32 %op123, 1
	ld.w $t0, $fp, -74
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -102
# br label %label41
	ld.w $a0, $fp, -88
	st.w $a0, $fp, -70
	ld.w $a0, $fp, -102
	st.w $a0, $fp, -74
	b .main_label41
.main_label63:
# %op126 = phi i32 [ %op107, %label68 ], [ %op130, %label128 ]
# %op127 = phi i32 [ %op110, %label68 ], [ %op129, %label128 ]
# %op65 = icmp slt i32 %op127, 2
	ld.w $t0, $fp, -110
	addi.w $t1, $zero, 2
	slt $t0, $t0, $t1
	st.b $t0, $fp, -111
# %op66 = zext i1 %op65 to i32
	ld.b $t0, $fp, -111
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -115
# %op67 = icmp ne i32 %op66, 0
	ld.w $t0, $fp, -115
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -116
# br i1 %op67, label %label68, label %label112
	ld.b $t0, $fp, -116
	bnez $t0, .main_label68
	b .main_label112
.main_label68:
# %op110 = add i32 %op127, 1
	ld.w $t0, $fp, -110
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -120
# br label %label63
	ld.w $a0, $fp, -244
	st.w $a0, $fp, -106
	ld.w $a0, $fp, -120
	st.w $a0, $fp, -110
	b .main_label63
.main_label112:
# %op114 = add i32 %op125, 1
	ld.w $t0, $fp, -92
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -124
# br label %label52
	ld.w $a0, $fp, -106
	st.w $a0, $fp, -88
	ld.w $a0, $fp, -124
	st.w $a0, $fp, -92
	b .main_label52
.main_label128:
# %op129 = phi i32 [ 0, %label57 ]
# %op130 = phi i32 [ %op124, %label57 ]
# br label %label63
	ld.w $a0, $fp, -132
	st.w $a0, $fp, -106
	ld.w $a0, $fp, -128
	st.w $a0, $fp, -110
	b .main_label63
.main_label131:
# %op132 = phi i32 [ 0, %label46 ]
# %op133 = phi i32 [ %op122, %label46 ]
# br label %label52
	ld.w $a0, $fp, -140
	st.w $a0, $fp, -88
	ld.w $a0, $fp, -136
	st.w $a0, $fp, -92
	b .main_label52
.main_label134:
# %op135 = phi i32 [ 0, %label35 ]
# %op136 = phi i32 [ %op120, %label35 ]
# br label %label41
	ld.w $a0, $fp, -148
	st.w $a0, $fp, -70
	ld.w $a0, $fp, -144
	st.w $a0, $fp, -74
	b .main_label41
.main_label137:
# %op138 = phi i32 [ 0, %label24 ]
# %op139 = phi i32 [ %op118, %label24 ]
# br label %label30
	ld.w $a0, $fp, -156
	st.w $a0, $fp, -52
	ld.w $a0, $fp, -152
	st.w $a0, $fp, -56
	b .main_label30
.main_label140:
# %op141 = phi i32 [ 0, %label15 ]
# %op142 = phi i32 [ %op116, %label15 ]
# br label %label19
	ld.w $a0, $fp, -164
	st.w $a0, $fp, -34
	ld.w $a0, $fp, -160
	st.w $a0, $fp, -38
	b .main_label19
.main_label143:
# %op144 = phi i32 [ 0, %label_entry ]
# %op71 = mul i32 2, 2
	addi.w $t0, $zero, 2
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -172
# %op73 = mul i32 %op71, 2
	ld.w $t0, $fp, -172
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -176
# %op75 = mul i32 %op73, 2
	ld.w $t0, $fp, -176
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -180
# %op77 = mul i32 %op75, 2
	ld.w $t0, $fp, -180
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -184
# %op79 = mul i32 %op77, 2
	ld.w $t0, $fp, -184
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -188
# %op81 = mul i32 %op79, 2
	ld.w $t0, $fp, -188
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -192
# %op83 = mul i32 %op81, 2
	ld.w $t0, $fp, -192
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -196
# %op85 = mul i32 %op83, 2
	ld.w $t0, $fp, -196
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -200
# %op87 = mul i32 %op85, 2
	ld.w $t0, $fp, -200
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -204
# %op89 = sdiv i32 %op87, 2
	ld.w $t0, $fp, -204
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -208
# %op91 = sdiv i32 %op89, 2
	ld.w $t0, $fp, -208
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -212
# %op93 = sdiv i32 %op91, 2
	ld.w $t0, $fp, -212
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -216
# %op95 = sdiv i32 %op93, 2
	ld.w $t0, $fp, -216
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -220
# %op97 = sdiv i32 %op95, 2
	ld.w $t0, $fp, -220
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -224
# %op99 = sdiv i32 %op97, 2
	ld.w $t0, $fp, -224
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -228
# %op101 = sdiv i32 %op99, 2
	ld.w $t0, $fp, -228
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -232
# %op103 = sdiv i32 %op101, 2
	ld.w $t0, $fp, -232
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -236
# %op105 = sdiv i32 %op103, 2
	ld.w $t0, $fp, -236
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -240
# %op107 = sdiv i32 %op105, 2
	ld.w $t0, $fp, -240
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -244
# br label %label10
	ld.w $a0, $fp, -168
	st.w $a0, $fp, -24
	b .main_label10
main_exit:
	addi.d $sp, $sp, 256
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
