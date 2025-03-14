"""
run mondrian with given parameters
"""

# !/usr/bin/env python
# coding=utf-8
from mondrian import mondrian
from utils.read_adult_data import read_data as read_adult
import sys, copy, random
import csv
import os

DATA_SELECT = 'a'
RELAX = False
INTUITIVE_ORDER = None


def write_to_file(result):
    """
    write the anonymized result to anonymized.data
    """
    with open("data/anonymized.data", "w") as output:
        for r in result:
            output.write(';'.join(r) + '\n')


def get_result_one(data, k=10):
    """
    run mondrian for one time, with k=10
    """
    print("K=%d" % k)
    data_back = copy.deepcopy(data)
    result, eval_result = mondrian(data, k, RELAX)
    # Convert numerical values back to categorical values if necessary
    if DATA_SELECT == 'a':
        result = covert_to_raw(result)
    else:
        for r in result:
            r[-1] = ','.join(r[-1])
    # write to anonymized.out
    write_to_file(result)
    data = copy.deepcopy(data_back)
    print("NCP %0.2f" % eval_result[0] + "%")
    print("Running time %0.2f" % eval_result[1] + " seconds")
    res = []
    res_dict = {}
    res_dict['K'] = k
    res_dict['DataSize'] = len(data)
    res_dict['qi'] = len(data[0]) - 1
    res_dict['NCP'] = '%0.2f' % eval_result[0]
    res_dict['Running Time'] = '%0.2f' % eval_result[1]
    res.append(res_dict)
    with open("data\\"+filename, mode='a', newline='') as file:            
        column = ['K', 'DataSize', 'qi', 'NCP', 'Running Time']
        writer = csv.DictWriter(file, fieldnames=column)
        writer.writerows(res)


def get_result_k(data):
    """
    change k, while fixing QD and size of data set
    """
    data_back = copy.deepcopy(data)
    res = []
    for k in range(5, 105, 5):
        res_dict = {}
        print('#' * 30)
        print("K=%d" % k)
        res_dict['K'] = k
        result, eval_result = mondrian(data, k, RELAX)
        if DATA_SELECT == 'a':
            result = covert_to_raw(result)
        data = copy.deepcopy(data_back)
        print("NCP %0.2f" % eval_result[0] + "%")
        res_dict['DataSize'] = len(data)
        res_dict['qi'] = len(data[0])-1
        res_dict['NCP'] = '%0.2f' % eval_result[0]
        print("Running time %0.2f" % eval_result[1] + " seconds")
        res_dict['Running Time'] = '%0.2f' % eval_result[1]
        res.append(res_dict)
    print(res)

    with open("data\\"+filename, mode='a', newline='') as file:            
        column = ['K', 'DataSize', 'qi', 'NCP', 'Running Time']
        writer = csv.DictWriter(file, fieldnames=column)
        writer.writerows(res)


def get_result_dataset(data, k=10, num_test=10):
    """
    fix k and QI, while changing size of data set
    num_test is the test number.
    """
    data_back = copy.deepcopy(data)
    length = len(data_back)
    joint = 5000
    datasets = []
    check_time = length / joint
    if length % joint == 0:
        check_time -= 1
    for i in range(int(check_time)):
        datasets.append(joint * (i + 1))
    datasets.append(length)
    ncp = 0
    rtime = 0
    res = []
    for pos in datasets:
        res_dict = {}
        print('#' * 30)
        print("size of dataset %d" % pos)
        for j in range(num_test):
            temp = random.sample(data, pos)
            result, eval_result = mondrian(temp, k, RELAX)
            if DATA_SELECT == 'a':
                result = covert_to_raw(result)
            ncp += eval_result[0]
            rtime += eval_result[1]
            data = copy.deepcopy(data_back)
        ncp /= num_test
        rtime /= num_test
        print("Average NCP %0.2f" % ncp + "%")
        print("Running time %0.2f" % rtime + " seconds")
        print('#' * 30)
        res_dict['K'] = k
        res_dict['DataSize'] = pos
        res_dict['qi'] = len(data[0])-1
        res_dict['NCP'] = '%0.2f' % ncp
        res_dict['Running Time'] = '%0.2f' % rtime
        res.append(res_dict)
    with open("data\\"+filename, mode='a', newline='') as file:            
        column = ['K', 'DataSize', 'qi', 'NCP', 'Running Time']
        writer = csv.DictWriter(file, fieldnames=column)
        writer.writerows(res)



def get_result_qi(data, k=10):
    """
    change number of QI, while fixing k and size of data set
    """
    data_back = copy.deepcopy(data)
    num_data = len(data[0])
    res = []
    for i in reversed(list(range(1, num_data))):
        print('#' * 30)
        print("Number of QI=%d" % i)
        result, eval_result = mondrian(data, k, RELAX, i)
        if DATA_SELECT == 'a':
            result = covert_to_raw(result)
        data = copy.deepcopy(data_back)
        print("NCP %0.2f" % eval_result[0] + "%")
        print("Running time %0.2f" % eval_result[1] + " seconds")
        res_dict = {}
        res_dict['K'] = k
        res_dict['DataSize'] = len(data)
        res_dict['qi'] = i
        res_dict['NCP'] = '%0.2f' % eval_result[0]
        res_dict['Running Time'] = '%0.2f' % eval_result[1]
        res.append(res_dict)
    with open("data\\"+filename, mode='a', newline='') as file:            
        column = ['K', 'DataSize', 'qi', 'NCP', 'Running Time']
        writer = csv.DictWriter(file, fieldnames=column)
        writer.writerows(res)

def covert_to_raw(result, connect_str='~'):
    """
    During preprocessing, categorical attributes are covert to
    numeric attribute using intuitive order. This function will covert
    these values back to they raw values. For example, Female and Male
    may be converted to 0 and 1 during anonymizaiton. Then we need to transform
    them back to original values after anonymization.
    """
    covert_result = []
    qi_len = len(INTUITIVE_ORDER)
    for record in result:
        covert_record = []
        for i in range(qi_len):
            if len(INTUITIVE_ORDER[i]) > 0:
                vtemp = ''
                if connect_str in str(record[i]):
                    temp = record[i].split(connect_str)
                    raw_list = []
                    for j in range(int(temp[0]), int(temp[1]) + 1):
                        raw_list.append(INTUITIVE_ORDER[i][j])
                    vtemp = connect_str.join(raw_list)
                else:
                    vtemp = INTUITIVE_ORDER[i][int(record[i])]
                covert_record.append(vtemp)
            else:
                covert_record.append(record[i])
        if isinstance(record[-1], str):
            covert_result.append(covert_record + [record[-1]])
        else:
            covert_result.append(covert_record + [connect_str.join(record[-1])])
    return covert_result

filename = ""
if __name__ == '__main__':
    FLAG = ''
    DATA_SELECT = 'a'
    LEN_ARGV = len(sys.argv)
    try:
        MODEL = sys.argv[1]
    except IndexError:
        MODEL = 's'
    INPUT_K = 10
    # read record
    if MODEL == 's':
        RELAX = False
    else:
        RELAX = True
    if RELAX:
        filename = "output_relax.csv"
        print("Relax Mondrian")
        if not os.path.exists('data\\'+filename):
            with open("data\\"+filename, mode='w', newline='') as file:
        # if not os.path.exists('data\\output.csv'):
                column = ['K', 'DataSize', 'qi', 'NCP', 'Running Time']
                writer = csv.writer(file)
                writer.writerow(column)
    else:
        filename = "output_strict.csv"
        if not os.path.exists('data\\'+filename):
            with open("data\\"+filename, mode='w', newline='') as file:
        # if not os.path.exists('data\\output.csv'):
                column = ['K', 'DataSize', 'qi', 'NCP', 'Running Time']
                writer = csv.writer(file)
                writer.writerow(column)
        print("Strict Mondrian")

    # INTUITIVE_ORDER is an intuitive order for
    # categorical attributes. This order is produced
    # by the reading (from data set) order.
    DATA, INTUITIVE_ORDER = read_adult()
    if LEN_ARGV > 2:
        FLAG = sys.argv[2]
    if FLAG == 'k':
        get_result_k(DATA)
    elif FLAG == 'qi':
        get_result_qi(DATA)
    elif FLAG == 'data':
        get_result_dataset(DATA)
    elif FLAG == '':
        get_result_one(DATA)
    else:
        try:
            INPUT_K = int(FLAG)
            get_result_one(DATA, INPUT_K)
        except ValueError:
            print("Usage: python anonymizer [r|s] [k | qi | data | k-value]")
            print("r: relax mondrian, s: strict mondrian")
            print("k: varying k")
            print("qi: varying qi numbers")
            print("data: varying size of dataset")
            print("k-value: run with the specific k-value")
            print("example: python anonymizer.py s k")
            print("example: python anonymizer.py r qi")
            print("example: python anonymizer.py r data")
            print("example: python anonymizer.py s 10")
    # anonymized dataset is stored in result
    print("Finish Mondrian!!")
