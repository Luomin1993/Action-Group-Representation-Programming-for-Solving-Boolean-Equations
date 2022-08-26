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

def generating_random_solv(ITEMS_VARS_USED):
    SOLUTION = {};SOLUTION_VEC = [];
    for VARIABLE in ITEMS_VARS_USED:
        THIS_MONO_VALUE = np.random.randint(2);
        SOLUTION[VARIABLE] = THIS_MONO_VALUE;
        SOLUTION_VEC.append(THIS_MONO_VALUE);
    return SOLUTION,SOLUTION_VEC;

# ============== Making MQ-equations ==============
NUM_DATASET = 2;
NUM_VARS_USED = 40;
NUM_EQUATIONS = 40;

# ITEMS_VARS_USED = ITEMS_BOOLEAN[0:NUM_VARS_USED];
# for INDEX_i in range(NUM_DATASET):
#     EQUATIONS_MQ,SOLV_MQ = make_mq_equations(NUM_VARS_USED,NUM_EQUATIONS,0.2);
#     write_into_libfes_format(EQUATIONS_MQ,ITEMS_VARS_USED,'n' + str(NUM_VARS_USED) + '_m' + str(NUM_EQUATIONS) + '_F' + str(INDEX_i));
# exit(1);
# ============== Testing LibFES ==============
# EQUATIONS_MQ,SOLV_MQ = make_mq_equations(NUM_VARS_USED,NUM_EQUATIONS);
# EQUATIONS_MQ[0]=EQUATIONS_MQ[0]+1;EQUATIONS_MQ[1]=EQUATIONS_MQ[1]+1;
# libfes_solving(EQUATIONS_MQ,ITEMS_VARS_USED);
# print(equations_solved_by_fes());

# ============== Training Dataset for MODEL_AGRP_VALUE_FIELD with COEFF_MAT ==============
# DIM_SUBS = 8;DIM_ALL = NUM_VARS_USED;NUM_DATASET = 100;
# ITEMS_VARS_USED = ITEMS_BOOLEAN[0:DIM_SUBS];
# ITEMS_MQ_PART = make_items_mq(ITEMS_BOOLEAN[DIM_SUBS:DIM_ALL]) + [1];
# ALL_SOLUTIONS = make_ndim_solutions(DIM_SUBS,ITEMS_VARS_USED);
# DICT_VALUE = []; # ..., ( SOLV_POINT, COEFF_MAT, VALUE), ...;
# for INDEX_i in range(NUM_DATASET):
#     print("DATA writed into DAT_COEFF_MAT_VALUE_FIELD --- " + str(INDEX_i) + " --- " + str(float(INDEX_i)/NUM_DATASET) );
#     EQUATIONS_MQ,SOLV_MQ_ALL = make_mq_equations(DIM_ALL,DIM_ALL,0.2);SOLV_MQ = {};
#     for VARIABLE in ITEMS_VARS_USED:SOLV_MQ[VARIABLE] = SOLV_MQ_ALL[VARIABLE];
#     # --- Dense Sampling --- 
#     INDEX_j = ALL_SOLUTIONS.index(SOLV_MQ) - 10;
#     if INDEX_j<0:INDEX_j = 0;
#     while abs(INDEX_j-ALL_SOLUTIONS.index(SOLV_MQ))<12:
#         if INDEX_j>=len(ALL_SOLUTIONS):break;
#         SOLV_POINT = ALL_SOLUTIONS[INDEX_j];INDEX_j+=1;
#         COEFF_MAT = compute_coeff_mat(EQUATIONS_MQ,SOLV_POINT,ITEMS_MQ_PART);
#         VALUE     = compute_field_value(SOLV_POINT,SOLV_MQ,ALL_SOLUTIONS);
#         DICT_VALUE.append(( SOLV_POINT, COEFF_MAT, VALUE ));
# write_into_field_value(DICT_VALUE);

# ============== Training Dataset for MODEL_AGRP_VALUE_FIELD with SPECIAL POINTS ==============
DIM_SUBS = 8;DIM_ALL = NUM_VARS_USED;NUM_DATASET = 400;
ITEMS_VARS_USED = ITEMS_BOOLEAN[0:DIM_SUBS];
SOLV_POINT_ALL0 = {};SOLV_POINT_ALL1 = {};
for VARIABLE in ITEMS_BOOLEAN[DIM_SUBS:DIM_ALL]:SOLV_POINT_ALL0[VARIABLE] = 0;
for VARIABLE in ITEMS_BOOLEAN[DIM_SUBS:DIM_ALL]:SOLV_POINT_ALL1[VARIABLE] = 1;
ITEMS_MQ_PART = make_items_mq(ITEMS_BOOLEAN[DIM_SUBS:DIM_ALL]) + [1];
ALL_SOLUTIONS = make_ndim_solutions(DIM_SUBS,ITEMS_VARS_USED);
DICT_VALUE = []; # ..., ( SOLV_POINT, COEFF_MAT, VALUE), ...;
for INDEX_i in range(NUM_DATASET):
    print("DATA writed into DAT_COEFF_MAT_VALUE_FIELD --- " + str(INDEX_i) + " --- " + str(float(INDEX_i)/NUM_DATASET) );
    EQUATIONS_MQ,SOLV_MQ_ALL = make_mq_equations(DIM_ALL,DIM_ALL,0.2);SOLV_MQ = {};
    for VARIABLE in ITEMS_VARS_USED:SOLV_MQ[VARIABLE] = SOLV_MQ_ALL[VARIABLE];
    # --- Dense Sampling --- 
    INDEX_j = ALL_SOLUTIONS.index(SOLV_MQ) - 10;
    if INDEX_j<0:INDEX_j = 0;
    while abs(INDEX_j-ALL_SOLUTIONS.index(SOLV_MQ))<12:
        if INDEX_j>=len(ALL_SOLUTIONS):break;
        SOLV_POINT = ALL_SOLUTIONS[INDEX_j];INDEX_j+=1;
        SP01_POINTS = compute_special_points(EQUATIONS_MQ,SOLV_POINT,SOLV_POINT_ALL0,SOLV_POINT_ALL1);
        VALUE     = compute_field_value(SOLV_POINT,SOLV_MQ,ALL_SOLUTIONS);
        DICT_VALUE.append(( SOLV_POINT, SP01_POINTS, VALUE ));
write_into_field_value_sp(DICT_VALUE);

# ============== Training Dataset for MODEL_AGRP_VALUE_FIELD with RAND POINTS ==============
# DIM_SUBS = 8;DIM_ALL = 32;NUM_DATASET = 100;
# ITEMS_VARS_USED = ITEMS_BOOLEAN[0:DIM_SUBS];
# SOLV_POINT_ALL0 = {};SOLV_POINT_ALL1 = {};
# for VARIABLE in ITEMS_BOOLEAN[DIM_SUBS:DIM_ALL]:SOLV_POINT_ALL0[VARIABLE] = 0;
# ALL_SOLUTIONS = make_ndim_solutions(DIM_SUBS,ITEMS_VARS_USED);
# DICT_VALUE = []; # ..., ( SOLV_POINT, COEFF_MAT, VALUE), ...;
# for INDEX_i in range(NUM_DATASET):
#     print("DATA writed into DAT_RP_POINTS_VALUE_FIELD --- " + str(INDEX_i) + " --- " + str(float(INDEX_i)/NUM_DATASET) );
#     EQUATIONS_MQ,SOLV_MQ_ALL = make_mq_equations(DIM_ALL,DIM_ALL);SOLV_MQ = {};
#     for VARIABLE in ITEMS_VARS_USED:SOLV_MQ[VARIABLE] = SOLV_MQ_ALL[VARIABLE];
#     # --- Dense Sampling --- 
#     INDEX_j = ALL_SOLUTIONS.index(SOLV_MQ) - 10;
#     if INDEX_j<0:INDEX_j = 0;
#     while abs(INDEX_j-ALL_SOLUTIONS.index(SOLV_MQ))<12:
#         if INDEX_j>=len(ALL_SOLUTIONS):break;
#         SOLV_POINT = ALL_SOLUTIONS[INDEX_j];INDEX_j+=1;
#         RP01_POINTS = [0]*2;
#         SOLV_POINT_RAND,RP01_POINTS[0] = generating_random_solv(ITEMS_BOOLEAN[DIM_SUBS:DIM_ALL]);
#         EQUATIONS_MQ_PART = [POLYNOMIAL.subs(SOLV_POINT) for POLYNOMIAL in EQUATIONS_MQ];
#         RP01_POINTS[1] = [POLYNOMIAL.subs(SOLV_POINT_RAND) for POLYNOMIAL in EQUATIONS_MQ_PART];
#         VALUE     = compute_field_value(SOLV_POINT,SOLV_MQ,ALL_SOLUTIONS);
#         DICT_VALUE.append(( SOLV_POINT, RP01_POINTS, VALUE ));
# write_into_field_value_rp(DICT_VALUE);

# ============== Training Dataset for Rand-Model f(v|X) ==============
# DAT_RAND_X = [];DAT_RAND_Y = [];
# for INDEX_i in range(10000):
#     print(" --- Make Dataset " + str(INDEX_i/10000.0) + " --- ");
#     DAT_RAND_X.append(np.random.randint(2,size=16));
#     DAT_RAND_Y.append([(np.random.randint(100)%10)/10.0]);
# np.save("DAT_RAND/DAT_RAND_X",np.array(DAT_RAND_X,dtype=float));
# np.save("DAT_RAND/DAT_RAND_Y",np.array(DAT_RAND_Y,dtype=float));