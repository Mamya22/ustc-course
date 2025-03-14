# !/usr/bin/env python
# coding:utf-8
"""
public functions
"""

from datetime import datetime
import time

def cmp(x, y):
    if x > y:
        return 1
    elif x==y:
        return 0
    else:
        return -1


def cmp_str(element1, element2):
    """
    compare number in str format correctley
    """
    try:
        return cmp(int(element1), int(element2))
    except ValueError:
        return cmp(element1, element2)

def cmp_value(element1, element2):
    if isinstance(element1, str):
        return cmp_str(element1, element2)
    else:
        return cmp(element1, element2)


def value(x):
    '''Return the numeric type that supports addition and subtraction'''
    if isinstance(x, (int, float)):
        return float(x)
    elif isinstance(x, datetime):
        return time.mktime(x.timetuple())
        # return x.timestamp() # not supported by python 2.7
    else:
        try:
            return float(x)
        except Exception as e:
            return x

