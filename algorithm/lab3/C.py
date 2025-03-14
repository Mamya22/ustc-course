# 贪心算法
[N, M] = list(map(int, input().split()))
t = []
# input and sort
num = [0] * (N+1)
for i in range(M):
    [t1, t2] = list(map(int, input().split()))
    if num[t1] < t2:
        num[t1] = t2
res = 0
begin = 1
end = 0
# N 是开始时间， num[N]是结束时间
i = 1
while i <= begin and i <= N:
    if end < num[i]:
        end = num[i]
    if i == begin:
        res += 1
        begin = end + 1
    i += 1

if N != end:
    res = -1
print(res)

