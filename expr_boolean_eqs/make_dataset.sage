#!/usr/bin/env python
# -*- coding: utf-8 -*-

__ENV__  =  'sage-python3';
__author__ =  'hanss401';

from sage.misc.python import Python;

#  ---- Hack to import my own sage scripts; ----
def Import_Sage_File(module_name, func_name='*'):
    os.system('sage --preparse ' + module_name + '.sage');
    os.system('mv ' + module_name+'.sage.py ' + module_name.replace('../','')+'.py');
    python = Python();
    python.eval('from ' + module_name.replace('../','') + ' import ' + func_name, globals());

Import_Sage_File('../functions');

# ============== Making MQ-equations ==============
NUM_DATASET = 2;
NUM_VARS_USED = 12;
NUM_EQUATIONS = 12;
RHO = 0.8;

ITEMS_VARS_USED = ITEMS_BOOLEAN[0:NUM_VARS_USED];
for INDEX_i in range(NUM_DATASET):
    EQUATIONS_MQ,SOLV_MQ = make_mq_equations(NUM_VARS_USED,NUM_EQUATIONS,RHO);
    write_into_ppsh_format(EQUATIONS_MQ,ITEMS_VARS_USED,'n' + str(NUM_VARS_USED) + '_m' + str(NUM_EQUATIONS) + '_F' + str(INDEX_i));