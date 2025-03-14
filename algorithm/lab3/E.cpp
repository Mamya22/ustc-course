#include <iostream>
#include <algorithm>
#include <vector>
int main(){
    int N, C;
    std::cin >> N >> C;
    std::vector<int> val(C+1, 0);
    for(int i = 0; i < N; i++){
        int num, occupy, benefit;
        std::cin >> num >> occupy >> benefit;
        int k = 1;
        while(k <= num){
            int weight = k * occupy;
            int value = k * benefit;
            for (int v = C; v >= weight; v--){
                val[v] = std::max(val[v], val[v - weight] +value);
            }
            num = num - k;
            k = k * 2;
        }
        if(num > 0){
            int weight = num * occupy;
            int value = num * benefit;
            for(int v = C; v >= weight; v--){
                val[v] = std::max(val[v], val[v - weight] +value);
            }
        }
    }
    std::cout << val[C];
}
