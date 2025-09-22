	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.main_label_entry:
# %op8 = fmul float 0x3ff19999a0000000, 0x3ff8000000000000
	lu12i.w $t8, 260300
	ori $t8, $t8, 3277
	movgr2fr.w $ft1, $t8
	lu12i.w $t8, 261120
	ori $t8, $t8, 0
	movgr2fr.w $ft2, $t8
	fmul.s $ft0, $ft1, $ft2
	fst.s $ft0, $fp, -20
# %op10 = fadd float %op8, 0x3ff3333340000000
	fld.s $ft1, $fp, -20
	lu12i.w $t8, 260505
	ori $t8, $t8, 2458
	movgr2fr.w $ft2, $t8
	fadd.s $ft0, $ft1, $ft2
	fst.s $ft0, $fp, -24
# call void @outputFloat(float %op10)
	fld.s $fa0, $fp, -24
	bl outputFloat
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
