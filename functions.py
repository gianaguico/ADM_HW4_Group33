#import useful libraries
import pandas as pd
import numpy as np
from tqdm import tqdm
from random import randint
from datetime import datetime

#convert Date of Birth to actual age
def DOB_to_age(df):
    now = int(datetime.strftime(datetime.today().date()).split('-')[0])
    age = df.apply(lambda x: now - x)
    return age

#convert Weekday
def day_of_week(val):
  if val == "Mon":
    return 1
  elif val == "Tue":
    return 2
  elif val == "Wed":
    return 3
  elif val == "Thu":
    return 4
  elif val == "Fri":
    return 5
  elif val == "Sat":
    return 6
  elif val == "Sun":
    return 7

#get time interval ranges
def time_ranges(val):
  tmp = int(val.split(':')[0])

  if tmp >= 0 and tmp < 2:
    return 1
  elif tmp >= 2 and tmp < 4:
    return 2
  elif tmp >= 4 and tmp < 6:
    return 3
  elif tmp >= 6 and tmp < 8:
    return 4
  elif tmp >= 8 and tmp < 10:
    return 5
  elif tmp >= 10 and tmp < 12:
    return 6
  elif tmp >= 12 and tmp < 14:
    return 7
  elif tmp >= 14 and tmp < 16:
    return 8
  elif tmp >= 16 and tmp < 18:
    return 9
  elif tmp >= 18 and tmp < 20:
    return 10
  elif tmp >= 20 and tmp < 22:
    return 11
  else: return 12

#converting data to int
#let's define some functions
def float_to_int(value):
    return int(value)

def date_to_int(value):
    return int(pd.Timestamp(value).timestamp())

def string_to_int(value):
    return sum(ord(x) for x in value)

#hash function
def hash(val, a, b, c):
    return (a*val+b)%c

#Minhash
def min_hash(info,c ,list_of_tuples):

    signatures = []

    for idx, x in enumerate(info):
        hash_value = []
        for values in list_of_tuples:
            a,b = values
            ans = hash(x,a,b,c)
            hash_value.append(ans)
        signatures.append(int(min(hash_value)))
        
    return signatures


def random_coef(n_hash, M):

    a = []
    b = []

    for _ in range(n_hash):
        a_i = randint(0,M)
        a.append(a_i)
        b_i = randint(0,M)
        b.append(b_i)
    return a,b