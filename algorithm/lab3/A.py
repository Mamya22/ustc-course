val = []
[n, m, x] = list(map(int, input().split()))
for _ in range(n):
    val.append(list(map(int, input().split())))

s = [0] * m
row_sum = [[] for i in range(n+1)]
for j in range(m+1):
    row_sum[0].append(0)
for i in range(n):
    row_sum[i+1].append(0)
    for j in range(m):
        s[j] = s[j] + val[i][j]
        row_sum[i+1].append(s[j])

max_sum = -999999
for i in range(x, n+1):
    square_sum = 0
    for j in range(x):
        s[j] = row_sum[i][j+1] - row_sum[i-x][j+1]
        square_sum += s[j]
    if max_sum < square_sum:
        max_sum = square_sum
    for j in range(x+1, m+1):
        s[j-1] = row_sum[i][j] - row_sum[i-x][j]
        square_sum = square_sum - s[j-1-x] + s[j-1]
        if square_sum > max_sum:
            max_sum = square_sum

print(max_sum)
