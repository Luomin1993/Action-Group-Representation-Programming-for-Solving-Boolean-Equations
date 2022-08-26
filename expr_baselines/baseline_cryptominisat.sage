#!/usr/bin/env python
# -*- coding: utf-8 -*-

__ENV__  =  'sage';
__author__ =  'hanss401';

import os;
from sage.misc.python import Python;

from sage.sat.converters.polybori import CNFEncoder
from sage.sat.solvers.dimacs import DIMACS

os.system('cryptominisat5 --verb 0 3sat_n8.cnf');