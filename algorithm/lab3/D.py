[N, C] = list(map(int, input().split()))
magic = []
for _ in range(N):
    magic.append(list(map(int, input().split())))

val = [0]*(C+1)
for i in range(N):
    c0 = magic[i][0]
    for v in  range(C, c0-1, -1):
        val[v] = max(val[v], val[v-c0]+ magic[i][1])

print(val[C])
