# n = int(input())
# i = 0
# tree = [[] for i in range(n)]
# # print(type(tree))
# val = [0] * n
# path = [0] * n
# while i < (n-1):
#     temp = list(map(int, input().split()))
#     parent, child = temp[0]-1, temp[1]-1
#     val[child] = temp[2] # 到child的距离
#     tree[parent].append(child)
#     i += 1
# # 维护子树节点个数的性质
# sub_node = [1] * n
# sub_node[0] = n
# for i in range(n-1,0,-1):
#     for j in tree[i]:
#         sub_node[i] += sub_node[j]
# # 计算从1开始计算
# total = 0
# for i in range(n):
#     for child in tree[i]:
#         path[child] = path[i] + val[child]
# total = sum(path)
# path[0] = total
# min_sum = total
# for i in range(n):
#     for child in tree[i]:
#         path[child] = path[i] - sub_node[child] * val[child] + (sub_node[0] - sub_node[child]) * val[child]
# print(path.index(min_sum) + 1)

n = int(input())
i = 0
tree = []
val = [0] * n
path = [0] * n
while i < (n-1):
    temp = list(map(int, input().split()))
    parent, child = temp[0]-1, temp[1]-1
    val[child] = temp[2] # 到child的距离
    tree.append((parent,child))
    i += 1
# # 维护子树节点个数的性质
sub_node = [1] * n
sub_node[0] = n
for i in range(n-2,0,-1):
    sub_node[tree[i][0]] += sub_node[tree[i][1]]
min_sum = 0
for (p, c) in tree:
    path[c] = path[p] + val[c]
    min_sum += path[c]

path[0] = min_sum
index = 0
for (p, c) in tree:
    path[c] = (n - 2*sub_node[c]) * val[c] + path[p]
    if(path[c] < min_sum):
        min_sum = path[c]
        index = c

# for i in range(n):
#     for child in tree[i]:
#         path[child] = path[i] - sub_node[child] * val[child] + (sub_node[0] - sub_node[child]) * val[child]
print(index+1)


