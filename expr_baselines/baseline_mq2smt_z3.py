#!/usr/bin/env python
# -*- coding: utf-8 -*-

__ENV__  =  'sage';
__author__ =  'hanss401';

"""
NOTE !!!! This file must be runned by Python3.6;
This will raise errors in SageMath even you install z3-solver for your SageMath;
"""

import numpy as np;
import os;
import sys;
import time;
import re;
from z3 import *;

def print_equations(EQUATIONS,NAME='EQUATIONS'):
    print('---------------- '+NAME+' ------------------------------');
    for line in EQUATIONS:
        print(line);

def get_equations_from_fes_format_in(FILE_NAME):
    EQUATIONS_Z3 = [];
    FILEIN = open(FILE_NAME);
    RES_DATA = FILEIN.readlines();
    for LINE in RES_DATA:
        LINE = LINE.replace('\n','');
        if ',' in LINE:continue;
        STRING_COMMAND = "EQUATIONS_Z3.append(" + LINE +")";
        exec(STRING_COMMAND);
    return EQUATIONS_Z3;

MAX_USED_VARS = 14;
MAX_NUM_EQ = 14;
DATASET_SAMPLES_NUM = 1;
SAVED_PATH = "dataset/EQUATIONS_n" + str(MAX_USED_VARS) + "_m" + str(MAX_NUM_EQ) + "_F1.in";

x0= Int('x0');x1= Int('x1');x2= Int('x2');x3= Int('x3');x4= Int('x4');x5= Int('x5');x6= Int('x6');x7= Int('x7');x8= Int('x8');x9= Int('x9');x10= Int('x10');x11= Int('x11');x12= Int('x12');x13= Int('x13');x14= Int('x14');x15= Int('x15');x16= Int('x16');x17= Int('x17');x18= Int('x18');x19= Int('x19');x20= Int('x20');x21= Int('x21');x22= Int('x22');x23= Int('x23');x24= Int('x24');x25= Int('x25');x26= Int('x26');x27= Int('x27');x28= Int('x28');x29= Int('x29');x30= Int('x30');x31= Int('x31');x32= Int('x32');x33= Int('x33');x34= Int('x34');x35= Int('x35');x36= Int('x36');x37= Int('x37');x38= Int('x38');x39= Int('x39');x40= Int('x40');x41= Int('x41');x42= Int('x42');x43= Int('x43');x44= Int('x44');x45= Int('x45');x46= Int('x46');x47= Int('x47');x48= Int('x48');x49= Int('x49');x50= Int('x50');
ITEMS_Z3_ALL = [x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31,x32,x33,x34,x35,x36,x37,x38,x39,x40,x41,x42,x43,x44,x45,x46,x47,x48,x49,x50];

SMT_SOLVER = Solver();
ITEMS_VAR_USED = ITEMS_Z3_ALL[0:MAX_USED_VARS];
EQUATIONS_Z3 = get_equations_from_fes_format_in(SAVED_PATH);
#print(EQUATIONS_Z3);exit(1);

for MONOMIAL in ITEMS_VAR_USED:
    SMT_SOLVER.add(MONOMIAL<=1);SMT_SOLVER.add(MONOMIAL>=0);

for EQUATION in EQUATIONS_Z3:
    SMT_SOLVER.add(EQUATION%2 == 0);

TIME_START = time.time();
print(SMT_SOLVER.check());
TIME_END = time.time();
print( 'Costing Time: '  + str(TIME_END - TIME_START));sys.exit(1);
# print(SMT_SOLVER.model());