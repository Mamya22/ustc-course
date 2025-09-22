; ModuleID = 'cminus'
source_filename = "/home/mamya/CompileLab/2024ustc-jianmu-compiler/tests/4-opt/testcases/functional-cases/4-if.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define i32 @main() {
label_entry:
  %op8 = icmp sgt i32 11, 22
  %op9 = zext i1 %op8 to i32
  %op10 = icmp sgt i32 %op9, 0
  br i1 %op10, label %label11, label %label18
label11:                                                ; preds = %label_entry
  %op14 = icmp sgt i32 11, 33
  %op15 = zext i1 %op14 to i32
  %op16 = icmp sgt i32 %op15, 0
  br i1 %op16, label %label24, label %label27
label17:                                                ; preds = %label26, %label31
  ret i32 0
label18:                                                ; preds = %label_entry
  %op21 = icmp slt i32 33, 22
  %op22 = zext i1 %op21 to i32
  %op23 = icmp sgt i32 %op22, 0
  br i1 %op23, label %label29, label %label32
label24:                                                ; preds = %label11
  call void @output(i32 11)
  br label %label26
label26:                                                ; preds = %label24, %label27
  br label %label17
label27:                                                ; preds = %label11
  call void @output(i32 33)
  br label %label26
label29:                                                ; preds = %label18
  call void @output(i32 22)
  br label %label31
label31:                                                ; preds = %label29, %label32
  br label %label17
label32:                                                ; preds = %label18
  call void @output(i32 33)
  br label %label31
}
