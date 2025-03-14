#include <stdio.h>
int merge(int gpa[], int start, int mid, int end){
    int i = start;
    int res[end - start + 1];
    int j = mid + 1;
    int k = 0;
    int anger_sum = 0;
    //sort
    while(i < mid + 1 && j < end + 1){
        if(gpa[i] > gpa[j]){
            // j angry
            anger_sum += (mid - i + 1);
            res[k] = gpa[j];
            k++;
            j++;
        }
        else{
            res[k] = gpa[i];
            k++;
            i++;
        }
    }
    while(i < mid + 1){
        res[k] = gpa[i];
        k++;
        i++;
    }
    while(j < end + 1){
        res[k] = gpa[j];
        k++;
        j++;
    }
    for(int m = start; m <= end; m++){
        gpa[m] = res[m-start];
    }
    return anger_sum;
}
int DC(int gpa[], int start, int end){
    int anger_sum = 0;
    if(start < end){
        int mid = (end + start) / 2;
        anger_sum += DC(gpa, start, mid);
        anger_sum += DC(gpa,  mid+1, end);
        anger_sum += merge(gpa, start, mid, end);
    }
    return anger_sum;
}
int main(){
    int n;
    scanf("%d", &n);
    // int gpa[100000] = {0};
    int gpa[n];
    int anger_num = 0;
    int i = 0;
    while(i < n){
        scanf("%d", &gpa[i]);
        i++;
    }
    anger_num = DC(gpa, 0, n - 1);
    printf("%d", anger_num);
}