def tree_magic(tree, magic, parent):
    if len(tree[parent]) != 0:
        for i in tree[parent]:
            magic[parent] += tree_magic(tree, magic, i)
        tree[parent].clear()
    return magic[parent]


# 输入n
n = int(input())
a = list(map(int, input().strip().split()))
i = 0
tree = [[] for i in range(n)]
# print(type(tree))
while i < (n-1):
    temp = list(map(int, input().split()))
    parent, child = temp[0]-1, temp[1]-1
    tree[parent].append(child)
    i += 1
for i in range(n):
    a[i] = tree_magic(tree, a, i)
print(max(a))
