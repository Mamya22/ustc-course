#include<stdio.h>
int main(){
    int n;
    scanf("%d", &n);
    // long number = 0;

    long number[46] = {0};
    number[0] = 1;
    number[1] = 1;
    // number = combine(n);
    for(int i = 2; i <= n; i++){
        number[i] = number[i - 1] + number[i - 2];
    }
    printf("%ld\n", number[n]);
}