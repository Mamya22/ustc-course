; ModuleID = 'assign.c'
source_filename = "assign.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

define dso_local i32 @main() #0 {
    %1 = alloca i32
    %2 = alloca [10 x i32]
    store i32 0, i32* %1
    %3 = getelementptr [10 x i32], [10 x i32]* %2, i32 0, i32 0
    store i32 10, i32* %3
    %4 = getelementptr [10 x i32], [10 x i32]* %2, i32 0, i32 0
    %5 = load i32, i32* %4
    %6 = mul i32 %5, 2
    %7 = getelementptr [10 x i32], [10 x i32]* %2, i32 0, i32 1
    store i32 %6, i32* %7
    %8 = getelementptr [10 x i32], [10 x i32]* %2, i32 0, i32 1
    %9 = load i32, i32* %8
    ret i32 %9
}