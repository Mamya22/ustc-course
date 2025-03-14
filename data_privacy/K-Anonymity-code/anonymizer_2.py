"""
run mondrian_2 with given parameters
"""

# !/usr/bin/env python
# coding=utf-8
from mondrian_2 import mondrian
from utils.read_adult_data import read_data_2 as read_adult
from utils.read_adult_data import read_tree as read_adult_tree
import sys, copy, random
import os
import csv
DATA_SELECT = 'a'
DEFAULT_K = 10
# sys.setrecursionlimit(50000)


def extend_result(val):
    """
    separated with ',' if it is a list
    """
    if isinstance(val, list):
        return ','.join(val)
    return val


def write_to_file(result):
    """
    write the anonymized result to anonymized.data
    """
    with open("data/anonymized_2.data", "w") as output:
        for r in result:
            output.write(';'.join(map(extend_result, r)) + '\n')


def get_result_one(att_trees, data, k=DEFAULT_K):
    #"run mondrian_2 for one time, with k=10"
    print ("K=%d" % k)
    print ("Mondrian")
    result, eval_result = mondrian(att_trees, data, k)
    write_to_file(result)
    print ("NCP %0.2f" % eval_result[0] + "%")
    print ("Running time %0.2f" % eval_result[1] + "seconds")
    res = []
    res_dict = {}
    res_dict['K'] = k
    res_dict['DataSize'] = len(data)
    res_dict['qi'] = len(data[0]) - 1
    res_dict['NCP'] = '%0.2f' % eval_result[0]
    res_dict['Running Time'] = '%0.2f' % eval_result[1]
    res.append(res_dict)
    with open("data\\output_2.csv", mode='a', newline='') as file:            
        column = ['K', 'DataSize', 'qi', 'NCP', 'Running Time']
        writer = csv.DictWriter(file, fieldnames=column)
        writer.writerows(res)


def get_result_k(att_trees, data):
    """
    change k, whle fixing QD and size of dataset
    """
    data_back = copy.deepcopy(data)
    all_ncp = []
    all_rtime = []
    res = []
    # for k in range(5, 105, 5):
    for k in [2, 5, 10, 25, 50, 100]:
        print ('#' * 30)
        print ("K=%d" % k)
        print ("Mondrian")
        _, eval_result = mondrian(att_trees, data, k)
        data = copy.deepcopy(data_back)
        print ("NCP %0.2f" % eval_result[0] + "%")
        all_ncp.append(round(eval_result[0], 2))
        print ("Running time %0.2f" % eval_result[1] + "seconds")
        all_rtime.append(round(eval_result[1], 2))
        res_dict = {}
        res_dict['K'] = k
        res_dict['DataSize'] = len(data)
        res_dict['qi'] = len(data[0]) - 1
        res_dict['NCP'] = '%0.2f' % eval_result[0]
        res_dict['Running Time'] = '%0.2f' % eval_result[1]
        res.append(res_dict)
        with open("data\\output_2.csv", mode='a', newline='') as file:            
            column = ['K', 'DataSize', 'qi', 'NCP', 'Running Time']
            writer = csv.DictWriter(file, fieldnames=column)
            writer.writerows(res)
    print ("All NCP", all_ncp)
    print ("All Running time", all_rtime)


def get_result_dataset(att_trees, data, k=DEFAULT_K, n=10):
    """
    fix k and QI, while changing size of dataset
    n is the proportion nubmber.
    """
    data_back = copy.deepcopy(data)
    length = len(data_back)
    print ("K=%d" % k)
    joint = 5000
    datasets = []
    check_time = length / joint
    if length % joint == 0:
        check_time -= 1
    for i in range(int(check_time)):
        datasets.append(joint * (i + 1))
    datasets.append(length)
    all_ncp = []
    all_rtime = []
    res = []
    for pos in datasets:
        ncp = rtime = 0
        print ('#' * 30)
        print ("size of dataset %d" % pos)
        for j in range(n):
            temp = random.sample(data, pos)
            result, eval_result = mondrian(att_trees, temp, k)
            ncp += eval_result[0]
            rtime += eval_result[1]
            data = copy.deepcopy(data_back)
        ncp /= n
        rtime /= n
        print ("Average NCP %0.2f" % ncp + "%")
        all_ncp.append(round(ncp, 2))
        print ("Running time %0.2f" % rtime + "seconds")
        all_rtime.append(round(rtime, 2))
        res_dict = {}
        res_dict['K'] = k
        res_dict['DataSize'] = pos
        res_dict['qi'] = len(data[0]) - 1
        res_dict['NCP'] = '%0.2f' % ncp
        res_dict['Running Time'] = '%0.2f' % rtime
        res.append(res_dict)
        with open("data\\output_2.csv", mode='a', newline='') as file:            
            column = ['K', 'DataSize', 'qi', 'NCP', 'Running Time']
            writer = csv.DictWriter(file, fieldnames=column)
            writer.writerows(res)
    print ('#' * 30)
    print ("All NCP", all_ncp)
    print ("All Running time", all_rtime)


def get_result_qi(att_trees, data, k=DEFAULT_K):
    """
    change nubmber of QI, whle fixing k and size of dataset
    """
    data_back = copy.deepcopy(data)
    ls = len(data[0])
    all_ncp = []
    all_rtime = []
    res = []
    for i in range(1, ls):
        print ('#' * 30)
        print ("Number of QI=%d" % i)
        _, eval_result = mondrian(att_trees, data, k, i)
        data = copy.deepcopy(data_back)
        print ("NCP %0.2f" % eval_result[0] + "%")
        all_ncp.append(round(eval_result[0], 2))
        print ("Running time %0.2f" % eval_result[1] + "seconds")
        all_rtime.append(round(eval_result[1], 2))
        res_dict = {}
        res_dict['K'] = k
        res_dict['DataSize'] = len(data)
        res_dict['qi'] = i
        res_dict['NCP'] = '%0.2f' % eval_result[0]
        res_dict['Running Time'] = '%0.2f' % eval_result[1]
        res.append(res_dict)
    with open("data\\output_2.csv", mode='a', newline='') as file:            
        column = ['K', 'DataSize', 'qi', 'NCP', 'Running Time']
        writer = csv.DictWriter(file, fieldnames=column)
        writer.writerows(res)
    print ("All NCP", all_ncp)
    print ("All Running time", all_rtime)


if __name__ == '__main__':
    FLAG = ''
    LEN_ARGV = len(sys.argv)
    DATA_SELECT = 'a'
    RAW_DATA = read_adult()       # 读取的数据
    ATT_TREES = read_adult_tree() # 构建泛化的树，对于非数值型，构建树
    try:
        FLAG = sys.argv[1]
    except:
        pass
    k = 10
    print ('#' * 30)
    if not os.path.exists('data\\output_2.csv'):
        with open("data\\output_2.csv", mode='w', newline='') as file:
        # if not os.path.exists('data\\output.csv'):
            column = ['K', 'DataSize', 'qi', 'NCP', 'Running Time']
            writer = csv.writer(file)
            writer.writerow(column)
    if FLAG == 'k':
        get_result_k(ATT_TREES, RAW_DATA)
    elif FLAG == 'qi':
        get_result_qi(ATT_TREES, RAW_DATA)
    elif FLAG == 'data':
        get_result_dataset(ATT_TREES, RAW_DATA)
    elif FLAG == '':
        
        get_result_one(ATT_TREES, RAW_DATA)
    else:
        try:
            INPUT_K = int(FLAG)
            get_result_one(ATT_TREES, RAW_DATA, INPUT_K)
        except ValueError:
            print ("Usage: python anonymizer_2.py  [k | qi | data | k-value]")
            print ("K: varying k, qi: varying qi numbers, data: varying size of dataset, \
                     k-value: run with the specific k-value")
            print("example: python anonymizer_2.py k")
            print("example: python anonymizer_2.py qi")
            print("example: python anonymizer_2.py data")
            print("example: python anonymizer_2.py 10")
    # anonymized dataset is stored in result
    print ("Finish Mondrian_2!!")
