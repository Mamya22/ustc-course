"""
read adult data set
"""

# !/usr/bin/env python
# coding=utf-8

# Read data and read tree functions for INFORMS data
# attributes ['age', 'work_class', 'final_weight', 'education', 'education_num',
# 'marital_status', 'occupation', 'relationship', 'race', 'sex', 'capital_gain',
# 'capital_loss', 'hours_per_week', 'native_country', 'class']
# QID ['age', 'work_class', 'education', 'marital_status', 'race', 'sex', 'native_country']
# SA ['occupation']
from utils.gentree import GenTree
from utils.numrange import NumRange
from utils.utility import cmp_str
from functools import cmp_to_key

import pickle

import pdb

ATT_NAMES = ['age', 'work_class', 'final_weight', 'education',
            'education_num', 'marital_status', 'occupation', 'relationship',
            'race', 'sex', 'capital_gain', 'capital_loss', 'hours_per_week',
            'native_country', 'class']
QI_INDEX = [0, 1, 4, 5, 6, 8, 9, 13]
IS_CAT = [False, True, False, True, True, True, True, True]
SA_INDEX = -1
__DEBUG = False


def read_data():
    """
    read microdata for *.txt and return read data

    # Note that Mondrian can only handle numeric attribute
    # So, categorical attributes should be transformed to numeric attributes
    # before anonymization. For example, Male and Female should be transformed
    # to 0, 1 during pre-processing. Then, after anonymization, 0 and 1 should
    # be transformed to Male and Female.
    """
    QI_num = len(QI_INDEX)
    data = []
    # oder categorical attributes in intuitive order
    # here, we use the appear number
    intuitive_dict = []
    intuitive_order = []
    intuitive_number = []
    for i in range(QI_num):
        intuitive_dict.append(dict())
        intuitive_number.append(0)
        intuitive_order.append(list())
    data_file = open('C:\\Users\\Lenovo1\\Desktop\\homework\\data_privacy\\K-Anonymity-code\\data\\adult.data', 'r')
    for line in data_file:
        line = line.strip()
        # remove empty and incomplete lines
        # only 30162 records will be kept
        if len(line) == 0 or '?' in line:
            continue
        # remove double spaces
        line = line.replace(' ', '')
        temp = line.split(',')
        ltemp = []
        for i in range(QI_num):
            index = QI_INDEX[i]
            if IS_CAT[i]:
                try:
                    # 把种类转化为数值型
                    ltemp.append(intuitive_dict[i][temp[index]])
                except KeyError:
                    intuitive_dict[i][temp[index]] = intuitive_number[i]
                    ltemp.append(intuitive_number[i])
                    intuitive_number[i] += 1
                    intuitive_order[i].append(temp[index])
            else:
                # 不是种类，是数值型
                ltemp.append(int(temp[index]))
        # ltemp 加入了最后一列
        ltemp.append(temp[SA_INDEX])
        data.append(ltemp)
    return data, intuitive_order


def read_data_2():
    """
    read microda for *.txt and return read data
    """
    QI_num = len(QI_INDEX)
    data = []
    numeric_dict = []
    for i in range(QI_num):
        numeric_dict.append(dict())
    # oder categorical attributes in intuitive order
    # here, we use the appear number
    data_file = open('C:\\Users\\Lenovo1\\Desktop\\homework\\data_privacy\\K-Anonymity-code\\data\\adult.data', 'r')
    for line in data_file:
        line = line.strip()
        # remove empty and incomplete lines
        # only 30162 records will be kept
        if len(line) == 0 or '?' in line:
            continue
        # remove double spaces
        line = line.replace(' ', '')
        temp = line.split(',')
        ltemp = []
        for i in range(QI_num):
            index = QI_INDEX[i] # QI_INDEX
            if IS_CAT[i] is False:
                try:
                    numeric_dict[i][temp[index]] += 1
                except KeyError:
                    numeric_dict[i][temp[index]] = 1
            ltemp.append(temp[index])
        ltemp.append(temp[SA_INDEX])
        data.append(ltemp)
    # pickle numeric attributes and get NumRange
    for i in range(QI_num):
        if IS_CAT[i] is False:
            static_file = open('C:\\Users\\Lenovo1\\Desktop\\homework\\data_privacy\\K-Anonymity-code\\data\\adult_' + ATT_NAMES[QI_INDEX[i]] + '_static.pickle', 'wb')
            sort_value = list(numeric_dict[i].keys())
            sort_value.sort(key = cmp_to_key(cmp_str))
            pickle.dump((numeric_dict[i], sort_value), static_file) # 存入数字值对应的值和次数，前者无序，后者有序
            static_file.close()
    return data   # data是对属性进行筛选后的数据


def read_tree():
    """read tree from data/tree_*.txt, store them in att_tree
    """
    att_names = []
    att_trees = []
    # 添加属性名称
    for t in QI_INDEX:
        att_names.append(ATT_NAMES[t])
    for i in range(len(att_names)):
        if IS_CAT[i]:
            att_trees.append(read_tree_file(att_names[i])) # 构建了层次树
        else:
            att_trees.append(read_pickle_file(att_names[i]))
    return att_trees


def read_pickle_file(att_name):
    """
    read pickle file for numeric attributes
    return numrange object
    """
    try:
        static_file = open('C:\\Users\\Lenovo1\\Desktop\\homework\\data_privacy\\K-Anonymity-code\\data\\adult_' + att_name + '_static.pickle', 'rb')
        (numeric_dict, sort_value) = pickle.load(static_file)
    except:
        print ("Pickle file not exists!!")
    static_file.close()
    result = NumRange(sort_value, numeric_dict) # result包含了该属性的key的范围，和按序的key的位置
    return result


def read_tree_file(treename):
    """read tree data from treename
    """
    leaf_to_path = {}
    att_tree = {}
    prefix = 'C:\\Users\\Lenovo1\\Desktop\\homework\\data_privacy\\K-Anonymity-code\\data\\adult_'
    postfix = ".txt"
    treefile = open(prefix + treename + postfix, 'r')
    att_tree['*'] = GenTree('*')
    if __DEBUG:
        print ("Reading Tree" + treename)
    for line in treefile:
        # delete \n
        if len(line) <= 1:
            break
        line = line.strip()
        temp = line.split(';')
        # copy temp
        temp.reverse()
        for i, t in enumerate(temp):
            isleaf = False
            if i == len(temp) - 1:
                isleaf = True
            # try and except is more efficient than 'in'
            try:
                att_tree[t]
            except:
                att_tree[t] = GenTree(t, att_tree[temp[i - 1]], isleaf)
    if __DEBUG:
        print ("Nodes No. = %d" % att_tree['*'].support)
    treefile.close()
    return att_tree
