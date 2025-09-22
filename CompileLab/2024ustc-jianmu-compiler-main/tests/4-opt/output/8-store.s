	.text
	.globl store
	.type store, @function
store:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -48
	st.d $a0, $fp, -24
	st.w $a1, $fp, -28
	st.w $a2, $fp, -32
.store_label_entry:
# %op9 = icmp sge i32 %arg1, 0
	ld.w $t0, $fp, -28
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -33
# br i1 %op9, label %label11, label %label10
	ld.b $t0, $fp, -33
	bnez $t0, .store_label11
	b .store_label10
.store_label10:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label14
	b .store_label14
.store_label11:
# %op12 = getelementptr i32, i32* %arg0, i32 %arg1
	ld.d $t0, $fp, -24
	ld.w $t1, $fp, -28
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -41
# br label %label14
	b .store_label14
.store_label14:
# store i32 %arg2, i32* %op12
	ld.d $t0, $fp, -41
	ld.w $t1, $fp, -32
	st.w $t1, $t0, 0
# ret i32 %arg2
	ld.w $a0, $fp, -32
	b store_exit
store_exit:
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -144
.main_label_entry:
# %op0 = alloca [10 x i32]
	addi.d $t0, $fp, -64
	st.d $t0, $fp, -24
# br label %label45
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -125
	b .main_label45
.main_label4:
# %op42 = phi i32 [ %op16, %label9 ], [ %op46, %label45 ]
# %op6 = icmp slt i32 %op42, 10
	ld.w $t0, $fp, -68
	addi.w $t1, $zero, 10
	slt $t0, $t0, $t1
	st.b $t0, $fp, -69
# %op7 = zext i1 %op6 to i32
	ld.b $t0, $fp, -69
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -73
# %op8 = icmp ne i32 %op7, 0
	ld.w $t0, $fp, -73
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -74
# br i1 %op8, label %label9, label %label18
	ld.b $t0, $fp, -74
	bnez $t0, .main_label9
	b .main_label18
.main_label9:
# %op13 = mul i32 %op42, 2
	ld.w $t0, $fp, -68
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -78
# %op14 = call i32 @store(i32* %op10, i32 %op42, i32 %op13)
	ld.d $a0, $fp, -133
	ld.w $a1, $fp, -68
	ld.w $a2, $fp, -78
	bl store
	st.w $a0, $fp, -82
# %op16 = add i32 %op42, 1
	ld.w $t0, $fp, -68
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -86
# br label %label4
	ld.w $a0, $fp, -86
	st.w $a0, $fp, -68
	b .main_label4
.main_label18:
# br label %label21
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -90
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -94
	b .main_label21
.main_label21:
# %op43 = phi i32 [ 0, %label18 ], [ %op37, %label36 ]
# %op44 = phi i32 [ 0, %label18 ], [ %op40, %label36 ]
# %op23 = icmp slt i32 %op44, 10
	ld.w $t0, $fp, -94
	addi.w $t1, $zero, 10
	slt $t0, $t0, $t1
	st.b $t0, $fp, -95
# %op24 = zext i1 %op23 to i32
	ld.b $t0, $fp, -95
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -99
# %op25 = icmp ne i32 %op24, 0
	ld.w $t0, $fp, -99
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	st.b $t0, $fp, -100
# br i1 %op25, label %label26, label %label30
	ld.b $t0, $fp, -100
	bnez $t0, .main_label26
	b .main_label30
.main_label26:
# %op29 = icmp sge i32 %op44, 0
	ld.w $t0, $fp, -94
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -101
# br i1 %op29, label %label33, label %label32
	ld.b $t0, $fp, -101
	bnez $t0, .main_label33
	b .main_label32
.main_label30:
# call void @output(i32 %op43)
	ld.w $a0, $fp, -90
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label32:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label36
	b .main_label36
.main_label33:
# %op34 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 %op44
	ld.d $t0, $fp, -24
	ld.w $t1, $fp, -94
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -109
# %op35 = load i32, i32* %op34
	ld.d $t0, $fp, -109
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -113
# br label %label36
	b .main_label36
.main_label36:
# %op37 = add i32 %op43, %op35
	ld.w $t0, $fp, -90
	ld.w $t1, $fp, -113
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -117
# %op40 = add i32 %op44, 1
	ld.w $t0, $fp, -94
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -121
# br label %label21
	ld.w $a0, $fp, -117
	st.w $a0, $fp, -90
	ld.w $a0, $fp, -121
	st.w $a0, $fp, -94
	b .main_label21
.main_label45:
# %op46 = phi i32 [ 0, %label_entry ]
# %op10 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -133
# br label %label4
	ld.w $a0, $fp, -125
	st.w $a0, $fp, -68
	b .main_label4
main_exit:
	addi.d $sp, $sp, 144
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
