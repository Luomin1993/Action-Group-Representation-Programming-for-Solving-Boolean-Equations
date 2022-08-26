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
		
# ============================== STEP 1:reading and handling mq dataset ===================================
MAX_USED_VARS = 8;
MAX_NUM_EQ = 8;
SAVED_PATH = "dataset/EQUATIONS_n" + str(MAX_USED_VARS) + "_m" + str(MAX_NUM_EQ) + "_F0.in";

EQUATIONS_MQ = get_equations_from_fes_format_in(SAVED_PATH);
#print_equations(EQUATIONS_MQ);exit(1);

ITEMS_VARS_USED = ITEMS_BOOLEAN[0:MAX_USED_VARS];
CHARASTIC_SETS = {};
for VAR_ELIMINATED in ITEMS_VARS_USED:CHARASTIC_SETS[VAR_ELIMINATED] = [];
CHARASTIC_SETS[ITEMS_VARS_USED[0]] = EQUATIONS_MQ;
CHARSET_NUM_RECORD = {};
for VAR_ELIMINATED in ITEMS_VARS_USED:CHARSET_NUM_RECORD[VAR_ELIMINATED] = [];
VAR_ELIMINATED = ITEMS_VARS_USED[0];
RUNNING_TIMES = 0;
RUNNING_TIMES_VIS = 0;NEED_TO_BACKT = False;
STOPPING_TIMES = 0;
RUNNED_COMPUTINGS = [];
VISITED_POINTS = [];
VAR_ELIMINATED_START = ITEMS_VARS_USED[0];
CHARSET_NUM_RECORD[VAR_ELIMINATED_START].append( len(CHARASTIC_SETS[ITEMS_VARS_USED[0]]) );
while VAR_ELIMINATED != ITEMS_VARS_USED[-1]:
    print(' ============  '+ str(VAR_ELIMINATED) +'  ================= ');
    INDEX_VAR = ITEMS_VARS_USED.index(VAR_ELIMINATED);
    print('R_m = '+str(len(CHARASTIC_SETS[VAR_ELIMINATED])));
    print('R_m+1 = '+str(len(CHARASTIC_SETS[ITEMS_VARS_USED[INDEX_VAR+1]])));
    if RUNNING_TIMES>50000:break;
    # --- checking stopping ---
    VAR_ELIMINATED_NEXT = ITEMS_VARS_USED[ ITEMS_VARS_USED.index(VAR_ELIMINATED_START)+1 ];
    if len(CHARSET_NUM_RECORD[VAR_ELIMINATED_NEXT])>2000:
        if CHARSET_NUM_RECORD[VAR_ELIMINATED_NEXT][-2000] == len(CHARASTIC_SETS[VAR_ELIMINATED_NEXT]):
           VAR_ELIMINATED_START = ITEMS_VARS_USED[ ITEMS_VARS_USED.index(VAR_ELIMINATED_START) +1];
           VAR_ELIMINATED = VAR_ELIMINATED_START;continue;
    if len(CHARASTIC_SETS[VAR_ELIMINATED])<2:
        VAR_ELIMINATED = VAR_ELIMINATED_START;continue; # back-tracing;
    if len(CHARASTIC_SETS[ITEMS_VARS_USED[-4]])>200 and (ITEMS_VARS_USED.index(VAR_ELIMINATED_START) < ITEMS_VARS_USED.index(ITEMS_VARS_USED[-5])):
        VAR_ELIMINATED_START = ITEMS_VARS_USED[-5];
        VAR_ELIMINATED = VAR_ELIMINATED_START;continue;
    # --- choosing polynomials ---
    if VAR_ELIMINATED==VAR_ELIMINATED_START:POLYNOMIAL_WUBAS = CHARASTIC_SETS[VAR_ELIMINATED][ np.random.randint( len(CHARASTIC_SETS[VAR_ELIMINATED]) ) ];
    POLYNOMIAL_DIV   = CHARASTIC_SETS[VAR_ELIMINATED][ np.random.randint( len(CHARASTIC_SETS[VAR_ELIMINATED]) ) ];
    while POLYNOMIAL_DIV == POLYNOMIAL_WUBAS:POLYNOMIAL_DIV = CHARASTIC_SETS[VAR_ELIMINATED][ np.random.randint( len(CHARASTIC_SETS[VAR_ELIMINATED]) ) ];
    INDEX_i = CHARASTIC_SETS[VAR_ELIMINATED].index(POLYNOMIAL_WUBAS);INDEX_j = CHARASTIC_SETS[VAR_ELIMINATED].index(POLYNOMIAL_DIV);
    while (VAR_ELIMINATED,(INDEX_i,INDEX_j)) in VISITED_POINTS:
        if VAR_ELIMINATED==VAR_ELIMINATED_START:POLYNOMIAL_WUBAS = CHARASTIC_SETS[VAR_ELIMINATED][ np.random.randint( len(CHARASTIC_SETS[VAR_ELIMINATED]) ) ];
        POLYNOMIAL_DIV   = CHARASTIC_SETS[VAR_ELIMINATED][ np.random.randint( len(CHARASTIC_SETS[VAR_ELIMINATED]) ) ];
        while POLYNOMIAL_DIV == POLYNOMIAL_WUBAS:POLYNOMIAL_DIV = CHARASTIC_SETS[VAR_ELIMINATED][ np.random.randint( len(CHARASTIC_SETS[VAR_ELIMINATED]) ) ];
        INDEX_i = CHARASTIC_SETS[VAR_ELIMINATED].index(POLYNOMIAL_WUBAS);INDEX_j = CHARASTIC_SETS[VAR_ELIMINATED].index(POLYNOMIAL_DIV);
        RUNNING_TIMES_VIS+=1;
        if RUNNING_TIMES_VIS>2000:
            NEED_TO_BACKT = True;RUNNING_TIMES_VIS=0;break;
    if NEED_TO_BACKT:
        NEED_TO_BACKT = False;
        VAR_ELIMINATED_START = ITEMS_VARS_USED[ ITEMS_VARS_USED.index(VAR_ELIMINATED_START) +1];
        VAR_ELIMINATED = VAR_ELIMINATED_START;continue;        
    CHARSET_NUM_RECORD[ITEMS_VARS_USED[INDEX_VAR+1]].append( len(CHARASTIC_SETS[ITEMS_VARS_USED[INDEX_VAR+1]]) );
    VISITED_POINTS.append( (VAR_ELIMINATED,(INDEX_i,INDEX_j)) );
    # ======= Doing reduction on x_n =======
    POLYNOMIAL_QUO,POLYNOMIAL_REM = pseudo_division(POLYNOMIAL_WUBAS,POLYNOMIAL_DIV,VAR_ELIMINATED);
    if POLYNOMIAL_REM==0 or (POLYNOMIAL_REM in CHARASTIC_SETS[ITEMS_VARS_USED[INDEX_VAR+1]]):
        VAR_ELIMINATED = VAR_ELIMINATED_START;continue; # back-tracing;
    CHARASTIC_SETS[ITEMS_VARS_USED[INDEX_VAR+1]].append(POLYNOMIAL_REM);
    VAR_ELIMINATED = ITEMS_VARS_USED[INDEX_VAR+1];
    POLYNOMIAL_WUBAS = POLYNOMIAL_REM;
    RUNNING_TIMES+=1;print('Running --- '+str(RUNNING_TIMES));
    if VAR_ELIMINATED==ITEMS_VARS_USED[-1]:print(POLYNOMIAL_REM);

print(CHARASTIC_SETS[VAR_ELIMINATED]);
"""
1485.6s
 ============  t3  ================= 
R_m = 4887
R_m+1 = 9233
Running --- 14477
 ============  t4  ================= 
R_m = 9234
R_m+1 = 223
 ============  t3  ================= 
R_m = 4887
R_m+1 = 9234
Running --- 14478
 ============  t4  ================= 
R_m = 9235
R_m+1 = 223
 ============  t3  ================= 
R_m = 4887
R_m+1 = 9235
... ...
"""    