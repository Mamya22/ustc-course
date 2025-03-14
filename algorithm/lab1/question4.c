#include<stdio.h>
// #include<vector>
int partition(int a[], int start, int end){
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
// int random_partition(int a[], int start, int end){
//     int i = rand()%(end - start + 1) + start;
//     int temp = a[i];
//     a[i] = a[end];
//     a[end] = temp;
//     return partition(a, start, end);
// }

int random_select(int a[],int start,int end,int medium){
    if(start == end)
        return a[start];
    int index = partition(a, start, end);
    if(medium == index - start)
        return a[index];
    else if(medium < index - start)
        return random_select(a, start, index - 1, medium);
    else
        return random_select(a, index + 1, end, medium - (index - start + 1));
}
int main(){
    int n = 0;
    scanf("%d", &n);
    int a[1000000] = {0};
    int i = 0;
    int sum = 0,  max_num = 0;
    while(i < n){
        scanf("%d", &a[i]);
        if(a[i] > max_num){
            max_num = a[i];
        }
        sum += a[i];
        i++;
    }
    int medium = random_select(a, 0, n-1, n/2);
    int x = 2 * medium * n - sum + 1;
    if(x < 0)
        x = 0;
    if(n <= 2)
        x = -1;
    printf("%d",x);
}

