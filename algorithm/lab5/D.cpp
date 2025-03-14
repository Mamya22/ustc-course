#include <iostream>
#include <vector>
#include <stack>
#include <algorithm>

int main() {
    int N;
    std::cin >> N;  // 输入积木的数量
    std::vector<int> height(N);
    std::stack<int> stack;
    
    for (int i = 0; i < N; ++i) {
        std::cin >> height[i];  // 输入每个积木的高度
    }
    
    int area = 0;
    height.push_back(0);

    for(int i = 0; i < (N + 1); i++){
        // 单调栈
        while(!stack.empty() && height[i] < height[stack.top()]){
            int top_height = height[stack.top()];
            stack.pop();
            int width;
            if(stack.empty()){
                width = i;
            } 
            else{
                width = i - stack.top() - 1;
            }
            area = std::max(area, top_height * width);
        }
        stack.push(i);
    }
    // 输出最大矩形的面积
    std::cout << area;
    
    return 0;
}
