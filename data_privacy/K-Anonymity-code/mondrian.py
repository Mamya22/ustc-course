# coding:utf-8
"""
main module of mondrian
"""

# !/usr/bin/env python
# coding=utf-8

import pdb
import time
from utils.utility import cmp_value, value
from functools import cmp_to_key

# warning all these variables should be re-inited, if
# you want to run mondrian with different parameters
__DEBUG = False
QI_LEN = 10
GL_K = 0
RESULT = []
QI_RANGE = []    # 第i个准标识符的属性范围大小
QI_DICT = []     # QI_DICT[i][ai_value] 第i个准标识符的属性值在QI_ORDER[i]上的索引
QI_ORDER = []    # 第i个准标识符对应的排序后属性值序列


class Partition(object):

    """
    Class for Group (or EC), which is used to keep records
    self.member: records in group
    self.low: lower point, use index to avoid negative values
    self.high: higher point, use index to avoid negative values
    self.allow: show if partition can be split on this QI
    """

    def __init__(self, data, low, high):
        """
        split_tuple = (index, low, high)
        """
        self.low = list(low)
        self.high = list(high)
        self.member = data[:]
        self.allow = [1] * QI_LEN

    def add_record(self, record, dim):
        """
        add one record to member
        """
        self.member.append(record)

    def add_multiple_record(self, records, dim):
        """
        add multiple records (list) to partition
        """
        for record in records:
            self.add_record(record, dim)

    def __len__(self):
        """
        return number of records
        """
        return len(self.member)


def get_normalized_width(partition, index):
    """
    return Normalized width of partition
    similar to NCP
    """
    d_order = QI_ORDER[index]
    width = value(d_order[partition.high[index]]) - value(d_order[partition.low[index]])
    if width == QI_RANGE[index]:
        return 1
    return width * 1.0 / QI_RANGE[index]


def choose_dimension(partition):
    """
    choose dim with largest norm_width from all attributes.
    This function can be upgraded with other distance function.
    """
    max_width = -1
    max_dim = -1
    for dim in range(QI_LEN):
        if partition.allow[dim] == 0:
            continue
        norm_width = get_normalized_width(partition, dim)
        if norm_width > max_width:
            max_width = norm_width
            max_dim = dim
    if max_width > 1:
        pdb.set_trace()
    return max_dim


def frequency_set(partition, dim):
    """
    get the frequency_set of partition on dim
    """
    frequency = {}
    for record in partition.member:
        try:
            frequency[record[dim]] += 1
        except KeyError:
            frequency[record[dim]] = 1
    return frequency


def find_median(partition, dim):
    """
    find the middle of the partition, return split_val
    """
    # use frequency set to get median
    frequency = frequency_set(partition, dim)
    split_val = ''
    next_val = ''
    value_list = list(frequency.keys())
    value_list.sort(key=cmp_to_key(cmp_value)) # value_list是所有key的排序
    total = sum(frequency.values()) # 求所有数据的数量
    middle = total // 2
    if middle < GL_K or len(value_list) <= 1:
        try:
            return '', '', value_list[0], value_list[-1]
        except IndexError:
            return '', '', '', ''
    index = 0
    split_index = 0
    for i, qi_value in enumerate(value_list):
        index += frequency[qi_value]
        if index >= middle:
            split_val = qi_value
            split_index = i
            break
    else:
        print("Error: cannot find split_val")
    try:
        next_val = value_list[split_index + 1]
    except IndexError:
        # there is a frequency value in partition
        # which can be handle by mid_set
        # e.g.[1, 2, 3, 4, 4, 4, 4]
        next_val = split_val
    return (split_val, next_val, value_list[0], value_list[-1])

def merge_qi_value(x_left, x_right, connect_str='~'):
    '''Connect the interval boundary value as a generalized interval and return the result as a string
    return:
        result:string
    '''
    if isinstance(x_left, (int, float)):
        if x_left == x_right:
            result = '%d' % (x_left)
        else:
            result = '%d%s%d' % (x_left, connect_str, x_right)
    elif isinstance(x_left, str):
        if x_left == x_right:
            result = x_left
        else:
            result = x_left + connect_str + x_right
    elif isinstance(x_left, datetime):
        # Generalize the datetime type value
        begin_date = x_left.strftime("%Y-%m-%d %H:%M:%S")
        end_date = x_right.strftime("%Y-%m-%d %H:%M:%S")
        result = begin_date + connect_str + end_date
    return result

"""
TO DO:
"""
def anonymize_strict(partition):
    """
    recursively partition groups until not allowable
    """
    allow_count = sum(partition.allow)
    # only run allow_count times
    if allow_count == 0:
        RESULT.append(partition)
        return
    for index in range(allow_count):
        # choose attribute from domain (*)
        dim = choose_dimension(partition)  
        # 若dim = -1， 说明前面在数据的range等计算时有误
        if dim == -1:
            print("Error: dim = -1 (anonymize_strict function)")
            # need to debug
            pdb.set_trace()
        """
        # use find_median function
        # return value : split_val: 中位数
        # next_val: 中位数的右侧数字
        # low: 该维度的最小值
        # high: t该维度的最大值
        """
        (split_val, next_val, low_val, high_val) = find_median(partition, dim)

        # update parent low and high (*)
        if low_val != '' and high_val != '':
            partition.low[dim] = QI_DICT[dim][low_val] 
            partition.high[dim] = QI_DICT[dim][high_val]
        # 参考mondrian_2.py，对split_val进行判断
        if split_val == '' or split_val == next_val:   # 说明该维无法继续分
            partition.allow[dim] = 0
            # anonymize_strict(partition)
            continue   # 与anonymize_relaxed不同，该函数用循环写，所以continue

        # split the group from median (*)
        l_val_list = []
        r_val_list = []
        # 找到splitVal在数据集中的排序位置
        mean = QI_DICT[dim][split_val]      
        for record in partition.member:
            # record might not be sorted, and the value might not a number, so we can use QI_DICT
            # find this record's index
            # 由于是严格划分，则小于等于mean的都划分到左侧
            record_index = QI_DICT[dim][record[dim]]
            if record_index <= mean:
                l_val_list.append(record)
            else:
                r_val_list.append(record)
        # check is lhs and rhs satisfy k-anonymity (*)
        if len(l_val_list) < GL_K or len(r_val_list) < GL_K:
            # print(f"Error: split dim{dim+1} doesn't satisfy k-anonymity (anonymize_strict function)")
            # 该维度不可进行划分
            partition.allow[dim] = 0
            continue
        # anonymize sub-partition
        lhs_high = partition.high[:]
        rhs_low = partition.low[:]
        # 更新划分子集对应的low和high
        lhs_high[dim] = mean
        rhs_low[dim] = QI_DICT[dim][next_val]
        lhs = Partition(l_val_list, partition.low, lhs_high)
        rhs = Partition(r_val_list, rhs_low, partition.high)
        anonymize_strict(lhs)
        anonymize_strict(rhs)
        return
    RESULT.append(partition)

"""
TO DO:
"""
def anonymize_relaxed(partition):
    """
    recursively partition groups until not allowable
    """
    if sum(partition.allow) == 0:
        # can not split
        RESULT.append(partition)
        return

    # choose attribute from domain (*)
    dim = choose_dimension(partition)  
    # 若dim = -1， 说明前面在数据的range等计算时有误
    if dim == -1:
        print("Error: dim = -1 (anonymize_relaxed function)")
        # need to debug
        pdb.set_trace()

    # use frequency set to get median (*)
    """
    # use find_median function
    # return value : split_val: 中位数
    # next_val: 中位数的右侧数字
    # low: 该维度的最小值
    # high: t该维度的最大值
    """
    # split_val, next_val可能是''
    # low_val和high_val也可能是''
    (split_val, next_val, low_val, high_val) = find_median(partition, dim)

    # update parent low and high (*)
    # 找到对应low_val和high_val的位置（在值排序后的位置）
    if low_val != '' and high_val != '':
        partition.low[dim] = QI_DICT[dim][low_val] 
        partition.high[dim] = QI_DICT[dim][high_val]
    # 参考mondrian_2.py，对split_val进行判断
    if split_val == '':   # 说明该维无法继续分
        partition.allow[dim] = 0
        anonymize_relaxed(partition) # 继续寻找可划分的下一维度
        return
    
    # split the group from median (records equal to the mean are stored first) (*)
    # 找到了用于划分的val和nextval，但由于是平分，所以对于值和split_val相同的要单独划分
    eq_split_val_list = []
    l_val_list = []
    r_val_list = []
    mean = QI_DICT[dim][split_val]
    for record in partition.member:
        # 根据QI_DICT的值进行划分，如果该值对应的位置(value)小于split_val对应的位置，则在左侧
        record_index = QI_DICT[dim][record[dim]]
        if record_index < mean:
            l_val_list.append(record)
        elif record_index > mean:
            r_val_list.append(record)
        else:
            eq_split_val_list.append(record)
    # handle records in the middle (*)
    # 划分eq_split_val_list
    lhs_len = len(l_val_list)
    # rhs_len = len(r_val_list)
    ########
    #  若要使得数量为奇数时，左划分数量多1，则需要变为 half_len =(len(partition)+1)//2 ，
    # 鉴于在求中间数find_median的时候中间数取值为(len(partition))//2
    # 所以在此处使用half_len =(len(partition)+1)会有错误。这种方式对应（lhs + 1） | lhs = rhs 
    #######
    half_len = (len(partition)) // 2 

    for i in range(half_len - lhs_len):
        record = eq_split_val_list.pop()
        l_val_list.append(record)

    rhs_low_val = QI_DICT[dim][next_val]
    # the rest will be added to rhs
    if len(eq_split_val_list) > 0:
        rhs_low_val = QI_DICT[dim][split_val] # 对于split_val有一些被分到了右侧，更新右侧的low
        for record in eq_split_val_list:
            r_val_list.append(record)
        
    # check is lhs and rhs satisfy k-anonymity (*)
    # 在splitVal中，已经对是否满足进行了判断，在这里的判断并不影响
    if len(l_val_list) < GL_K or len(r_val_list) < GL_K:
        # 不进行下一维度划分，因为数据集总长度小于2k
        partition.allow[dim] = 0
        # print("Error: split doesn't satisfy k-anonymity (anonymize_relaxed function)")
    # anonymize sub-partition
    # 创建新的partition，对于左侧的partition，该维度的high被改变，右侧的partition，该维度的low被改变
    lhs_high = partition.high[:]
    rhs_low = partition.low[:]
    lhs_high[dim] = mean
    rhs_low[dim] = rhs_low_val
    lhs = Partition(l_val_list, partition.low, lhs_high)
    rhs = Partition(r_val_list, rhs_low, partition.high)
    anonymize_relaxed(lhs)
    anonymize_relaxed(rhs)


def init(data, k, QI_num=-1):
    """
    reset global variables
    """
    global GL_K, RESULT, QI_LEN, QI_DICT, QI_RANGE, QI_ORDER
    if QI_num <= 0:
        QI_LEN = len(data[0]) - 1
    else:
        QI_LEN = QI_num
    GL_K = k
    RESULT = []
    # static values
    QI_DICT = []
    QI_ORDER = []
    QI_RANGE = []
    att_values = []
    for i in range(QI_LEN):
        att_values.append(set())
        QI_DICT.append(dict())
    for record in data:     # 遍历记录，保存在att_values里，每一行代表一个属性值
        for i in range(QI_LEN):
            att_values[i].add(record[i])
    for i in range(QI_LEN):  # 
        value_list = list(att_values[i])
        value_list.sort(key=cmp_to_key(cmp_value)) # 排序函数
        QI_RANGE.append(value(value_list[-1]) - value(value_list[0]))
        QI_ORDER.append(list(value_list))
        for index, qi_value in enumerate(value_list):
            QI_DICT[i][qi_value] = index    #保存了相同按序排列的qi_value的index


def mondrian(data, k, relax=False, QI_num=-1):
    """
    Main function of mondrian, return result in tuple (result, (ncp, rtime)).
    data: dataset in 2-dimensional array.
    k: k parameter for k-anonymity
    QI_num: Default -1, which exclude the last column. Otherwise, [0, 1,..., QI_num - 1]
            will be anonymized, [QI_num,...] will be excluded.
    relax: determine use strict or relaxed mondrian,
    Both mondrians split partition with binary split.
    In strict mondrian, lhs and rhs have not intersection.
    But in relaxed mondrian, lhs may be have intersection with rhs.
    """
    init(data, k, QI_num)
    result = []
    data_size = len(data)
    low = [0] * QI_LEN  # QI_LEN 指代 QI的数目
    high = [(len(t) - 1) for t in QI_ORDER]  # high指代每一个QI列的不同值的数目
    whole_partition = Partition(data, low, high)
    # begin mondrian
    start_time = time.time()
    if relax:
        # relax model
        anonymize_relaxed(whole_partition)
    else:
        # strict model
        anonymize_strict(whole_partition)
    rtime = float(time.time() - start_time)
    # generalization result and
    # evaluation information loss
    ncp = 0.0
    dp = 0.0
    for partition in RESULT:
        rncp = 0.0
        for index in range(QI_LEN):
            rncp += get_normalized_width(partition, index)
        rncp *= len(partition)
        ncp += rncp
        dp += len(partition) ** 2
        for record in partition.member[:]:
            for index in range(QI_LEN):
                record[index] = merge_qi_value(QI_ORDER[index][partition.low[index]],
                                QI_ORDER[index][partition.high[index]])
            result.append(record)
    # If you want to get NCP values instead of percentage
    # please remove next three lines
    ncp /= QI_LEN
    ncp /= data_size
    ncp *= 100
    if __DEBUG:
        from decimal import Decimal
        print("Discernability Penalty=%.2E" % Decimal(str(dp)))
        print("size of partitions=%d" % len(RESULT))
        print("K=%d" % k)
        print("NCP = %.2f %%" % ncp)
    return (result, (ncp, rtime))
