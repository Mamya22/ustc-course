"""
main module of mondrian_l_diversity
"""

# import pdb
from models.numrange import NumRange
from models.gentree import GenTree
from utils.utility import sort_str
import time
import math


__DEBUG = False
QI_LEN = 10
GL_L = 0
RESULT = []
ATT_TREES = []
QI_RANGE = []
IS_CAT = []


class Partition(object):

    """Class for Group, which is used to keep records
    Store tree node in instances.
    self.member: records in group
    self.width: width of this partition on each domain
    self.middle: save the generalization result of this partition
    self.allow: 0 donate that not allow to split, 1 donate can be split
    """

    def __init__(self, data, width, middle):
        """
        initialize with data, width and middle
        """
        self.member = data[:]
        self.width = list(width)
        self.middle = list(middle)
        self.allow = [1] * QI_LEN

    def __len__(self):
        """
        return the number of records in partition
        """
        return len(self.member)


# TO DO
# 熵良表示函数
def check_entropy_L_diversity(partition):
    sa_dict = {}
    if len(partition) < GL_L:
        return False
    if isinstance(partition, Partition):
        records_set = partition.member
    else:
        records_set = partition
    num_record = len(records_set)
    for record in records_set:
        sa_value = record[-1]
        try:
            sa_dict[sa_value] += 1
        except KeyError:
            sa_dict[sa_value] = 1
    entropy = 0.0
    for sa in sa_dict.keys():
        temp = sa_dict[sa] / num_record
        entropy += temp * math.log(temp, 2)
    if -entropy >= math.log(GL_L, 2):
        return True
    
    return False



def get_normalized_width(partition, index):
    """
    return Normalized width of partition
    similar to NCP
    """
    if IS_CAT[index] is False:
        low = partition.width[index][0]
        high = partition.width[index][1]
        width = float(ATT_TREES[index].sort_value[high]) - float(ATT_TREES[index].sort_value[low])
    else:
        width = partition.width[index]
    return width * 1.0 / QI_RANGE[index]


def choose_dimension(partition):
    """chooss dim with largest normlized Width
    return dim index.
    """
    max_witdh = -1
    max_dim = -1
    for i in range(QI_LEN):
        if partition.allow[i] == 0:
            continue
        normWidth = get_normalized_width(partition, i)
        if normWidth > max_witdh:
            max_witdh = normWidth
            max_dim = i
    if max_witdh > 1:
        print("Error: max_witdh > 1")
        pdb.set_trace()
    if max_dim == -1:
        print("cannot find the max dim")
        pdb.set_trace()
    return max_dim


def frequency_set(partition, dim):
    """get the frequency_set of partition on dim
    return dict{key: str values, values: count}
    """
    frequency = {}
    for record in partition.member:
        try:
            frequency[record[dim]] += 1
        except KeyError:
            frequency[record[dim]] = 1
    return frequency

    
def find_median(partition, dim):
    """find the middle of the partition
    return splitVal
    """
    frequency = frequency_set(partition, dim)
    splitVal = ''
    value_list = list(frequency.keys())
    # print(value_list,type(value_list))
    value_list.sort(key=sort_str)
    # value_list.sort(cmp=cmp_str)
    total = sum(frequency.values())
    middle = total / 2
    if middle < GL_L or len(value_list) <= 1:
        return ('', '', value_list[0], value_list[-1])
    index = 0
    split_index = 0
    for i, t in enumerate(value_list):
        index += frequency[t]
        if index >= middle:
            splitVal = t
            split_index = i
            break
    else:
        print("Error: cannot find splitVal")
    try:
        nextVal = value_list[split_index + 1]
    except IndexError:
        nextVal = splitVal
    return (splitVal, nextVal, value_list[0], value_list[-1])


def split_numerical_value(numeric_value, splitVal):
    """
    split numeric value on splitVal
    return sub ranges
    """
    split_num = numeric_value.split(',')
    if len(split_num) <= 1:
        return split_num[0], split_num[0]
    else:
        low = split_num[0]
        high = split_num[1]
        # Fix 2,2 problem
        if low == splitVal:
            lvalue = low
        else:
            lvalue = low + ',' + splitVal
        if high == splitVal:
            rvalue = high
        else:
            rvalue = splitVal + ',' + high
        return lvalue, rvalue


def split_numerical(partition, dim, pwidth, pmiddle):
    """
        strict split numeric attribute by finding a median,
        lhs = [low, means], rhs = (mean, high]
        """
    sub_partitions = []
    # numeric attributes
    (splitVal, nextVal, low, high) = find_median(partition, dim)
    p_low = ATT_TREES[dim].dict[low]
    p_high = ATT_TREES[dim].dict[high]
    # update middle
    if low == high:
        pmiddle[dim] = low
    else:
        pmiddle[dim] = low + ',' + high
    pwidth[dim] = (p_low, p_high)
    if splitVal == '' or splitVal == nextVal:
        # update middle
        return []
    middle_pos = ATT_TREES[dim].dict[splitVal]
    lmiddle = pmiddle[:]
    rmiddle = pmiddle[:]
    lmiddle[dim], rmiddle[dim] = split_numerical_value(pmiddle[dim], splitVal)
    lhs = []
    rhs = []
    for temp in partition.member:
        pos = ATT_TREES[dim].dict[temp[dim]]
        if pos <= middle_pos:
            # lhs = [low, means]
            lhs.append(temp)
        else:
            # rhs = (mean, high]
            rhs.append(temp)
    lwidth = pwidth[:]
    rwidth = pwidth[:]
    lwidth[dim] = (pwidth[dim][0], middle_pos)
    rwidth[dim] = (ATT_TREES[dim].dict[nextVal], pwidth[dim][1])
    if check_entropy_L_diversity(lhs) is False or check_entropy_L_diversity(rhs) is False:
        return []
    sub_partitions.append(Partition(lhs, lwidth, lmiddle))
    sub_partitions.append(Partition(rhs, rwidth, rmiddle))
    return sub_partitions


def split_categorical(partition, dim, pwidth, pmiddle):
    """
    split categorical attribute using generalization hierarchy
    """
    sub_partitions = []
    # categoric attributes
    splitVal = ATT_TREES[dim][partition.middle[dim]]
    sub_node = [t for t in splitVal.child]
    sub_groups = []
    for i in range(len(sub_node)):
        sub_groups.append([])
    if len(sub_groups) == 0:
        # split is not necessary
        return []
    for temp in partition.member:
        qid_value = temp[dim]
        for i, node in enumerate(sub_node):
            try:
                node.cover[qid_value]
                sub_groups[i].append(temp)
                break
            except KeyError:
                continue
        else:
            print("Generalization hierarchy error!")
    flag = True
    for index, sub_group in enumerate(sub_groups):
        if len(sub_group) == 0:
            continue
        if check_entropy_L_diversity(sub_group) is False:
            flag = False
            break
    if flag:
        for i, sub_group in enumerate(sub_groups):
            if len(sub_group) == 0:
                continue
            wtemp = pwidth[:]
            mtemp = pmiddle[:]
            wtemp[dim] = len(sub_node[i])
            mtemp[dim] = sub_node[i].value
            sub_partitions.append(Partition(sub_group, wtemp, mtemp))
    return sub_partitions


def split_partition(partition, dim):
    """
    split partition and distribute records to different sub-partitions
    """
    pwidth = partition.width
    pmiddle = partition.middle
    if IS_CAT[dim] is False:
        return split_numerical(partition, dim, pwidth, pmiddle)
    else:
        return split_categorical(partition, dim, pwidth, pmiddle)


def anonymize(partition):
    """
    Main procedure of Half_Partition.
    recursively partition groups until not allowable.
    """
    # print len(partition)
    # print partition.allow
    # pdb.set_trace()
    if check_splitable(partition) is False:
        RESULT.append(partition)
        return
    # Choose dim
    dim = choose_dimension(partition)
    if dim == -1:
        print("Error: dim=-1")
        pdb.set_trace()
    sub_partitions = split_partition(partition, dim)
    if len(sub_partitions) == 0:
        partition.allow[dim] = 0
        anonymize(partition)
    else:
        for sub_p in sub_partitions:
            anonymize(sub_p)


def check_splitable(partition):
    """
    Check if the partition can be further splited while satisfying k-anonymity.
    """
    temp = sum(partition.allow)
    if temp == 0:
        return False
    return True


def init(att_trees, data, L):
    """
    resset global variables
    """
    global GL_L, RESULT, QI_LEN, ATT_TREES, QI_RANGE, IS_CAT
    ATT_TREES = att_trees
    for gen_tree in att_trees:
        if isinstance(gen_tree, NumRange):
            IS_CAT.append(False)
        else:
            IS_CAT.append(True)
    QI_LEN = len(data[0]) - 1
    GL_L = L
    RESULT = []
    QI_RANGE = []

def mondrian_entropy_l_diversity(att_trees, data, L):
    """
    基于熵的Mondrian l-diversity实现
    参数与原函数相同,但使用熵检查替代计数检查
    """
    # 初始化全局变量
    init(att_trees, data, L)
    middle = []
    result = []
    wtemp = []
    
    # 初始化宽度和中间值
    for i in range(QI_LEN):
        if IS_CAT[i] is False:
            QI_RANGE.append(ATT_TREES[i].range)
            wtemp.append((0, len(ATT_TREES[i].sort_value) - 1))
            middle.append(ATT_TREES[i].value)
        else:
            QI_RANGE.append(len(ATT_TREES[i]['*']))
            wtemp.append(len(ATT_TREES[i]['*']))
            middle.append('*')
            
    # 创建初始分区
    whole_partition = Partition(data, wtemp, middle)
    
    # 记录开始时间
    start_time = time.time()
    
    # 使用熵检查进行匿名化
    anonymize(whole_partition)
    
    # 计算运行时间
    rtime = float(time.time() - start_time)
    
    # 计算NCP(标准化惩罚代价)
    ncp = 0.0
    dp = 0.0
    for partition in RESULT:
        rncp = 0.0
        dp += len(partition) ** 2
        
        # 计算每个维度的标准化宽度
        for i in range(QI_LEN):
            rncp += get_normalized_width(partition, i)
            
        # 生成泛化结果
        for i in range(len(partition)):
            gen_result = partition.middle + [partition.member[i][-1]]
            result.append(gen_result[:])
            
        rncp *= len(partition)
        ncp += rncp
        
    # 计算最终NCP
    ncp /= QI_LEN
    ncp /= len(data)
    ncp *= 100
    
    if __DEBUG:
        from decimal import Decimal
        print("Discernability Penalty=%.2E" % Decimal(str(dp)))
        print("Size of partitions:", len(RESULT))
        print("NCP = %.2f %%" % ncp)
        
    return (result, (ncp, rtime))