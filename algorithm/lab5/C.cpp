#include <iostream>
#include<vector>
int main(){
    int N;
    std::string S;
    std::cin >> N;
    std::cin >> S;
    std::vector<char> t;
    for(int i = 0; i < N; i++){
        t.push_back('0');
        t.push_back(S[i]);
    }
    t.push_back('0');
    N = 2 * N + 1;
    std::vector<int> right(N);
    for(int i=0, j=0; i < N; i++){
        if(i < j + right[j]){
            right[i] = std::min(j + right[j] - i, right[2*j-i]); // 对称位置
        }
            
        while(i - right[i] >= 0 && i + right[i] < N && t[i - right[i]] == t[i + right[i]]){
            right[i]++;
        }
            
        if(i+right[i] > j + right[j]){
            j = i;
        }
    }
    int longest = 0;
    for(int i = 0; i < N; i++){
        if(right[i] > longest){
            longest = right[i];
        }
    }
    std::cout << longest - 1;

}
