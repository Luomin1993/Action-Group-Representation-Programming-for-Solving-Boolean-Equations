#!/usr/bin/env python
# -*- coding: utf-8 -*-

__ENV__  =  'sage-python3';
__author__ =  'hanss401';

import numpy as np;
import math;
import matplotlib.pyplot as plt;
import sys;
from pysat.solvers import Minisat22;
from pysat.formula import CNF;

CNF_INSTANCE = CNF(from_file="3sat_n8.cnf");
CLAUSES_3SAT = CNF_INSTANCE.clauses;

SOLVER = Minisat22();
for CLAUSE in CLAUSES_3SAT:SOLVER.add_clause(CLAUSE);
print(SOLVER.solve());
print(SOLVER.get_model());