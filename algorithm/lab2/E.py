class MagicHeap:
    def __init__(self, n, a):
        # self.parent = list(range(n))
        # self.rank = [1] * n
        self.val = [0] + a[:] + a[:]
        self.pre = [0]*(2*n+1)
        self.index = 2*n + 1
        for i in range(1, n+1):
            index = i+n
            self.pre[i] = index
            self.pre[index] = index
        
    def find(self, x):
        while(self.pre[x] != x):
            x = self.pre[x]
        return x
    
    def union(self, x, y):
        x_p = self.find(x)
        y_p = self.find(y)
        if x_p < y_p:
            self.pre[y_p] = x_p
            self.val[x_p] = self.val[x_p] * self.val[y_p] # 更新当前结点的乘积
        elif x_p > y_p:
            self.pre[x_p] = y_p
            self.val[y_p] = self.val[x_p] * self.val[y_p]

# 之前1操作的堆，跟x堆有关的，           
    def move(self, x, y):
        x_p = self.find(x)
        y_p = self.find(y)
        if x_p != y_p: # 说明不在同一堆里
            if x_p != x: # 说明没被用来当作根节点
                self.pre[x] = self.index
                self.pre.append(self.index)
                self.val.append(self.val[x])
                self.val[x_p] = self.val[x_p] // self.val[x]
                self.union(self.index, y_p)
                self.index += 1
            
    def check(self, x):
        x_p = self.find(x)
        return self.val[x_p]
    

n, m = map(int, input().split())
val = list(map(int, input().split()))
magicHeap = MagicHeap(n, val)

for i in range(m):
    op_line = list(map(int, input().split()))
    if op_line[0] == 1:
        magicHeap.union(op_line[1], op_line[2])
    elif op_line[0] == 2:
        res = magicHeap.check(op_line[1])
        print(res%(10**9 + 7))
    elif op_line[0] == 3:
        magicHeap.move(op_line[1], op_line[2])