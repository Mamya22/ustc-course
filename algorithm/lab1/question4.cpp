#include<iostream>
#include<vector>
int partition(std::vector<int> &a, int start, int end){
    int x = a[end];
    int i = start - 1;
    for(int j = start; j < end; j++){
        if(a[j] <= x){
            i++;
            int temp = a[i];
            a[i] = a[j];
            a[j] = temp;
        }
    }
    int temp = a[i+1];
    a[i+1] = a[end];
    a[end] = temp;
    return i + 1;
}
int random_partition(std::vector<int> &a, int start, int end){
    int i = rand()%(end - start + 1) + start;
    int temp = a[i];
    a[i] = a[end];
    a[end] = temp;
    return partition(a, start, end);
}

int random_select(std::vector<int> &a,int start,int end,int medium){
    if(start == end)
        return a[start];
    int index = random_partition(a, start, end);
    if(medium == index - start)
        return a[index];
    else if(medium < index - start)
        return random_select(a, start, index - 1, medium);
    else
        return random_select(a, index + 1, end, medium - (index - start + 1));
}
int main(){
    int n = 0;
    std::cin >> n;
    std::vector<int> a;
    int i = 0;
    int sum = 0, num, max_num = 0;
    while(i < n){
        std::cin >> num;
        if(num > max_num){
            max_num = num;
        }
        sum += num;
        a.push_back(num);
        i++;
    }
    int medium = random_select(a, 0, n-1, n/2);
    int x = 2 * medium * n - sum + 1;
    if(x < 0)
        x = 0;
    if(n <= 2)
        x = -1;
    std::cout << x;
}

