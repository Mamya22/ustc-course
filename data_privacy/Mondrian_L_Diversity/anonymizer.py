"""
run mondrian_l_diversity with given parameters
"""

# !/usr/bin/env python
# coding=utf-8
from mondrian_entropy_l_diversity import mondrian_entropy_l_diversity
from mondrian_l_diversity import mondrian_l_diversity
from utils.read_adult_data import read_data as read_adult
from utils.read_adult_data import read_tree as read_adult_tree
from utils.read_informs_data import read_data as read_informs
from utils.read_informs_data import read_tree as read_informs_tree
import sys
import copy
import pdb
import random

DATA_SELECT = 'a'


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
    with open("data/anonymized.data", "w") as output:
        for r in result:
            output.write(';'.join(map(extend_result, r)) + '\n')


def get_result_one(att_trees, data, l=5):
    """
    run mondrian_l_diversity for one time
    """
    print("L=%d" % l)
    data_back = copy.deepcopy(data)
    result, eval_result = mondrian_entropy_l_diversity(att_trees, data, l)
    write_to_file(result)
    data = copy.deepcopy(data_back)
    print("NCP= %0.2f %%" % eval_result[0])
    print("Running time %0.2f" % eval_result[1] + " seconds")


def get_result_l(att_trees, data):
    """
    change l, whle fixing QD and size of dataset
    """
    data_back = copy.deepcopy(data)
    for l in range(2, 21):
        print('#' * 30)
        print("L=%d" % l)
        result, eval_result = mondrian_entropy_l_diversity(att_trees, data, l)
        data = copy.deepcopy(data_back)
        print("NCP %0.2f" % eval_result[0] + "%")
        print("Running time %0.2f" % eval_result[1] + " seconds")


def get_result_dataset(att_trees, data, l=5, num_test=10):
    """
    fix l, while changing size of dataset
    num_test is the test nubmber.
    """
    data_back = copy.deepcopy(data)
    length = len(data_back)
    joint = 3000
    dataset_num = length / joint
    print("L=%d" % l)
    if length % joint == 0:
        dataset_num += 1
    for i in range(1, int(dataset_num) + 1):
        pos = i * joint
        ncp = rtime = 0
        if pos > length:
            continue
        print('#' * 30)
        print("size of dataset %d" % pos)
        for j in range(num_test):
            temp = random.sample(data, pos)
            _, eval_result = mondrian_entropy_l_diversity(att_trees, temp, l)
            ncp += eval_result[0]
            rtime += eval_result[1]
            data = copy.deepcopy(data_back)
        ncp /= num_test
        rtime /= num_test
        print("Average NCP %0.2f" % ncp + "%")
        print("Running time %0.2f" % rtime + " seconds")
        print('#' * 30)



if __name__ == '__main__':
    FLAG = ''
    LEN_ARGV = len(sys.argv)
    try:
        FLAG = sys.argv[1]
    except IndexError:
        pass
    INPUT_L = 5
    
    # dataset preprocess
    DATA = read_adult()
    ATT_TREES = read_adult_tree()
    
    if FLAG == '':
        get_result_one(ATT_TREES, DATA)
        
    elif FLAG == 'l':
        get_result_l(ATT_TREES, DATA)
        
    elif FLAG == 'data':
        get_result_dataset(ATT_TREES, DATA)

    else:
        try:
            INPUT_L = int(FLAG)
            get_result_one(ATT_TREES, DATA, INPUT_L)
        except ValueError:
            print("l: varying l")
            print("data: varying size of dataset")
    print("Finish Mondrian_L_Diversity!!")
