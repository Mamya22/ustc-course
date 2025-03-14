#include <iostream>
#include <vector>
struct node
{
    int nodeNum;
    int weight;
};

int main(){
    int N, M;
    // N代表结点个数，M代表边的个数。
    std::cin >> N >> M;
    std::vector<std::vector<node>>  tree(N+1);
    int begin, end, weight;
    // 创建树
    for (int i = 0; i < M; i++){
        std::cin >> begin >> end >> weight;
        struct node n1,n2;
        n1.nodeNum = end;
        n2.nodeNum = begin;
        n2.weight =  weight;
        n1.weight =  weight;
        tree[begin].push_back(n1);
        tree[end].push_back(n2);
    }
    std::vector<bool> visited(N+1, false);
    std::vector<int> set;
    visited[1] = true;
    set.push_back(1);
    // 每次找最小的边
    int min = 10001;
    int nodeNum = 1;
    int sum = 0;
    for(int j = 0; j < N-1; j++){
        for(int i : set){
            std::vector<node> edge_set = tree[i];
            for(node n : edge_set){
                if(!visited[n.nodeNum] && n.weight < min){
                //找最小的边
                    min = n.weight; 
                    nodeNum = n.nodeNum;               
                }
            }
        }    
        if(visited[nodeNum]){
            sum = -1;
            break;
        }
        else{
            visited[nodeNum] = true;
            sum += min;
            min = 10001;
            set.push_back(nodeNum);
        }
    }
    std::cout << sum;
    return 0;
}