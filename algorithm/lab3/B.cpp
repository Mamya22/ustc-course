#include<iostream>
#include<string>
#include<vector>
using namespace std;
// void get_next(int next[],std::string s,  int length){
//     int k, j = 2;
//     next[0] = -1, next[1] = 0; // 第一个位置不匹配就到第0个位置
//     while (j < length){
//         k = next[j - 1]; // 找到与j前字符匹配的最大字符串
//         // 如果s[k]=s[j-1]，说明在j前的最大重叠串，就是在j-1前的最大重叠串加一，
//         // 如果不相等，继续向前寻找，直到找到相等的，或者k=0；说明没找到
//         while (k > 0 && s[k] != s[j - 1])
//             k = next[k];
//         if (k <= 0){                         // k<=0,说明没有找到数目大于1的重叠串
//             if (s[0] == s[j - 1]) // 说明第0个和第j-1个字符相同，只需要从第1位开始寻找
//                 next[j] = 1;
//             else // 如果不相等，说明没有满足要求的，要从第0位开始遍历
//                 next[j] = 0;
//         }
//         else // 其他情况next[j]=k+1
//             next[j] = k + 1;
//         j++;
//     }
// }
// // 求nextVal的值
// void get_nextVal(int next[], std::string s, int length){
//     get_next(next, s, length);
//     for (int i = 1; i < length; i++){
//         while (next[i] >= 0 && s[next[i]] == s[i]){
//             next[i] = next[next[i]];//如果相同的话，向前挪一个。
//         }
//     }
// }

// int main(){
//     int N, M;
//     std::cin >> N >> M;
//     std::string T;
//     int next[N][51];
//     int len[N];
//     int ans = 0;
//     std::vector<std::string> str;
//     for(int i = 0; i<N;i++){
//         std::string S;
//         int num;
//         std::cin>>num >> S;
//         // int next_temp[num];
//         len[i] = num;
//         get_nextVal(next[i],S,num);
//         str.push_back(S);
//     } 
//     std::cin >> T;
//     for(int i = 0; i < N; i++){
//         int k = 0;
//         for(int j = 0; j < M; j++){
//             while(k && T[j] != str[i][k]){
//                 k = next[i][k];
//             }
//             if(T[j] == str[i][k]){
//                 k++;
//             }
//             if(k == len[i]){
//                 ans += 1;
//             }
//         }
//     }
//     std::cout << ans;


//     // int len = T.length();
//     // int next[M];
//     // for(int i = 0; i < M; i++){
//     //     next[i] = 0;
//     // }
//     // // get_nextVal(next, T, M);
//     // for(int i = 0; i < M; i++){
//     //     std::cout << next[i] << " ";
//     // }

    


// }

class Solution {
public:
    int multiSearch(string big, vector<string>& smalls, vector<int> len, int N, int M) {
        int ans = 0;
        for(int k = 0; k < N; k++){
            // ans.push_back({});
            string P = smalls[k];
            //计算失配函数
            vector<int> f(P.size()+1);
            getFail(P,f);

            //在big中查找字符串P的所有出现位置
            int j = 0;
            for(int i=0;i<M;++i){
                while(j && P[j] != big[i]){
                    j = f[j];
                }
                if(P[j] == big[i]){
                    j++;
                }
                if(j == len[k] ){//找到了P
                    ans += 1;
                }
            }
            
        }
        return ans;
    }

    void getFail(const string& P,vector<int>& f){
        f[0] = 0;
        f[1] = 0;
        for(int j=1;j<P.size();++j){
            int k = f[j];
            while(k && P[k] != P[j]){
                k = f[k];
            }

            if(P[k] == P[j]){
                f[j+1] = k + 1;
            }else{
                f[j+1] = 0;
            }
        }
    }
};

int main(){
    int N, M;
    cin >> N >> M;
    vector<string> str;
    vector<int> len;
    for(int i = 0; i < N; i++){
        int num;
        string s;
        cin >> num >> s;
        len.push_back(num);
        str.push_back(s);
    }
    string t;
    cin >> t;
    Solution so =  Solution();
    int  res = so.multiSearch(t,str,len,N, M);
    cout << res;


}
