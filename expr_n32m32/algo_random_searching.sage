#!/usr/bin/env python
# -*- coding: utf-8 -*-

__ENV__  =  'sage';
__author__ =  'hanss401';

import time;
from sage.misc.python import Python;

NUM_RAND_SEED = 12;

#  ---- Hack to import my own sage scripts; ----
def Import_Sage_File(module_name, func_name='*'):
    os.system('sage --preparse ' + module_name + '.sage');
    os.system('mv ' + module_name+'.sage.py ' + module_name.replace('../','')+'.py');
    python = Python();
    python.eval('from ' + module_name.replace('../','') + ' import ' + func_name, globals());

Import_Sage_File('../functions');

def generating_random_real_solv(ITEMS_VARS_USED):
    SOLUTION_REAL = {};SOLUTION_REAL_VEC = [];
    for VARIABLE in ITEMS_VARS_USED:
        THIS_MONO_VALUE = np.random.rand()*10;
        SOLUTION_REAL[VARIABLE] = THIS_MONO_VALUE;
        SOLUTION_REAL_VEC.append(THIS_MONO_VALUE);
    return SOLUTION_REAL,SOLUTION_REAL_VEC;

def generating_random_solv(ITEMS_VARS_USED):
    SOLUTION = {};SOLUTION_VEC = [];
    for VARIABLE in ITEMS_VARS_USED:
        for INDEX_i in range(len(ITEMS_BOOLEAN)*NUM_RAND_SEED):THIS_MONO_VALUE = np.random.randint(2);
        SOLUTION[VARIABLE] = THIS_MONO_VALUE;
        SOLUTION_VEC.append(THIS_MONO_VALUE);
    return SOLUTION,SOLUTION_VEC;

def computing_state_value(SOLUTION_PART,SOLV_MQ):
    for KEY in SOLUTION_PART.keys():
        if SOLV_MQ[KEY]!=SOLUTION_PART[KEY]:return 0.0;
    return 10.0;

def make_solution_vec(SOLUTION_PART):
    SOLUTION_PART_VEC = [SOLUTION_PART[KEY] for KEY in SOLUTION_PART.keys()];
    return SOLUTION_PART_VEC;

class State_AGRP(object):
    def __init__(self, TIME_STEP):
        super(State_AGRP, self).__init__()
        self.TIME_STEP = TIME_STEP;
        self.SOLUTION  = {};
        self.IS_SAT    = False;

class Agent_STPS(object):
    """Agent_STPS: Solving Boolean Equations by AGR Programming"""
    def __init__(self, NAME):
        super(Agent_STPS, self).__init__()
        self.NAME = NAME;
        self.VISITED_POINTS = [];
        self.STATE_OBSERVED = State_AGRP(0);
        self.ITEMS_VARS_USED = None;
        self.ITEMS_VARS_SUBS = None;
        self.ACTION = None;
        self.ALL_SOLUTIONS = None;
        # --- Models ---
        self.SERCHING_STEP = 100;
        self.ITEMS_MQ_PART = None;

    def Q_function(self,ACTION):
        Q_VALUE = 0.0;
        return Q_VALUE;

    def init_solution(self):
        self.VISITED_POINTS.append({});

    def Pi_function_rand(self,EQUATIONS_MQ):
        SOLUTION_PART = {};
        while SOLUTION_PART in self.VISITED_POINTS:
            SOLUTION_PART,SOLUTION_PART_VEC = generating_random_solv(self.ITEMS_VARS_SUBS);
        self.ACTION = SOLUTION_PART;
        self.VISITED_POINTS.append(self.ACTION);
        return self.ACTION;

    def observing_state(self,STATE):
        self.STATE_OBSERVED.TIME_STEP = STATE.TIME_STEP;
        self.SOLUTION  = self.ACTION;
        self.IS_SAT    = STATE.IS_SAT;
        

# ============================== Agent Solving Boolean Equations Interactively ===================================
NUM_VARS_USED = 32;
NUM_EQUATIONS = 32;
NUM_VARS_SUBS =  8;
EQUATIONS_MQ = get_equations_from_fes_format_in('dataset/EQUATIONS_n32_m32_F7.in');

AGNET = Agent_STPS("My_Agent");AGNET.init_solution();
AGNET.ITEMS_VARS_USED = ITEMS_BOOLEAN[NUM_VARS_SUBS:NUM_VARS_USED];AGNET.ITEMS_VARS_SUBS = ITEMS_BOOLEAN[0:NUM_VARS_SUBS];
ENV_STATE = State_AGRP(0);
RUNNING_ROUND = 0;
TIME_START = time.time();
while ENV_STATE.IS_SAT==False:
    print(" ---- RUNNING_ROUND = " + str(RUNNING_ROUND) + " ---- ");
    AGNET.observing_state(ENV_STATE);
    SOLUTION_PART = AGNET.Pi_function_rand(EQUATIONS_MQ);
    EQUATIONS_MQ_PART = [POLYNOMIAL.subs(SOLUTION_PART) for POLYNOMIAL in EQUATIONS_MQ];
    libfes_solving(EQUATIONS_MQ_PART,AGNET.ITEMS_VARS_USED);
    ENV_STATE.IS_SAT = equations_solved_by_fes();
    RUNNING_ROUND+=1;
TIME_END = time.time();
print( 'Costing Time: '  + str(TIME_END - TIME_START));
print( 'Running Rounds: '  + str(RUNNING_ROUND));