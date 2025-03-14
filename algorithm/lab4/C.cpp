#include <iostream>
#include <string>
#include <vector>
#include <queue>

class UnionFind {
public:
    std::vector<int> parent;
    std::vector<int> size;

    UnionFind(int n) : parent(n), size(n, 1) {
        for (int i = 0; i < n; i++) 
            parent[i] = i;
    }

    int find(int x) {
        if (x != parent[x]) 
            parent[x] = find(parent[x]); // 路径压缩
        return parent[x];
    }

    void unite(int x, int y) {
        int rootX = find(x), rootY = find(y);
        if (rootX != rootY) {
            if (size[rootX] < size[rootY]){
                int temp = rootX;
                rootX = rootY;
                rootY = temp;
            }
            parent[rootY] = rootX;
            size[rootX] += size[rootY];
        }
    }

    int getSize(int x) {
        return size[find(x)];
    }
};

int main() {
    int N, M;
    std::cin >> N >> M;

    std::vector<std::string> chess(N);
    for (int i = 0; i < N; ++i) {
        std::cin >> chess[i];
    }

    UnionFind uf(N * N);
    std::vector<std::vector<int>> directions = {{-1, 0},{1, 0},{0, 1}, {0, -1}}; // 用于上下左右遍历

    // 遍历棋盘，合并连通分量
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            for (int d = 0; d < 4; ++d) {
                int ni = i + directions[d][0], nj = j + directions[d][1];
                if (ni >= 0 && ni < N && nj >= 0 && nj < N && chess[i][j] != chess[ni][nj]) {
                    uf.unite(i * N + j, ni * N + nj);
                }
            }
        }
    }

    // 处理查询
    int x, y;
    for (int m = 0; m < M; ++m) {
        std::cin >> x >> y;
        int index = (x - 1) * N + (y - 1); // 将二维索引转化为一维索引
        std::cout << uf.getSize(index) << std::endl;
    }

    return 0;
}
