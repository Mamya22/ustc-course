
# 使用构建Tire树和AC自动机
class Trie:
    def __init__(self, words):
        self.d = {}
        for word in words:
            tree = self.d
            for w in word:
                if w not in tree:
                    tree[w] = {}
                tree = tree[w]
            tree['end'] = word
    
    def search(self, s):
        tree = self.d
        res = []
        for w in s:
            if w not in tree:
                break
            tree = tree[w]
            if 'end' in tree:
                res.append(tree['end'])
        return res

class Solution:
    def stringSearch(self, big: str, strings, M, res_dict):
        tree =  Trie(strings)
        for i in range(M):
            mstr = tree.search(big[i:])
            for word in mstr:
                res_dict[word] += 1
    
[N, M] = list(map(int, input().split()))
ss = []
str_dict = dict()
res_dict = dict()
for i in range(N):
    num, s = input().split()
    ss.append(s)
    str_dict[s] = 0
    res_dict[s] = 0
for s in ss:
    str_dict[s] += 1
t = input()
solution = Solution()
solution.stringSearch(t, list(str_dict.keys()), M, res_dict)
res = 0
for s, i in res_dict.items():
    res += i*str_dict[s]
print(res)