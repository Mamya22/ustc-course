#include <stdio.h>
#include <string.h>
int main(){
    int N;
    scanf("%d", &N);
    int c[N];
    for(int i = 0; i < N; i++){
        scanf("%d", &c[i]);
    }
    int sum[N+1];
    int score[N+1][N+1];
    sum[0] = 0;
    for(int i = 1; i <= N; i++){ // 计算前n堆的和，方便后续运算
        sum[i] = sum[i-1] + c[i-1];
    }
    memset(score,9999,sizeof(score));
    // 初始化 score[][] 代表从某一堆加到另一堆上的得分
    for(int i = 1; i <= N; i++){
        score[i][i] = 0;
    }
    for(int i = 2; i < N+1; i++){// 加起来的堆的数目
        for(int j = 1; j < N-i+2; j++){ //从第一堆开始，计算每i堆的最小值
            int right = i + j - 1;
            for(int k = j; k < right; k++){
                // if(score[])
                int split_k_sum = score[j][k] + score[k+1][right] + sum[right] - sum[j-1];
                score[j][right] = split_k_sum < score[j][right] ? split_k_sum :score[j][right]; 
            }
        }
    }
    printf("%d", score[1][N]);
}