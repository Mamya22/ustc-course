#include <iostream>

int main(){
    // N 代表书架层数，M代表每层书本的数量， K代表能借阅的最大数目
    int N, M, K;
    std::cin >> N >> M >> K;
    int knowledge[N][M];
    // 输入知识数
    for(int i = 0; i < N; i++){
        int sum = 0;
        for(int j = 0; j < M; j++){
            std::cin >> knowledge[i][j];
            knowledge[i][j] += sum;
            sum = knowledge[i][j]; 
        }
    }
    // 动态规划， 若第一行选i个，则剩余的行选K-i个使得数据最大
    int select[K+1] = {0};

    for(int i = 0; i < N; i++){
        // int temp = std::min(K, (i+1) * M);
        for(int m = K; m > 0; m--){
            for(int j = 0; j < M && j < m; j++){
                // 选取第i行的前j本书
                select[m] = std::max(select[m], select[m-j-1] + knowledge[i][j]);
            }
        }
    }
    std::cout << select[K];
}