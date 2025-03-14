#include<stdio.h>
#define LENGTH 100000
int main(){
    int n;
    int b[LENGTH];
    scanf("%d", &n);
    for(int i=0; i<n; i++){
        scanf("%d", &b[i]);
    }
    long sum_beauty = 0;
    long max_beauty = 0;
    int right = 0;
    int new_left = 0;
    int left = 0;
    for(int i=0; i<n; i++){
        sum_beauty+=b[i];
        if(sum_beauty>max_beauty){
            max_beauty = sum_beauty;
            left = new_left;
            right = i;
        }
        if (sum_beauty < 0){
            sum_beauty = 0;
            new_left = i;
        }
    }
    printf("%ld", max_beauty);
    return 0;
}

