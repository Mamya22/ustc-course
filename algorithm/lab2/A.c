#include <stdio.h>
#include <string.h>
#include <malloc.h>
int main(){
    int SLen = 0;
    int TLen = 0;
    scanf("%d", &SLen);
    // char S[SLen];
    char *S = (char *)malloc(sizeof(char)*SLen);
    scanf("%s", S);
    scanf("%d", &TLen);
    // char T[TLen];
    char *T = (char *)malloc(sizeof(char)*TLen);
    scanf("%s", T);
    int c[SLen+1][TLen+1];
    memset(c,0,sizeof(c));
    for(int i = 1; i <= SLen; i++){
        char midS = S[i-1];
        for(int j = 1; j <= TLen; j++){
            char midT = T[j-1];
            if(midS == midT)
                c[i][j] = c[i-1][j-1] + 1;
            else if(c[i-1][j] >= c[i][j-1]){
                c[i][j] = c[i-1][j];
            }
            else
                c[i][j] = c[i][j-1];
        }
    }
    printf("%d", c[SLen][TLen]);
}