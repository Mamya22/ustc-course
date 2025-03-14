#include<iostream>
#include<vector>
int main(){
    int N, M;
    std::cin >> N >> M;
    // int edge[N+1]
    std::vector<int> edge(N+1, 0);
    std::vector<int> count(N+1, 0);
    std::vector<std::vector<int>> graph(N+1);
    bool visited[N+1] = {false};
    int first, second;
    for(int i = 0; i < M; i++){
        std::cin >> first >> second;
        graph[first].push_back(second);
        visited[second] = true;
        edge[second]++;
    }
    int begin = 1;
    while(visited[begin]){
        begin++;
    }
    std::vector<int> queue;
    queue.push_back(begin);
    count[begin] = 1;
    int sum = 0;
    while(!queue.empty()){
        int temp = queue.back();
        queue.pop_back();
        for(int i : graph[temp]){
            count[i] = (count[i] + count[temp]);
            edge[i]--;
            if(edge[i] == 0){
                queue.push_back(i);
            }
        }
        if(graph[temp].empty()){
            sum = (sum + count[temp])%1000000007;
        }
    }
    printf("%d", sum);
    return 0;

}