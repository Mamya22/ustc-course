"""
public functions
"""

# !/usr/bin/env python
# coding=utf-8
def sort_str(element):
    """
    Compare numbers in string format correctly for sorting.
    """
    return int(element)

# def cmp_str(element1, element2):
#     """
#     compare number in str format correctley
#     """
#     try:
#         return cmp(int(element1), int(element2))
#     except ValueError:
#         return cmp(element1, element2)
# def cmp_str(element1, element2):
#     """
#     Compare numbers in string format correctly.
#     """
#     def compare(x, y):
#         try:
#             return (int(x) > int(y)) - (int(x) < int(y))
#         except ValueError:
#             return (x > y) - (x < y)

#     return compare(element1, element2)

# def list_to_str(value_list, cmpfun=cmp, sep=';'):
#     """covert sorted str list (sorted by cmpfun) to str
#     value (splited by sep). This fuction is value safe, which means
#     value_list will not be changed.
#     return str list.
#     """
#     temp = value_list[:]
#     temp.sort(cmp=cmpfun)
#     return sep.join(temp)
