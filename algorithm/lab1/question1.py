n = eval(input())
b = input().split()
b = [int(num) for num in b]
max_beauty = sum_beauty = 0
for i in range(n):
    sum_beauty += b[i]
    if sum_beauty > max_beauty:
        max_beauty = sum_beauty
    elif sum_beauty < 0:
        sum_beauty = 0

print(max_beauty)
