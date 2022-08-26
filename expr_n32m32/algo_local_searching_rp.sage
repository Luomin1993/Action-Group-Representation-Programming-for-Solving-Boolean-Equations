#!/usr/bin/env python
# -*- coding: utf-8 -*-

__ENV__  =  'sage';
__author__ =  'hanss401';

import time;
from sage.misc.python import Python;

NUM_RAND_SEED = 50;

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

def computing_state_value(SOLUTION_PART,SOLV_MQ):
    for KEY in SOLUTION_PART.keys():
        if SOLV_MQ[KEY]!=SOLUTION_PART[KEY]:return 0.0;
    return 10.0;

class State_AGRP(object):
    def __init__(self, TIME_STEP):
        super(State_AGRP, self).__init__()
        self.TIME_STEP = TIME_STEP;
        self.SOLUTION  = {};
        self.IS_SAT    = False;

class Agent_AGRP(object):
    """Agent_AGRP: Solving Boolean Equations by AGR Programming"""
    def __init__(self, NAME):
        super(Agent_AGRP, self).__init__()
        self.NAME = NAME;
        self.VISITED_POINTS = [];
        self.STATE_OBSERVED = State_AGRP(0);
        self.ITEMS_VARS_USED = None;
        self.ITEMS_VARS_SUBS = None;
        self.ACTION = None;
        self.ACTION_VEC = None;
        self.ALL_SOLUTIONS = None;
        self.Q_VALUE_NOW = 0.0;
        self.SOLV_POINT_ALLX = [];self.SOLV_POINT_ALLY = [];
        self.EQUATIONS_MQ = None;
        # --- Models ---
        self.ITEMS_MQ_PART = None;
        self.MODEL_AGRP_VALUE_FIELD_RP = None;

    def Q_function(self,SOLUTION_PART,SOLUTION_PART_VEC):
        EQUATIONS_MQ_PART = [POLYNOMIAL.subs(SOLUTION_PART) for POLYNOMIAL in self.EQUATIONS_MQ];
        SOLUTION_PART_RAND,self.SOLV_POINT_ALLX = generating_random_solv(self.ITEMS_VARS_USED);
        self.SOLV_POINT_ALLY = [POLYNOMIAL.subs(SOLUTION_PART_RAND) for POLYNOMIAL in EQUATIONS_MQ_PART];
        Q_VALUE = self.MODEL_AGRP_VALUE_FIELD_RP.predict([ np.array([self.ACTION_VEC],dtype=float),np.array([ self.SOLV_POINT_ALLX ],dtype=float),np.array([ self.SOLV_POINT_ALLY ],dtype=float) ])[0];
        Q_VALUE = output_processing_cnn([ Q_VALUE ])[0];
        return Q_VALUE;

    def init_solution(self):
        self.ACTION,self.ACTION_VEC = generating_random_solv(self.ITEMS_VARS_SUBS);

    def Pi_function(self,EQUATIONS_MQ):
        if len(self.VISITED_POINTS) == 0:
            self.VISITED_POINTS.append(self.ACTION);
            return self.ACTION;
        for SERCHING_STEP in range(1,10):
            SOLUTION_PART = self.ALL_SOLUTIONS[ (self.ALL_SOLUTIONS.index(self.ACTION) + SERCHING_STEP)%len(self.ALL_SOLUTIONS) ];
            SOLUTION_PART_VEC = make_solution_vec(SOLUTION_PART);
            if self.Q_function(SOLUTION_PART,SOLUTION_PART_VEC)>self.Q_VALUE_NOW:break;
        if SOLUTION_PART in self.VISITED_POINTS:
            while SOLUTION_PART in self.VISITED_POINTS:
                SOLUTION_PART,SOLUTION_PART_VEC = generating_random_solv(self.ITEMS_VARS_SUBS);
        Q_VALUE = self.Q_function(SOLUTION_PART,SOLUTION_PART_VEC);
        self.ACTION = SOLUTION_PART;
        self.ACTION_VEC = SOLUTION_PART_VEC;
        self.Q_VALUE_NOW = Q_VALUE;
        self.VISITED_POINTS.append(self.ACTION);
        return self.ACTION;

    def observing_state(self,STATE):
        self.STATE_OBSERVED.TIME_STEP = STATE.TIME_STEP;
        self.SOLUTION  = self.ACTION;
        self.IS_SAT    = STATE.IS_SAT;
        
# ============================== Loading Models ===================================
from model_agrp_vf_rp import *;
MODEL_AGRP_VALUE_FIELD_RP.load_weights('MODEL_AGRP_VALUE_FIELD_RP_weights.h5');

# ============================== Agent Solving Boolean Equations Interactively ===================================
NUM_VARS_USED = 32;
NUM_EQUATIONS = 32;
NUM_VARS_SUBS =  8;
EQUATIONS_MQ = get_equations_from_fes_format_in('dataset/EQUATIONS_n32_m32_F3.in');

AGENT = Agent_AGRP("My_Agent");
AGENT.ITEMS_VARS_USED = ITEMS_BOOLEAN[NUM_VARS_SUBS:NUM_VARS_USED];AGENT.ITEMS_VARS_SUBS = ITEMS_BOOLEAN[0:NUM_VARS_SUBS];
AGENT.init_solution();
AGENT.ITEMS_MQ_PART = make_items_mq(AGENT.ITEMS_VARS_USED) + [1];
ENV_STATE = State_AGRP(0);
AGENT.MODEL_AGRP_VALUE_FIELD_RP = MODEL_AGRP_VALUE_FIELD_RP;
AGENT.ALL_SOLUTIONS = make_ndim_solutions(NUM_VARS_SUBS,AGENT.ITEMS_VARS_SUBS);
RUNNING_ROUND = 0;
AGENT.EQUATIONS_MQ = EQUATIONS_MQ;
TIME_START = time.time();
while ENV_STATE.IS_SAT==False:
    print(" ---- RUNNING_ROUND = " + str(RUNNING_ROUND) + " ---- ");
    AGENT.observing_state(ENV_STATE);
    SOLUTION_PART = AGENT.Pi_function(EQUATIONS_MQ);
    EQUATIONS_MQ_PART = [ POLYNOMIAL.subs(SOLUTION_PART) for POLYNOMIAL in EQUATIONS_MQ];
    libfes_solving(EQUATIONS_MQ_PART,AGENT.ITEMS_VARS_USED);
    ENV_STATE.IS_SAT = equations_solved_by_fes();
    RUNNING_ROUND+=1;
TIME_END = time.time();
print( 'Costing Time: '  + str(TIME_END - TIME_START));
print( 'Running Rounds: '  + str(RUNNING_ROUND));