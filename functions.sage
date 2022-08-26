#!/usr/bin/env python
# -*- coding: utf-8 -*-

__ENV__  =  'sage-python3';
__author__ =  'hanss401';

import os;
import numpy as np;
import sys;

# ============ VARIABLES ==============
BOOLEAN_RING.<x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31,x32,x33,x34,x35,x36,x37,x38,x39,x40,x41,x42,x43,x44,x45,x46,x47,x48,x49,x50,x51,x52,x53,x54,x55,x56,x57,x58,x59,x60,x61,x62,x63,x64,x65,x66,x67,x68,x69,x70,x71,x72,x73,x74,x75,x76,x77,x78,x79,x80,x81,x82,x83,x84,x85,x86,x87,x88,x89,x90,x91,x92,x93,x94,x95,x96,x97,x98,x99,x100,x101,x102,x103,x104,x105,x106,x107,x108,x109,x110,x111,x112,x113,x114,x115,x116,x117,x118,x119,x120,x121,x122,x123,x124,x125,x126,x127,x128,x129,x130,x131,x132,x133,x134,x135,x136,x137,x138,x139,x140,x141,x142,x143,x144,x145,x146,x147,x148,x149,x150,x151,x152,x153,x154,x155,x156,x157,x158,x159,x160,x161,x162,x163,x164,x165,x166,x167,x168,x169,x170,x171,x172,x173,x174,x175,x176,x177,x178,x179,x180,x181,x182,x183,x184,x185,x186,x187,x188,x189,x190,x191,x192,x193,x194,x195,x196,x197,x198,x199,x200,x201,x202,x203,x204,x205,x206,x207,x208,x209,x210,x211,x212,x213,x214,x215,x216,x217,x218,x219,x220,x221,x222,x223,x224,x225,x226,x227,x228,x229,x230,x231,x232,x233,x234,x235,x236,x237,x238,x239,x240,x241,x242,x243,x244,x245,x246,x247,x248,x249,x250,x251,x252,x253,x254,x255,x256,x257,x258,x259,x260,x261,x262,x263,x264,x265,x266,x267,x268,x269,x270,x271,x272,x273,x274,x275,x276,x277,x278,x279,x280,x281,x282,x283,x284,x285,x286,x287,x288,x289,x290,x291,x292,x293,x294,x295,x296,x297,x298,x299,x300,x301,x302,x303,x304,x305,x306,x307,x308,x309,x310,x311,x312,x313,x314,x315,x316,x317,x318,x319,x320,x321,x322,x323,x324,x325,x326,x327,x328,x329,x330,x331,x332,x333,x334,x335,x336,x337,x338,x339,x340,x341,x342,x343,x344,x345,x346,x347,x348,x349,x350,x351,x352,x353,x354,x355,x356,x357,x358,x359,x360,x361,x362,x363,x364,x365,x366,x367,x368,x369,x370,x371,x372,x373,x374,x375,x376,x377,x378,x379,x380,x381,x382,x383,x384,x385,x386,x387,x388,x389,x390,x391,x392,x393,x394,x395,x396,x397,x398,x399,x400,x401,x402,x403,x404,x405,x406,x407,x408,x409,x410,x411,x412,x413,x414,x415,x416,x417,x418,x419,x420,x421,x422,x423,x424,x425,x426,x427,x428,x429,x430,x431,x432,x433,x434,x435,x436,x437,x438,x439,x440,x441,x442,x443,x444,x445,x446,x447,x448,x449,x450,x451,x452,x453,x454,x455,x456,x457,x458,x459,x460,x461,x462,x463,x464,x465,x466,x467,x468,x469,x470,x471,x472,x473,x474,x475,x476,x477,x478,x479,x480,x481,x482,x483,x484,x485,x486,x487,x488,x489,x490,x491,x492,x493,x494,x495,x496,x497,x498,x499,x500,x501,x502,x503,x504,x505,x506,x507,x508,x509,x510,x511,x512,x513,x514,x515,x516,x517,x518,x519,x520,x521,x522,x523,x524,x525,x526,x527,x528,x529,x530,x531,x532,x533,x534,x535,x536,x537,x538,x539,x540,x541,x542,x543,x544,x545,x546,x547,x548,x549,x550,x551,x552,x553,x554,x555,x556,x557,x558,x559,x560,x561,x562,x563,x564,x565,x566,x567,x568,x569,x570,x571,x572,x573,x574,x575,x576,x577,x578,x579,x580,x581,x582,x583,x584,x585,x586,x587,x588,x589,x590,x591,x592,x593,x594,x595,x596,x597,x598,x599,x600,x601,x602,x603,x604,x605,x606,x607,x608,x609,x610,x611,x612,x613,x614,x615,x616,x617,x618,x619,x620,x621,x622,x623,x624,x625,x626,x627,x628,x629,x630,x631,x632,x633,x634,x635,x636,x637,x638,x639,x640,x641,x642,x643,x644,x645,x646,x647,x648,x649,x650,x651,x652,x653,x654,x655,x656,x657,x658,x659,x660,x661,x662,x663,x664,x665,x666,x667,x668,x669,x670,x671,x672,x673,x674,x675,x676,x677,x678,x679,x680,x681,x682,x683,x684,x685,x686,x687,x688,x689,x690,x691,x692,x693,x694,x695,x696,x697,x698,x699,x700,x701,x702,x703,x704,x705,x706,x707,x708,x709,x710,x711,x712,x713,x714,x715,x716,x717,x718,x719,x720,x721,x722,x723,x724,x725,x726,x727,x728,x729,x730,x731,x732,x733,x734,x735,x736,x737,x738,x739,x740,x741,x742,x743,x744,x745,x746,x747,x748,x749,x750,x751,x752,x753,x754,x755,x756,x757,x758,x759,x760,x761,x762,x763,x764,x765,x766,x767,x768,x769,x770,x771,x772,x773,x774,x775,x776,x777,x778,x779,x780,x781,x782,x783,x784,x785,x786,x787,x788,x789,x790,x791,x792,x793,x794,x795,x796,x797,x798,x799,x800,x801,x802,x803,x804,x805,x806,x807,x808,x809,x810,x811,x812,x813,x814,x815,x816,x817,x818,x819,x820,x821,x822,x823,x824,x825,x826,x827,x828,x829,x830,x831,x832,x833,x834,x835,x836,x837,x838,x839,x840,x841,x842,x843,x844,x845,x846,x847,x848,x849,x850,x851,x852,x853,x854,x855,x856,x857,x858,x859,x860,x861,x862,x863,x864,x865,x866,x867,x868,x869,x870,x871,x872,x873,x874,x875,x876,x877,x878,x879,x880,x881,x882,x883,x884,x885,x886,x887,x888,x889,x890,x891,x892,x893,x894,x895,x896,x897,x898,x899,x900,x901,x902,x903,x904,x905,x906,x907,x908,x909,x910,x911,x912,x913,x914,x915,x916,x917,x918,x919,x920,x921,x922,x923,x924,x925,x926,x927,x928,x929,x930,x931,x932,x933,x934,x935,x936,x937,x938,x939,x940,x941,x942,x943,x944,x945,x946,x947,x948,x949,x950,x951,x952,x953,x954,x955,x956,x957,x958,x959,x960,x961,x962,x963,x964,x965,x966,x967,x968,x969,x970,x971,x972,x973,x974,x975,x976,x977,x978,x979,x980,x981,x982,x983,x984,x985,x986,x987,x988,x989,x990,x991,x992,x993,x994,x995,x996,x997,x998,x999,x1000> = BooleanPolynomialRing();
ITEMS_BOOLEAN = [x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31,x32,x33,x34,x35,x36,x37,x38,x39,x40,x41,x42,x43,x44,x45,x46,x47,x48,x49,x50,x51,x52,x53,x54,x55,x56,x57,x58,x59,x60,x61,x62,x63,x64,x65,x66,x67,x68,x69,x70,x71,x72,x73,x74,x75,x76,x77,x78,x79,x80,x81,x82,x83,x84,x85,x86,x87,x88,x89,x90,x91,x92,x93,x94,x95,x96,x97,x98,x99,x100,x101,x102,x103,x104,x105,x106,x107,x108,x109,x110,x111,x112,x113,x114,x115,x116,x117,x118,x119,x120,x121,x122,x123,x124,x125,x126,x127,x128,x129,x130,x131,x132,x133,x134,x135,x136,x137,x138,x139,x140,x141,x142,x143,x144,x145,x146,x147,x148,x149,x150,x151,x152,x153,x154,x155,x156,x157,x158,x159,x160,x161,x162,x163,x164,x165,x166,x167,x168,x169,x170,x171,x172,x173,x174,x175,x176,x177,x178,x179,x180,x181,x182,x183,x184,x185,x186,x187,x188,x189,x190,x191,x192,x193,x194,x195,x196,x197,x198,x199,x200,x201,x202,x203,x204,x205,x206,x207,x208,x209,x210,x211,x212,x213,x214,x215,x216,x217,x218,x219,x220,x221,x222,x223,x224,x225,x226,x227,x228,x229,x230,x231,x232,x233,x234,x235,x236,x237,x238,x239,x240,x241,x242,x243,x244,x245,x246,x247,x248,x249,x250,x251,x252,x253,x254,x255,x256,x257,x258,x259,x260,x261,x262,x263,x264,x265,x266,x267,x268,x269,x270,x271,x272,x273,x274,x275,x276,x277,x278,x279,x280,x281,x282,x283,x284,x285,x286,x287,x288,x289,x290,x291,x292,x293,x294,x295,x296,x297,x298,x299,x300,x301,x302,x303,x304,x305,x306,x307,x308,x309,x310,x311,x312,x313,x314,x315,x316,x317,x318,x319,x320,x321,x322,x323,x324,x325,x326,x327,x328,x329,x330,x331,x332,x333,x334,x335,x336,x337,x338,x339,x340,x341,x342,x343,x344,x345,x346,x347,x348,x349,x350,x351,x352,x353,x354,x355,x356,x357,x358,x359,x360,x361,x362,x363,x364,x365,x366,x367,x368,x369,x370,x371,x372,x373,x374,x375,x376,x377,x378,x379,x380,x381,x382,x383,x384,x385,x386,x387,x388,x389,x390,x391,x392,x393,x394,x395,x396,x397,x398,x399,x400,x401,x402,x403,x404,x405,x406,x407,x408,x409,x410,x411,x412,x413,x414,x415,x416,x417,x418,x419,x420,x421,x422,x423,x424,x425,x426,x427,x428,x429,x430,x431,x432,x433,x434,x435,x436,x437,x438,x439,x440,x441,x442,x443,x444,x445,x446,x447,x448,x449,x450,x451,x452,x453,x454,x455,x456,x457,x458,x459,x460,x461,x462,x463,x464,x465,x466,x467,x468,x469,x470,x471,x472,x473,x474,x475,x476,x477,x478,x479,x480,x481,x482,x483,x484,x485,x486,x487,x488,x489,x490,x491,x492,x493,x494,x495,x496,x497,x498,x499,x500,x501,x502,x503,x504,x505,x506,x507,x508,x509,x510,x511,x512,x513,x514,x515,x516,x517,x518,x519,x520,x521,x522,x523,x524,x525,x526,x527,x528,x529,x530,x531,x532,x533,x534,x535,x536,x537,x538,x539,x540,x541,x542,x543,x544,x545,x546,x547,x548,x549,x550,x551,x552,x553,x554,x555,x556,x557,x558,x559,x560,x561,x562,x563,x564,x565,x566,x567,x568,x569,x570,x571,x572,x573,x574,x575,x576,x577,x578,x579,x580,x581,x582,x583,x584,x585,x586,x587,x588,x589,x590,x591,x592,x593,x594,x595,x596,x597,x598,x599,x600,x601,x602,x603,x604,x605,x606,x607,x608,x609,x610,x611,x612,x613,x614,x615,x616,x617,x618,x619,x620,x621,x622,x623,x624,x625,x626,x627,x628,x629,x630,x631,x632,x633,x634,x635,x636,x637,x638,x639,x640,x641,x642,x643,x644,x645,x646,x647,x648,x649,x650,x651,x652,x653,x654,x655,x656,x657,x658,x659,x660,x661,x662,x663,x664,x665,x666,x667,x668,x669,x670,x671,x672,x673,x674,x675,x676,x677,x678,x679,x680,x681,x682,x683,x684,x685,x686,x687,x688,x689,x690,x691,x692,x693,x694,x695,x696,x697,x698,x699,x700,x701,x702,x703,x704,x705,x706,x707,x708,x709,x710,x711,x712,x713,x714,x715,x716,x717,x718,x719,x720,x721,x722,x723,x724,x725,x726,x727,x728,x729,x730,x731,x732,x733,x734,x735,x736,x737,x738,x739,x740,x741,x742,x743,x744,x745,x746,x747,x748,x749,x750,x751,x752,x753,x754,x755,x756,x757,x758,x759,x760,x761,x762,x763,x764,x765,x766,x767,x768,x769,x770,x771,x772,x773,x774,x775,x776,x777,x778,x779,x780,x781,x782,x783,x784,x785,x786,x787,x788,x789,x790,x791,x792,x793,x794,x795,x796,x797,x798,x799,x800,x801,x802,x803,x804,x805,x806,x807,x808,x809,x810,x811,x812,x813,x814,x815,x816,x817,x818,x819,x820,x821,x822,x823,x824,x825,x826,x827,x828,x829,x830,x831,x832,x833,x834,x835,x836,x837,x838,x839,x840,x841,x842,x843,x844,x845,x846,x847,x848,x849,x850,x851,x852,x853,x854,x855,x856,x857,x858,x859,x860,x861,x862,x863,x864,x865,x866,x867,x868,x869,x870,x871,x872,x873,x874,x875,x876,x877,x878,x879,x880,x881,x882,x883,x884,x885,x886,x887,x888,x889,x890,x891,x892,x893,x894,x895,x896,x897,x898,x899,x900,x901,x902,x903,x904,x905,x906,x907,x908,x909,x910,x911,x912,x913,x914,x915,x916,x917,x918,x919,x920,x921,x922,x923,x924,x925,x926,x927,x928,x929,x930,x931,x932,x933,x934,x935,x936,x937,x938,x939,x940,x941,x942,x943,x944,x945,x946,x947,x948,x949,x950,x951,x952,x953,x954,x955,x956,x957,x958,x959,x960,x961,x962,x963,x964,x965,x966,x967,x968,x969,x970,x971,x972,x973,x974,x975,x976,x977,x978,x979,x980,x981,x982,x983,x984,x985,x986,x987,x988,x989,x990,x991,x992,x993,x994,x995,x996,x997,x998,x999,x1000];

# ============ FUNCTIONS ==============
def print_equations(EQUATIONS,NAME='EQUATIONS'):
    print('---------------- '+NAME+' ------------------------------');
    for line in EQUATIONS:
        print(line);

def mq_2_coeff_file(EQUATIONS,ITEMS,SOLV_MQ,FILE_NAME):
    SAVED_PATH = FILE_NAME.split('/')[0];
    os.system("sudo rm -rf " + SAVED_PATH);
    os.system("sudo mkdir " + SAVED_PATH);
    COEFFS,VALI_ITEMS_COMPLETE = eq_2_co(EQUATIONS,ITEMS);
    with open(FILE_NAME,'w') as FILEOUT:
        for COEFF in COEFFS:
            FILEOUT.write(str(COEFF).replace('[','').replace(']','').replace(',','').replace('SymmetricModularIntegerMod2(1)','1').replace('SymmetricModularIntegerMod2(0)','0'));
            FILEOUT.write('\n');
    SOLV_MQ_LIST = [SOLV_MQ[KEY] for KEY in SOLV_MQ.keys()];
    with open(FILE_NAME.replace("coeff","solv"),'w') as FILEOUT:
        FILEOUT.write(str(SOLV_MQ_LIST).replace('[','').replace(']','').replace(',','').replace('SymmetricModularIntegerMod2(0)','0'));

def is_factor(MONOMIAL_FAC,MONOMIAL):
    return (MONOMIAL).gcd(MONOMIAL_FAC) == MONOMIAL_FAC;

def monomials_of_poly(POLYNOMIAL):
    if POLYNOMIAL==0:return [0];
    MONOMIALS = [MONOMIAL for MONOMIAL in list(POLYNOMIAL)];
    return MONOMIALS;

def str_is_number(STRING):
    try:
        float(STRING);return True;
    except ValueError:
        pass;
    return False;    

def eq_2_co_boolean(EQUATIONS_MQ,ITEMS_MQ):
    COEFF_MAT = [];
    for POLYNOMIAL in EQUATIONS_MQ:
        MONOMIALS = monomials_of_poly(POLYNOMIAL);
        COEFF = [0]*len(ITEMS_MQ);
        for INDEX_i in range(len(ITEMS_MQ)):
            if ITEMS_MQ[INDEX_i] in MONOMIALS:COEFF[INDEX_i]=1;
        if MONOMIALS[-1]+1==0:COEFF[INDEX_i]=1;
        COEFF_MAT.append(COEFF);
    return COEFF_MAT;

def eq_2_co_boolean_CNN(EQUATIONS_MQ,ITEMS_MQ):
    COEFF_MAT = [];
    for POLYNOMIAL in EQUATIONS_MQ:
        MONOMIALS = monomials_of_poly(POLYNOMIAL);
        COEFF = [0]*len(ITEMS_MQ);
        for INDEX_i in range(len(ITEMS_MQ)):
            if ITEMS_MQ[INDEX_i] in MONOMIALS:COEFF[INDEX_i]=1;
        if MONOMIALS[-1]+1==0:COEFF[INDEX_i]=1;
        if len(COEFF)%2==1:COEFF=[0]+COEFF; # for CNN Training;    
        COEFF_MAT.append(COEFF);
    return COEFF_MAT;

def get_equations_from_bcs_format_txt(FILE_NAME):
    EQUATIONS_BOOLEAN = [];
    FILEIN = open(FILE_NAME);
    RES_DATA = FILEIN.readlines();
    for LINE in RES_DATA:
        LINE = LINE.replace(',','').replace(';','').replace('.','').replace('\n','');
        LINE_NEW = '';INDEX_i = 0;
        while INDEX_i < len(LINE):
            if INDEX_i==0:
                LINE_NEW += LINE[INDEX_i];
                INDEX_i+=1;continue;
            if LINE[INDEX_i] == 'x' and (LINE[INDEX_i-1]==')' or str_is_number(LINE[INDEX_i-1])):
                LINE_NEW += '*';
            LINE_NEW += LINE[INDEX_i];INDEX_i+=1;
        if LINE_NEW=='':continue;
        STRING_COMMAND = "EQUATIONS_BOOLEAN.append(" + LINE_NEW +")";
        exec(STRING_COMMAND);
    return EQUATIONS_BOOLEAN;

def get_equations_from_fes_format_in(FILE_NAME):
    EQUATIONS_BOOLEAN = [];
    FILEIN = open(FILE_NAME);
    RES_DATA = FILEIN.readlines();
    for LINE in RES_DATA:
        LINE = LINE.replace('\n','');
        if ',' in LINE:continue;
        STRING_COMMAND = "EQUATIONS_BOOLEAN.append(" + LINE +")";
        exec(STRING_COMMAND);
    return EQUATIONS_BOOLEAN;

def make_items_mq(ITEMS_VARS_USED):
    ITEMS_MQ = [];
    for INDEX_i in range(len(ITEMS_VARS_USED)):
        for INDEX_j in range(len(ITEMS_VARS_USED)):
            if INDEX_i>=INDEX_j:continue;
            ITEMS_MQ.append(ITEMS_VARS_USED[INDEX_i] * ITEMS_VARS_USED[INDEX_j]);
    ITEMS_MQ = ITEMS_MQ + ITEMS_VARS_USED;
    return ITEMS_MQ;

def make_mq_equations(MAX_USED_VARS,MAX_NUM_EQ,RHO):
    EQUATIONS_MQ = [];ITEMS_VARS_USED = ITEMS_BOOLEAN[0:MAX_USED_VARS];
    ITEMS_MQ = make_items_mq(ITEMS_VARS_USED);
    SOLV_MQ = {};
    EQUATIONS_MQ = [];
    for INDEX_i in range(len(ITEMS_VARS_USED)):SOLV_MQ[ITEMS_VARS_USED[INDEX_i]] = int(np.random.rand()+0.5);
    for INDEX_i in range(MAX_NUM_EQ):
        POLYNOMIAL = 0;
        for INDEX_j in range(len(ITEMS_MQ)):
            if np.random.rand()<RHO:POLYNOMIAL += ITEMS_MQ[INDEX_j];
        EQUATIONS_MQ.append(POLYNOMIAL);
    for INDEX_i in range(len(EQUATIONS_MQ)):
        if EQUATIONS_MQ[INDEX_i].subs(SOLV_MQ)==1:EQUATIONS_MQ[INDEX_i]+=1;
    # mq_2_coeff_file(EQUATIONS_MQ,ITEMS_MQ + [1],SOLV_MQ,SAVED_PATH + "/mq_eqs_"+str(INDEX_eq)+".coeff");
    return EQUATIONS_MQ,SOLV_MQ;

def bcs_algorithm_solving(EQUATIONS_MQ):
    os.system('rm bcs_result.txt');
    with open('EQUATIONS_MQ.poly','w') as FILEOUT:
        for INDEX_i in range(len(EQUATIONS_MQ)):
            FILEOUT.write( str(EQUATIONS_MQ[INDEX_i]).replace('t','x') );
            if INDEX_i==len(EQUATIONS_MQ)-1:FILEOUT.write('.');break;
            FILEOUT.write(';\n');
    os.system('./bcs_solver');
    return 0;

def libfes_solving(EQUATIONS_MQ,ITEMS_VARS_USED):
    os.system('rm fes_result.txt');
    with open('EQUATIONS_MQ.in','w') as FILEOUT:
        FILEOUT.write( str(ITEMS_VARS_USED).replace('[','').replace(']','') );FILEOUT.write('\n');
        for INDEX_i in range(len(EQUATIONS_MQ)):
            FILEOUT.write( str(EQUATIONS_MQ[INDEX_i]) );
            FILEOUT.write('\n');
    os.system('./fes_solver < EQUATIONS_MQ.in >> fes_result.txt');

def write_into_libfes_format(EQUATIONS_MQ,ITEMS_VARS_USED,FILE_NAME):
    with open('dataset/EQUATIONS_' + FILE_NAME + '.in','w') as FILEOUT:
        FILEOUT.write( str(ITEMS_VARS_USED).replace('[','').replace(']','') );FILEOUT.write('\n');
        for INDEX_i in range(len(EQUATIONS_MQ)):
            FILEOUT.write( str(EQUATIONS_MQ[INDEX_i]) );
            FILEOUT.write('\n');

def write_into_ppsh_format(EQUATIONS_MQ,ITEMS_VARS_USED,FILE_NAME):
    with open('dataset/EQUATIONS_' + FILE_NAME + '.in','w') as FILEOUT:
        for INDEX_i in range(len(EQUATIONS_MQ)):
            FILEOUT.write( str(EQUATIONS_MQ[INDEX_i]) );
            FILEOUT.write('\n');

def equations_solved_by_fes():
    FILEIN = open('fes_result.txt');
    RES_DATA = FILEIN.readlines();
    if len(RES_DATA)>0:return True;
    return False;

def equations_solved_by_bcs():
    FILEIN = open('bcs_result.txt');
    RES_DATA = FILEIN.readlines();
    if len(RES_DATA)>1:return True;
    return False;

def write_into_bcs_format(EQUATIONS_MQ,SAVED_PATH):
    os.system("sudo rm " + SAVED_PATH);
    with open(SAVED_PATH,'w') as FILEOUT:
        for POLYNOMIAL in EQUATIONS_MQ[0:-1]:
            FILEOUT.write(str(POLYNOMIAL) + ";");
            FILEOUT.write('\n');
        FILEOUT.write(str(EQUATIONS_MQ[-1]) + ".");
        FILEOUT.write('\n');

def write_into_field_value(DICT_VALUE):
    DAT_SOLV = [];DAT_COEFF_MAT = [];DAT_VALUE = [];
    for VALUE in DICT_VALUE:
        SOLV_POINT = VALUE[0];
        SOLV_LIST = [SOLV_POINT[KEY] for KEY in SOLV_POINT.keys()];
        DAT_SOLV.append(SOLV_LIST);
        DAT_COEFF_MAT.append(VALUE[1]);
        DAT_VALUE.append( [VALUE[2]] );
    #print(DAT_SOLV);print(DAT_COEFF_MAT);print(DAT_VALUE);
    np.save("DAT_COEFF_MAT_VALUE_FIELD/DAT_SOLV",np.array(DAT_SOLV,dtype=float));
    np.save("DAT_COEFF_MAT_VALUE_FIELD/DAT_COEFF_MAT",np.array(DAT_COEFF_MAT,dtype=float));
    np.save("DAT_COEFF_MAT_VALUE_FIELD/DAT_VALUE",np.array(DAT_VALUE,dtype=float));

def write_into_field_value_sp(DICT_VALUE):
    DAT_SOLV = [];DAT_SP_POINTS0 = [];DAT_SP_POINTS1 = [];DAT_VALUE = [];
    for VALUE in DICT_VALUE:
        SOLV_POINT = VALUE[0];
        SOLV_LIST = [SOLV_POINT[KEY] for KEY in SOLV_POINT.keys()];
        DAT_SOLV.append(SOLV_LIST);
        DAT_SP_POINTS0.append(VALUE[1][0]);
        DAT_SP_POINTS1.append(VALUE[1][1]);
        DAT_VALUE.append( [VALUE[2]] );
    np.save("DAT_SP_POINTS_VALUE_FIELD/DAT_SOLV",np.array(DAT_SOLV,dtype=float));
    np.save("DAT_SP_POINTS_VALUE_FIELD/DAT_SP_POINTS0",np.array(DAT_SP_POINTS0,dtype=float));
    np.save("DAT_SP_POINTS_VALUE_FIELD/DAT_SP_POINTS1",np.array(DAT_SP_POINTS1,dtype=float));
    np.save("DAT_SP_POINTS_VALUE_FIELD/DAT_VALUE",np.array(DAT_VALUE,dtype=float));

def write_into_field_value_rp(DICT_VALUE):
    DAT_SOLV = [];DAT_RP_POINTSX = [];DAT_RP_POINTSY = [];DAT_VALUE = [];
    for VALUE in DICT_VALUE:
        SOLV_POINT = VALUE[0];
        SOLV_LIST = [SOLV_POINT[KEY] for KEY in SOLV_POINT.keys()];
        DAT_SOLV.append(SOLV_LIST);
        DAT_RP_POINTSX.append(VALUE[1][0]);
        DAT_RP_POINTSY.append(VALUE[1][1]);
        DAT_VALUE.append( [VALUE[2]] );
    np.save("DAT_RP_POINTS_VALUE_FIELD/DAT_SOLV",np.array(DAT_SOLV,dtype=float));
    np.save("DAT_RP_POINTS_VALUE_FIELD/DAT_RP_POINTSX",np.array(DAT_RP_POINTSX,dtype=float));
    np.save("DAT_RP_POINTS_VALUE_FIELD/DAT_RP_POINTSY",np.array(DAT_RP_POINTSY,dtype=float));
    np.save("DAT_RP_POINTS_VALUE_FIELD/DAT_VALUE",np.array(DAT_VALUE,dtype=float));

def make_ndim_solutions(DIM,ITEMS_VARS_USED):
    ALL_SOLUTIONS = [];
    for INDEX_i in range(2**DIM):
        SOLV_POINT = {};
        SOLV_LIST = list(str(bin(INDEX_i)).replace("0b",""));
        DIM_THIS = len(SOLV_LIST);
        SOLV_LIST = ['0']*(DIM - DIM_THIS) + SOLV_LIST;
        for INDEX_j in range(len(ITEMS_VARS_USED)):
            SOLV_POINT[ ITEMS_VARS_USED[INDEX_j] ] = int(SOLV_LIST[INDEX_j]);
        ALL_SOLUTIONS.append(SOLV_POINT);
    return ALL_SOLUTIONS;

def make_solution_vec(SOLUTION_PART):
    SOLUTION_PART_VEC = [SOLUTION_PART[KEY] for KEY in SOLUTION_PART.keys()];
    return SOLUTION_PART_VEC;

def make_coeff_mats_dict(ALL_SOLUTIONS,EQUATIONS_MQ,ITEMS_MQ):
    COEFF_MATS_CNN_DICT = {};EQUATIONS_MQ_PART_DICT = {};
    for SOLV_POINT in  ALL_SOLUTIONS:
        EQUATIONS_MQ_PART = [POLYNOMIAL.subs(SOLV_POINT) for POLYNOMIAL in EQUATIONS_MQ];
        COEFF_MATS_CNN_DICT[ALL_SOLUTIONS.index(SOLV_POINT)] = eq_2_co_boolean_CNN(EQUATIONS_MQ_PART,ITEMS_MQ);
        EQUATIONS_MQ_PART_DICT[ALL_SOLUTIONS.index(SOLV_POINT)] = EQUATIONS_MQ_PART;
    return COEFF_MATS_CNN_DICT,EQUATIONS_MQ_PART_DICT;

def compute_field_value(SOLV_POINT,SOLV_MQ,ALL_SOLUTIONS):
    DISTANCE_LIST = abs( ALL_SOLUTIONS.index(SOLV_MQ) -  ALL_SOLUTIONS.index(SOLV_POINT) );
    return (100.0/(DISTANCE_LIST+1))*0.01;

# def compute_field_value(SOLV_POINT,SOLV_MQ,ALL_SOLUTIONS):
#     DISTANCE_LIST = abs( ALL_SOLUTIONS.index(SOLV_MQ) -  ALL_SOLUTIONS.index(SOLV_POINT) );
#     if  DISTANCE_LIST == 0:return 1.0;
#     return 0.0;

def compute_special_points(EQUATIONS_MQ,SOLV_POINT,SOLV_POINT_ALL0,SOLV_POINT_ALL1):
    EQUATIONS_MQ = [POLYNOMIAL.subs(SOLV_POINT) for POLYNOMIAL in EQUATIONS_MQ];SP01_POINTS = [0]*2;
    SP01_POINTS[0] = [POLYNOMIAL.subs(SOLV_POINT_ALL0) for POLYNOMIAL in EQUATIONS_MQ];
    SP01_POINTS[1] = [POLYNOMIAL.subs(SOLV_POINT_ALL1) for POLYNOMIAL in EQUATIONS_MQ];
    return SP01_POINTS;

def compute_coeff_mat(EQUATIONS_MQ,SOLV_POINT,ITEMS_MQ):
    EQUATIONS_MQ = [POLYNOMIAL.subs(SOLV_POINT) for POLYNOMIAL in EQUATIONS_MQ];
    return eq_2_co_boolean(EQUATIONS_MQ,ITEMS_MQ);

def is_var_in_polynomial(VAR_ELIMINATED,POLYNOMIAL_REM):
    POLYNOMIAL_INIT = 0;
    for MONOMIAL in monomials_of_poly(POLYNOMIAL_REM):
        if is_factor(VAR_ELIMINATED,MONOMIAL):
            MONOMIAL_KEY = MONOMIAL/VAR_ELIMINATED;
            if type(MONOMIAL_KEY)==sage.rings.fraction_field_element.FractionFieldElement:MONOMIAL_KEY=MONOMIAL_KEY.numerator();
            POLYNOMIAL_INIT += MONOMIAL_KEY;
    return POLYNOMIAL_INIT;

def pseudo_division(POLYNOMIAL_S1,POLYNOMIAL_S2,VAR_ELIMINATED):
    POLYNOMIAL_REM = POLYNOMIAL_S2;
    POLYNOMIAL_QUO = 0;
    POLYNOMIAL_INIT_1 = is_var_in_polynomial(VAR_ELIMINATED,POLYNOMIAL_REM);
    POLYNOMIAL_INIT_2 = is_var_in_polynomial(VAR_ELIMINATED,POLYNOMIAL_S1);
    # print('POLYNOMIAL_S1 = '+ str(POLYNOMIAL_S1));
    # print('POLYNOMIAL_S2 = '+ str(POLYNOMIAL_S2));
    if POLYNOMIAL_INIT_1==0:return 0,0; # not including VAR_ELIMINATED;
    while (POLYNOMIAL_REM != 0) and POLYNOMIAL_INIT_1:
        POLYNOMIAL_REM = POLYNOMIAL_INIT_2 * POLYNOMIAL_REM + POLYNOMIAL_INIT_1 * POLYNOMIAL_S1;
        POLYNOMIAL_QUO = POLYNOMIAL_INIT_2 * POLYNOMIAL_QUO + POLYNOMIAL_INIT_1;
        POLYNOMIAL_INIT_1 = is_var_in_polynomial(VAR_ELIMINATED,POLYNOMIAL_REM);
        #print('POLYNOMIAL_REM = '+ str(POLYNOMIAL_REM));
    #print('VALI: ' + str( (POLYNOMIAL_INIT_2*POLYNOMIAL_S2 + POLYNOMIAL_QUO*POLYNOMIAL_S1 + POLYNOMIAL_REM) ));
    return POLYNOMIAL_QUO,POLYNOMIAL_REM;