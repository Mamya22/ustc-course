#include<iostream>
#include<vector>
// bool graph[501][501]
bool dfs(std::vector<bool> &visited, std::vector<std::vector<int>> graph, std::vector<int> &path, int M, int left){
    for(int i : graph[left]){
        if(!visited[i]){
            visited[i] = 1; // 说明这个点选取过了
            if(path[i] == 0 || dfs(visited, graph, path, M, path[i])){
                // 找到可匹配路径
                path[i] = left;
                return true;
            } 
        }
    }
    //每找到可增广路径
    return false;
}
int main(){
    int N, M, E;
    std::cin >> N >> M >> E;
    std::vector<std::vector<int>> graph(N+1);
    std::vector<int> path(M+1, 0);
    int begin, end;
    // 初始化图
    for(int i = 0; i < E; i++){
        std::cin >> begin >> end;
        graph[begin].push_back(end);
        // graph[end][begin] = true;
    }
    // 匈牙利算法
    int sum = 0;
    for(int i = 1; i <= N; i++){ // 遍历每个左侧点
        if(graph[i].empty())
            continue;
        std::vector<bool> visited(M+1, false);
        bool res = dfs(visited, graph, path, M, i);
        if(res){
            sum++;
        }
        // 从每个左侧结点出发，找到是否有增广路径
        // 深度优先遍历
    }
    printf("%d", sum);
    return 0;
}