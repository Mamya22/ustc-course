#include<iostream>
const int mod = 1e9 + 7;

//创造矩阵结构体
struct matrix
{
    //五行五列二维数组(数组开的大一些)
    long long tr[4][4];
};

matrix multiply(matrix x, matrix y){
    matrix answer;
    answer.tr[0][0] = answer.tr[0][1] = answer.tr[1][0] = answer.tr[1][1] = 0;
    for(int i = 0; i < 2; i++){
        for(int j = 0; j < 2; j++){
            for(int k = 0; k < 2; k++){
                answer.tr[i][j] = (answer.tr[i][j] + x.tr[i][k] * y.tr[k][j]) % mod;
            }
        }
    }
    return answer;
}

int main(){
    int N;
    std::cin >> N;
    if(N == 1 || N == 2){
        std::cout << 1;
        return 0;
    }
    matrix answer, factor;
    answer.tr[0][0] = answer.tr[1][0] = 1;
    answer.tr[1][1] = answer.tr[0][1] = 0;
    factor.tr[0][0] = factor.tr[0][1] = factor.tr[1][0] = 1;
    factor.tr[1][1] = 0;
    N = N - 2;
    while(N){
        if(N & 1){
            answer = multiply(factor, answer);
        }
        //
        N >>= 1;

        factor = multiply(factor, factor);
    }
    std::cout << answer.tr[0][0];
}