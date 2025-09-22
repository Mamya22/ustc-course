; ModuleID = 'fun.c'
define dso_local i32 @callee(i32 %0) #0 {
    %2 = alloca i32
    store i32 %0, i32* %2
    %3 = load i32, i32* %2
    %4 = mul i32 %3, 2
    ret i32 %4
}
define dso_local i32 @main() #0 {
    ; %1 = alloca i32
    ; store i32 100, i32* %1
    ; %2 = load i32, i32* %1
    %1 = call i32 @callee(i32 110)
    ret i32 %1
}