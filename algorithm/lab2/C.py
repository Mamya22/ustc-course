def find(x, parent):
    if(parent[x] != x):
        return find(parent[x], parent)
    return parent[x]
    
def union(x, y, rank, parent):
    x_p = find(x, parent)
    y_p = find(y, parent)
    if(x_p != y_p):
        if rank[x_p] > rank[y_p]:
            parent[y_p] = x_p
        elif rank[x_p] < rank[y_p]:
            parent[x_p] = y_p
        else:
            parent[y_p] = x_p
            rank[x_p] += 1

n = int(input())
val = list(map(int, input().split()))

# 计算是否为素数
is_prime = [True] * (n+1)
is_prime[0] = is_prime[1] = False
for i in range(2, int(n**0.5) + 1):
    if(is_prime[i]):
        for j in range(i*i, n+1, i):
            is_prime[j] = False


flag = [False]*(n+1)
parent = [i for i in range(n+1)]
rank = [0] * (n+1)

for i in range(n-1):
    [p, c] = list(map(int, input().split()))
    if is_prime[p] and is_prime[c]:
        union(p, c, rank, parent)

# 计算值
sum_happiness = [0] * (n+1)
for i in range(1, n+1):
    index = find(i, parent)
    sum_happiness[index] += val[i-1]

max_happiness = 0
for i in range(1, n+1):
    if sum_happiness[i] > 0:
        max_happiness += sum_happiness[i]

print(max_happiness)
