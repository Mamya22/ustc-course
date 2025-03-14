#include<stdio.h>
int calculate_magic(char line[],int a[], int num){
    if(line[num] == 0){
        return a[num];
    }
    
}
int max_magic(char line[], int tree[][2], int a[], int n){
    int magic[n] ;
    for(int i = 0; i < n-1; i++){
        //以该结点为根节点的子树
        int index = tree[i][0] - 1;
        magic[index] = 0;
        magic[index] = magic[index] + calculate_magic(line, a, tree[i][0] - 1);
    }
}
int main(){
    int n;
    scanf("%d", &n);
    int a[n];
    char line[100000] = {0};
    for(int i = 0; i < n; i++){
        scanf("%d", &a[i]);
    }
    int tree[n-1][2];
    for(int i = 0; i < n - 1; i++){
        scanf("%d", &tree[i][0]);
        scanf("%d", &tree[i][1]);
        line[tree[i][0] - 1] = 1; 
    }
}