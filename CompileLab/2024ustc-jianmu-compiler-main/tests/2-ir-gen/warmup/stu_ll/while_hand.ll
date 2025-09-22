; ModuleID = 'while.c'
define dso_local i32 @main() #0 {
    %1 = alloca i32
    %2 = alloca i32
    store i32 10, i32* %1
    store i32 0, i32* %2
    br label %3
3:
    %4 = load i32, i32* %2
    %5 = icmp slt i32 %4, 10
    br i1 %5, label %6  , label %10
6:
    %7 = add i32 %4, 1
    store i32 %7, i32* %2
    %8 = load i32, i32* %1
    %9 = add i32 %7, %8
    store i32 %9, i32* %1
    br label %3
10:
    %11 = load i32, i32* %1
    ret i32 %11
}