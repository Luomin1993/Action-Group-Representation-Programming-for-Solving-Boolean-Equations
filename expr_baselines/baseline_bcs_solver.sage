#!/usr/bin/env python
# -*- coding: utf-8 -*-

__ENV__  =  'sage';
__author__ =  'hanss401';

import os;
from sage.misc.python import Python;

#  ---- Hack to import my own sage scripts; ----
def Import_Sage_File(module_name, func_name='*'):
    os.system('sage --preparse ' + module_name + '.sage');
    os.system('mv ' + module_name+'.sage.py ' + module_name.replace('../','')+'.py');
    python = Python();
    python.eval('from ' + module_name.replace('../','') + ' import ' + func_name, globals());

Import_Sage_File('../functions');

BOOLEAN_RING.<x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31,x32,x33,x34,x35,x36,x37,x38,x39,x40> = BooleanPolynomialRing()
ITEMS_BOOLEAN = [x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31,x32,x33,x34,x35,x36,x37,x38,x39,x40];

# ============================== STEP 1:reading and handling mq dataset ===================================
MAX_USED_VARS = 8;
MAX_NUM_EQ = 8;
DATASET_SAMPLES_NUM = 1;
SAVED_PATH = "dataset/EQUATIONS_n" + str(MAX_USED_VARS) + "_m" + str(MAX_NUM_EQ) + "_F1.in";

# ------------ Groebner Basis Computing ------------------
EQUATIONS_MQ = get_equations_from_fes_format_in(SAVED_PATH);
#print_equations(EQUATIONS_MQ);exit(1);

bcs_algorithm_solving(EQUATIONS_MQ);