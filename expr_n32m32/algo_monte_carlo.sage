#!/usr/bin/env python
# -*- coding: utf-8 -*-

__ENV__  =  'sage';
__author__ =  'hanss401';

import time;
from sage.misc.python import Python;

NUM_RAND_SEED = 128;

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
        self.COEFF_MAT_NOW = None;
        # --- Models ---
        self.SERCHING_STEP = 5;
        self.ITEMS_MQ_PART = None;
        self.MODEL_AGRP_VALUE_FIELD = None;
        self.COEFF_MATS_CNN_DICT = None;
        self.EQUATIONS_MQ_PART_DICT = None;
        self.MC_RPOB_DISTRIBUTION = None;

    def Q_function(self,SOLUTION_PART,SOLUTION_PART_VEC):
        Q_VALUE = self.MODEL_AGRP_VALUE_FIELD.predict([ np.array([self.COEFF_MATS_CNN_DICT[self.ALL_SOLUTIONS.index(SOLUTION_PART)]]), np.array([SOLUTION_PART_VEC],dtype=float) ])[0];
        Q_VALUE = output_processing_cnn([ Q_VALUE ])[0];
        return Q_VALUE;

    def init_solution(self):
        self.ACTION,self.ACTION_VEC = generating_random_solv(self.ITEMS_VARS_SUBS);
        self.MC_RPOB_DISTRIBUTION = [0]*(2**len(self.ITEMS_VARS_SUBS));

    def monte_carlo_sampling(self):
        for INDEX_j in range(len(ITEMS_BOOLEAN)*NUM_RAND_SEED):GAMMA = np.random.rand(1);
        self.MC_RPOB_DISTRIBUTION[ self.ALL_SOLUTIONS.index(self.ACTION) ] = self.Q_VALUE_NOW;

    def Pi_function(self,EQUATIONS_MQ):
        if len(self.VISITED_POINTS) == 0:
            self.VISITED_POINTS.append(self.ACTION);
            return self.ACTION;
        SOLUTION_PART = self.ALL_SOLUTIONS[ (self.MC_RPOB_DISTRIBUTION.index(max(self.MC_RPOB_DISTRIBUTION)) + np.random.randint(4))%len(self.ALL_SOLUTIONS) ];
        SOLUTION_PART_VEC = make_solution_vec(SOLUTION_PART);
        if self.SERCHING_STEP<0:self.SERCHING_STEP=1;
        if SOLUTION_PART in self.VISITED_POINTS:
            while SOLUTION_PART in self.VISITED_POINTS:
                SOLUTION_PART,SOLUTION_PART_VEC = generating_random_solv(self.ITEMS_VARS_SUBS);
        Q_VALUE = self.Q_function(SOLUTION_PART,SOLUTION_PART_VEC);
        self.ACTION = SOLUTION_PART;
        self.ACTION_VEC = SOLUTION_PART_VEC;
        self.Q_VALUE_NOW = Q_VALUE;
        self.monte_carlo_sampling();
        self.VISITED_POINTS.append(self.ACTION);
        return self.ACTION;

    def observing_state(self,STATE):
        self.STATE_OBSERVED.TIME_STEP = STATE.TIME_STEP;
        self.SOLUTION  = self.ACTION;
        self.IS_SAT    = STATE.IS_SAT;
        
# ============================== Loading Models ===================================
from model_agrp_vf import *;
MODEL_AGRP_VALUE_FIELD.load_weights('MODEL_AGRP_VALUE_FIELD_weights.h5');
from model_agrp_gr import *;
MODEL_AGRP_GR_MAT.load_weights('MODEL_AGRP_RHO_weights.h5');

# ============================== Agent Solving Boolean Equations Interactively ===================================
NUM_VARS_USED = 32;
NUM_EQUATIONS = 32;
NUM_VARS_SUBS =  8;
EQUATIONS_MQ = get_equations_from_fes_format_in('dataset/EQUATIONS_n32_m32_F2.in');

AGENT = Agent_AGRP("My_Agent");
AGENT.ITEMS_VARS_USED = ITEMS_BOOLEAN[NUM_VARS_SUBS:NUM_VARS_USED];AGENT.ITEMS_VARS_SUBS = ITEMS_BOOLEAN[0:NUM_VARS_SUBS];
AGENT.init_solution();
AGENT.ITEMS_MQ_PART = make_items_mq(AGENT.ITEMS_VARS_USED) + [1];
ENV_STATE = State_AGRP(0);
AGENT.MODEL_AGRP_VALUE_FIELD = MODEL_AGRP_VALUE_FIELD;
AGENT.ALL_SOLUTIONS = make_ndim_solutions(NUM_VARS_SUBS,AGENT.ITEMS_VARS_SUBS);
AGENT.COEFF_MATS_CNN_DICT,AGENT.EQUATIONS_MQ_PART_DICT = make_coeff_mats_dict(AGENT.ALL_SOLUTIONS,EQUATIONS_MQ,AGENT.ITEMS_MQ_PART);
RUNNING_ROUND = 0;
TIME_START = time.time();
while ENV_STATE.IS_SAT==False:
    print(" ---- RUNNING_ROUND = " + str(RUNNING_ROUND) + " ---- ");
    AGENT.observing_state(ENV_STATE);
    SOLUTION_PART = AGENT.Pi_function(EQUATIONS_MQ);
    EQUATIONS_MQ_PART = AGENT.EQUATIONS_MQ_PART_DICT[AGENT.ALL_SOLUTIONS.index(SOLUTION_PART)];
    AGENT.COEFF_MAT_NOW = AGENT.COEFF_MATS_CNN_DICT[AGENT.ALL_SOLUTIONS.index(SOLUTION_PART)];
    libfes_solving(EQUATIONS_MQ_PART,AGENT.ITEMS_VARS_USED);
    ENV_STATE.IS_SAT = equations_solved_by_fes();
    RUNNING_ROUND+=1;
TIME_END = time.time();
print( 'Costing Time: '  + str(TIME_END - TIME_START));
print( 'Running Rounds: '  + str(RUNNING_ROUND));