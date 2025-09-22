; ModuleID = 'if.c'
define dso_local i32 @main() #0 {
    %1 = alloca i32
    %2 = alloca float 
    store float 0x40163851E0000000, float* %2
    %3 = load float, float* %2
    %4 = sitofp i32 1 to float
    %5 = fcmp ugt float %3, %4
    br i1 %5, label %6, label %7
6:
    store i32 233, i32* %1
    br label %8
7: 
    store i32 0, i32* %1
    br label %8
8:
    %9 = load i32, i32* %1
    ret i32 %9
}