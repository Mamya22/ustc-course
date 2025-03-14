[N, C] = list(map(int, input().split()))
val = [0]*(C+1)
for _ in range(N):
    [num, occupy, benefit] = list(map(int, input().split()))
    k = 1
    while k <= num:
        weight = k * occupy
        value = k * benefit
        v = C 
        while v >= weight:
            val[v] = max(val[v], val[v - weight] +value)
            v -= 1
        num = num - k
        k = 2*k

    if num > 0:
        weight = num*occupy
        value = num * benefit
        v = C
        while v >= weight:
            val[v] = max(val[v], val[v - weight] +value)
            v -= 1
    
        
print(val[C])