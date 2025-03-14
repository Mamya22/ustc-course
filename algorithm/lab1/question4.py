import random


def partition(a, start, end):
    x = a[end]
    i = start - 1
    for j in range(start, end):
        if a[j] <= x:
            i += 1
            a[i], a[j] = a[j], a[i]
    a[i+1], a[end] = a[end], a[i+1]
    return i+1


# def random_partition(a, start, end):
#     i = random.randint(start, end)
#     a[end], a[i] = a[i], a[end]
#     return partition(a, start, end)


def random_select(a, start, end, medium):
    if start == end:
        return a[start]
    index = partition(a, start, end)
    if medium == index - start:
        return a[index]
    elif medium < index - start:
        return random_select(a, start, index - 1, medium)
    elif medium > index - start:
        return random_select(a, index + 1, end, medium - (index - start + 1))


# 输入n
n = eval(input())
# 输入数字
a = list(map(int, input().strip().split()))

# 找到中间的数
medium = random_select(a, 0, n-1, n//2)
total = sum(a)
max_num = max(a)
x = 2 * medium * n - total + 1
if x < 0:
    x = 0
if n <= 2:
    x = -1
print(x)
