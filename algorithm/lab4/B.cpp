#include<iostream>
#include<vector>
#include<queue>
#include <string.h>
int main(){
    int N, M;
    std::cin >> N >> M;
    std::vector<std::vector<int>> tree(N+1);
    int first, second;
    for(int i = 0; i < M; i++){
        std::cin >> first >> second;
        // if(first < second)
        tree[first].push_back(second);
        tree[second].push_back(first);
    }
    int count[N+1] = {0};
    count[1] =1;
    //初始化最小路径长度
    int min[N+1];
    memset(min, 10001, sizeof(min));
    min[1] = 0;
    // dps(count, min,tree, 1, 0);
    std::vector<int> set = tree[1];
    std::queue<int> queue;
    queue.push(1);
    while(!queue.empty()){
        int element  = queue.front();
        queue.pop();
        std::vector<int> set = tree[element];
        for(int node : set){
            if(min[node] > min[element] + 1){
                queue.push(node);
                count[node] = count[element];
                min[node] = min[element] + 1;
            }
            else if(min[node] == min[element] + 1){
                count[node] = (count[node] + count[element])%1000000007;
            }
        }
    }
    for(int i = 2; i<=N; i++){
      printf("%d\n", count[i]);
    }
    return 0;
}