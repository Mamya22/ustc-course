#include <iostream>
int main(){
    int N, M;
    // N是S的长度，M是T的长度
    std::cin >> N >> M;
    std::string S,T;
    std::cin >> S;
    std::cin >> T;

    // 计算next数组
    int next[M+1];
    next[0] = -1;
    int k=-1;
    for(int i = 1; i < M; i++){
        while (k > -1 && T[k+1] != T[i]){
            k = next[k];  // 向前回溯，
        }
        if(T[k+1] == T[i])
            k++;
        next[i] = k;
    }
    k = -1; 
    int place[N];
    int count = 0;
    int i = 0;
    while(i < N){
        while (k > -1 && T[k+1] != S[i]){
            k = next[k];
        }
        if(T[k+1] == S[i]){
            k++;
        }
        if(k == M - 1){
            place[count] = i - M + 1;
            count++;
            k = next[M-1];
            // 改变主串指针，
            // i = i - next[M-1]; 
        }
        i++;
    }
    for(int m = 0; m < count; m++){
        std::cout << place[m] << " ";
    }
}