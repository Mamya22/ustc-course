# Global variables
	.text
	.section .bss, "aw", @nobits
	.globl x
	.type x, @object
	.size x, 4
x:
	.space 4
	.globl y
	.type y, @object
	.size y, 4
y:
	.space 4
	.text
	.globl gcd
	.type gcd, @function
gcd:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -48
	st.w $a0, $fp, -20
	st.w $a1, $fp, -24
.gcd_label_entry:
# %op5 = icmp eq i32 %arg1, 0
	ld.w $t0, $fp, -24
	addi.w $t1, $zero, 0
	xor $t0, $t0, $t1
	sltu $t0, $zero, $t0
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -25
# %op6 = zext i1 %op5 to i32
	ld.b $t0, $fp, -25
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -29
# %op7 = icmp sgt i32 %op6, 0
	ld.w $t0, $fp, -29
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -30
# br i1 %op7, label %label8, label %label11
	ld.b $t0, $fp, -30
	bnez $t0, .gcd_label8
	b .gcd_label11
.gcd_label8:
# ret i32 %arg0
	ld.w $a0, $fp, -20
	b gcd_exit
.gcd_label11:
# %op16 = sdiv i32 %arg0, %arg1
	ld.w $t0, $fp, -20
	ld.w $t1, $fp, -24
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -34
# %op18 = mul i32 %op16, %arg1
	ld.w $t0, $fp, -34
	ld.w $t1, $fp, -24
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -38
# %op19 = sub i32 %arg0, %op18
	ld.w $t0, $fp, -20
	ld.w $t1, $fp, -38
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -42
# %op20 = call i32 @gcd(i32 %arg1, i32 %op19)
	ld.w $a0, $fp, -24
	ld.w $a1, $fp, -42
	bl gcd
	st.w $a0, $fp, -46
# ret i32 %op20
	ld.w $a0, $fp, -46
	b gcd_exit
gcd_exit:
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl funArray
	.type funArray, @function
funArray:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -80
	st.d $a0, $fp, -24
	st.d $a1, $fp, -32
.funArray_label_entry:
# %op9 = icmp sge i32 0, 0
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -33
# br i1 %op9, label %label11, label %label10
	ld.b $t0, $fp, -33
	bnez $t0, .funArray_label11
	b .funArray_label10
.funArray_label10:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label14
	b .funArray_label14
.funArray_label11:
# %op12 = getelementptr i32, i32* %arg0, i32 0
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -41
# %op13 = load i32, i32* %op12
	ld.d $t0, $fp, -41
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -45
# br label %label14
	b .funArray_label14
.funArray_label14:
# %op16 = icmp sge i32 0, 0
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -46
# br i1 %op16, label %label18, label %label17
	ld.b $t0, $fp, -46
	bnez $t0, .funArray_label18
	b .funArray_label17
.funArray_label17:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label21
	b .funArray_label21
.funArray_label18:
# %op19 = getelementptr i32, i32* %arg1, i32 0
	ld.d $t0, $fp, -32
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -54
# %op20 = load i32, i32* %op19
	ld.d $t0, $fp, -54
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -58
# br label %label21
	b .funArray_label21
.funArray_label21:
# %op25 = icmp slt i32 %op13, %op20
	ld.w $t0, $fp, -45
	ld.w $t1, $fp, -58
	slt $t0, $t0, $t1
	st.b $t0, $fp, -59
# %op26 = zext i1 %op25 to i32
	ld.b $t0, $fp, -59
	bstrpick.w $t0, $t0, 7, 0
	st.w $t0, $fp, -63
# %op27 = icmp sgt i32 %op26, 0
	ld.w $t0, $fp, -63
	addi.w $t1, $zero, 0
	slt $t0, $t1, $t0
	st.b $t0, $fp, -64
# br i1 %op27, label %label28, label %label35
	ld.w $a0, $fp, -58
	st.w $a0, $fp, -68
	ld.w $a0, $fp, -45
	st.w $a0, $fp, -72
	ld.b $t0, $fp, -64
	bnez $t0, .funArray_label28
	b .funArray_label35
.funArray_label28:
# br label %label35
	ld.w $a0, $fp, -45
	st.w $a0, $fp, -68
	ld.w $a0, $fp, -58
	st.w $a0, $fp, -72
	b .funArray_label35
.funArray_label35:
# %op39 = phi i32 [ %op20, %label21 ], [ %op13, %label28 ]
# %op40 = phi i32 [ %op13, %label21 ], [ %op20, %label28 ]
# %op38 = call i32 @gcd(i32 %op40, i32 %op39)
	ld.w $a0, $fp, -72
	ld.w $a1, $fp, -68
	bl gcd
	st.w $a0, $fp, -76
# ret i32 %op38
	ld.w $a0, $fp, -76
	b funArray_exit
funArray_exit:
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -64
.main_label_entry:
# %op0 = icmp sge i32 0, 0
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -17
# br i1 %op0, label %label2, label %label1
	ld.b $t0, $fp, -17
	bnez $t0, .main_label2
	b .main_label1
.main_label1:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label5
	b .main_label5
.main_label2:
# %op3 = getelementptr [1 x i32], [1 x i32]* @x, i32 0, i32 0
	la.local $t0, x
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -25
# br label %label5
	b .main_label5
.main_label5:
# store i32 90, i32* %op3
	ld.d $t0, $fp, -25
	addi.w $t1, $zero, 90
	st.w $t1, $t0, 0
# %op6 = icmp sge i32 0, 0
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 0
	slt $t0, $t0, $t1
	addi.d $t1, $zero, 1
	xor $t0, $t0, $t1
	st.b $t0, $fp, -26
# br i1 %op6, label %label8, label %label7
	ld.b $t0, $fp, -26
	bnez $t0, .main_label8
	b .main_label7
.main_label7:
# call void @neg_idx_except()
	bl neg_idx_except
# br label %label11
	b .main_label11
.main_label8:
# %op9 = getelementptr [1 x i32], [1 x i32]* @y, i32 0, i32 0
	la.local $t0, y
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -34
# br label %label11
	b .main_label11
.main_label11:
# store i32 18, i32* %op9
	ld.d $t0, $fp, -34
	addi.w $t1, $zero, 18
	st.w $t1, $t0, 0
# %op12 = getelementptr [1 x i32], [1 x i32]* @x, i32 0, i32 0
	la.local $t0, x
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -42
# %op13 = getelementptr [1 x i32], [1 x i32]* @y, i32 0, i32 0
	la.local $t0, y
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t2, $t1, $t0
	st.d $t2, $fp, -50
# %op14 = call i32 @funArray(i32* %op12, i32* %op13)
	ld.d $a0, $fp, -42
	ld.d $a1, $fp, -50
	bl funArray
	st.w $a0, $fp, -54
# ret i32 %op14
	ld.w $a0, $fp, -54
	b main_exit
main_exit:
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
