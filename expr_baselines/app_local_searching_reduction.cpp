#include "ppsh_functions.hpp"
#include <vector>
#include <string>
#include <iostream>
#include <cstring>
#include <fstream>
#include <map>
#include <ctime>
// g++ app_local_searching_reduction.cpp -o app -lginac -lcln

using namespace std;

# define MAX_USED_VARS_NUM 16
# define MAX_EQ_NUM 16

int MAX_AUX_VARS_NUM =  0;
int SPARSE_NUM       = 12;

// =======================  Symbols Define  =======================
GiNaC::symbol x0("x0"), x1("x1"), x2("x2"), x3("x3"), x4("x4"), x5("x5"), x6("x6"), x7("x7"), x8("x8"), x9("x9"), x10("x10"), x11("x11"), x12("x12"), x13("x13"), x14("x14"), x15("x15"), x16("x16"), x17("x17"), x18("x18"), x19("x19"), x20("x20"), x21("x21"), x22("x22"), x23("x23"), x24("x24"), x25("x25"), x26("x26"), x27("x27"), x28("x28"), x29("x29"), x30("x30"), x31("x31"), x32("x32"), x33("x33"), x34("x34"), x35("x35"), x36("x36"), x37("x37"), x38("x38"), x39("x39"), x40("x40"), x41("x41"), x42("x42"), x43("x43"), x44("x44"), x45("x45"), x46("x46"), x47("x47"), x48("x48"), x49("x49"), x50("x50"), x51("x51"), x52("x52"), x53("x53"), x54("x54"), x55("x55"), x56("x56"), x57("x57"), x58("x58"), x59("x59"), x60("x60"), x61("x61"), x62("x62"), x63("x63"), x64("x64"), x65("x65"), x66("x66"), x67("x67"), x68("x68"), x69("x69"), x70("x70"), x71("x71"), x72("x72"), x73("x73"), x74("x74"), x75("x75"), x76("x76"), x77("x77"), x78("x78"), x79("x79"), x80("x80"), x81("x81"), x82("x82"), x83("x83"), x84("x84"), x85("x85"), x86("x86"), x87("x87"), x88("x88"), x89("x89"), x90("x90"), x91("x91"), x92("x92"), x93("x93"), x94("x94"), x95("x95"), x96("x96"), x97("x97"), x98("x98"), x99("x99"), x100("x100"), z1("z1"), z2("z2"), z3("z3"), z4("z4"), z5("z5"), z6("z6"), z7("z7"), z8("z8"), z9("z9"), z10("z10"), z11("z11"), z12("z12"), z13("z13"), z14("z14"), z15("z15"), z16("z16"), z17("z17"), z18("z18"), z19("z19"), z20("z20"), z21("z21"), z22("z22"), z23("z23"), z24("z24"), z25("z25"), z26("z26"), z27("z27"), z28("z28"), z29("z29"), z30("z30"), z31("z31"), z32("z32"), z33("z33"), z34("z34"), z35("z35"), z36("z36"), z37("z37"), z38("z38"), z39("z39"), z40("z40"), z41("z41"), z42("z42"), z43("z43"), z44("z44"), z45("z45"), z46("z46"), z47("z47"), z48("z48"), z49("z49"), z50("z50"), z51("z51"), z52("z52"), z53("z53"), z54("z54"), z55("z55"), z56("z56"), z57("z57"), z58("z58"), z59("z59"), z60("z60"), z61("z61"), z62("z62"), z63("z63"), z64("z64"), z65("z65"), z66("z66"), z67("z67"), z68("z68"), z69("z69"), z70("z70"), z71("z71"), z72("z72"), z73("z73"), z74("z74"), z75("z75"), z76("z76"), z77("z77"), z78("z78"), z79("z79"), z80("z80"), z81("z81"), z82("z82"), z83("z83"), z84("z84"), z85("z85"), z86("z86"), z87("z87"), z88("z88"), z89("z89"), z90("z90"), z91("z91"), z92("z92"), z93("z93"), z94("z94"), z95("z95"), z96("z96"), z97("z97"), z98("z98"), z99("z99"), z100("z100"), z101("z101"), z102("z102"), z103("z103"), z104("z104"), z105("z105"), z106("z106"), z107("z107"), z108("z108"), z109("z109"), z110("z110"), z111("z111"), z112("z112"), z113("z113"), z114("z114"), z115("z115"), z116("z116"), z117("z117"), z118("z118"), z119("z119"), z120("z120"), z121("z121"), z122("z122"), z123("z123"), z124("z124"), z125("z125"), z126("z126"), z127("z127"), z128("z128"), z129("z129"), z130("z130"), z131("z131"), z132("z132"), z133("z133"), z134("z134"), z135("z135"), z136("z136"), z137("z137"), z138("z138"), z139("z139"), z140("z140"), z141("z141"), z142("z142"), z143("z143"), z144("z144"), z145("z145"), z146("z146"), z147("z147"), z148("z148"), z149("z149"), z150("z150"), z151("z151"), z152("z152"), z153("z153"), z154("z154"), z155("z155"), z156("z156"), z157("z157"), z158("z158"), z159("z159"), z160("z160"), z161("z161"), z162("z162"), z163("z163"), z164("z164"), z165("z165"), z166("z166"), z167("z167"), z168("z168"), z169("z169"), z170("z170"), z171("z171"), z172("z172"), z173("z173"), z174("z174"), z175("z175"), z176("z176"), z177("z177"), z178("z178"), z179("z179"), z180("z180"), z181("z181"), z182("z182"), z183("z183"), z184("z184"), z185("z185"), z186("z186"), z187("z187"), z188("z188"), z189("z189"), z190("z190"), z191("z191"), z192("z192"), z193("z193"), z194("z194"), z195("z195"), z196("z196"), z197("z197"), z198("z198"), z199("z199"), z200("z200"), z201("z201"), z202("z202"), z203("z203"), z204("z204"), z205("z205"), z206("z206"), z207("z207"), z208("z208"), z209("z209"), z210("z210"), z211("z211"), z212("z212"), z213("z213"), z214("z214"), z215("z215"), z216("z216"), z217("z217"), z218("z218"), z219("z219"), z220("z220"), z221("z221"), z222("z222"), z223("z223"), z224("z224"), z225("z225"), z226("z226"), z227("z227"), z228("z228"), z229("z229"), z230("z230"), z231("z231"), z232("z232"), z233("z233"), z234("z234"), z235("z235"), z236("z236"), z237("z237"), z238("z238"), z239("z239"), z240("z240"), z241("z241"), z242("z242"), z243("z243"), z244("z244"), z245("z245"), z246("z246"), z247("z247"), z248("z248"), z249("z249"), z250("z250"), z251("z251"), z252("z252"), z253("z253"), z254("z254"), z255("z255"), z256("z256"), z257("z257"), z258("z258"), z259("z259"), z260("z260"), z261("z261"), z262("z262"), z263("z263"), z264("z264"), z265("z265"), z266("z266"), z267("z267"), z268("z268"), z269("z269"), z270("z270"), z271("z271"), z272("z272"), z273("z273"), z274("z274"), z275("z275"), z276("z276"), z277("z277"), z278("z278"), z279("z279"), z280("z280"), z281("z281"), z282("z282"), z283("z283"), z284("z284"), z285("z285"), z286("z286"), z287("z287"), z288("z288"), z289("z289"), z290("z290"), z291("z291"), z292("z292"), z293("z293"), z294("z294"), z295("z295"), z296("z296"), z297("z297"), z298("z298"), z299("z299"), z300("z300");
std::vector<GiNaC::symbol> ITEMS_VARS {x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31,x32,x33,x34,x35,x36,x37,x38,x39,x40,x41,x42,x43,x44,x45,x46,x47,x48,x49,x50,x51,x52,x53,x54,x55,x56,x57,x58,x59,x60,x61,x62,x63,x64,x65,x66,x67,x68,x69,x70,x71,x72,x73,x74,x75,x76,x77,x78,x79,x80,x81,x82,x83,x84,x85,x86,x87,x88,x89,x90,x91,x92,x93,x94,x95,x96,x97,x98,x99,x100};
std::vector<GiNaC::symbol> ITEMS_VARS_AUX {z1,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11,z12,z13,z14,z15,z16,z17,z18,z19,z20,z21,z22,z23,z24,z25,z26,z27,z28,z29,z30,z31,z32,z33,z34,z35,z36,z37,z38,z39,z40,z41,z42,z43,z44,z45,z46,z47,z48,z49,z50,z51,z52,z53,z54,z55,z56,z57,z58,z59,z60,z61,z62,z63,z64,z65,z66,z67,z68,z69,z70,z71,z72,z73,z74,z75,z76,z77,z78,z79,z80,z81,z82,z83,z84,z85,z86,z87,z88,z89,z90,z91,z92,z93,z94,z95,z96,z97,z98,z99,z100,z101,z102,z103,z104,z105,z106,z107,z108,z109,z110,z111,z112,z113,z114,z115,z116,z117,z118,z119,z120,z121,z122,z123,z124,z125,z126,z127,z128,z129,z130,z131,z132,z133,z134,z135,z136,z137,z138,z139,z140,z141,z142,z143,z144,z145,z146,z147,z148,z149,z150,z151,z152,z153,z154,z155,z156,z157,z158,z159,z160,z161,z162,z163,z164,z165,z166,z167,z168,z169,z170,z171,z172,z173,z174,z175,z176,z177,z178,z179,z180,z181,z182,z183,z184,z185,z186,z187,z188,z189,z190,z191,z192,z193,z194,z195,z196,z197,z198,z199,z200,z201,z202,z203,z204,z205,z206,z207,z208,z209,z210,z211,z212,z213,z214,z215,z216,z217,z218,z219,z220,z221,z222,z223,z224,z225,z226,z227,z228,z229,z230,z231,z232,z233,z234,z235,z236,z237,z238,z239,z240,z241,z242,z243,z244,z245,z246,z247,z248,z249,z250,z251,z252,z253,z254,z255,z256,z257,z258,z259,z260,z261,z262,z263,z264,z265,z266,z267,z268,z269,z270,z271,z272,z273,z274,z275,z276,z277,z278,z279,z280,z281,z282,z283,z284,z285,z286,z287,z288,z289,z290,z291,z292,z293,z294,z295,z296,z297,z298,z299,z300};

GiNaC::exmap generating_rand_solv(const std::vector<GiNaC::symbol>& ITEMS_VARS_USED)
{
    GiNaC::exmap SOLUTION_RAND;
    for (int INDEX = 0; INDEX < ITEMS_VARS_USED.size(); ++INDEX){ SOLUTION_RAND[ITEMS_VARS_USED[INDEX]] = (rand()%2)*1.0; }
    return SOLUTION_RAND;
}

GiNaC::exmap generating_rand_solv_inR(const std::vector<GiNaC::symbol>& ITEMS_VARS_USED)
{
    GiNaC::exmap SOLUTION_RAND;
    for (int INDEX = 0; INDEX < ITEMS_VARS_USED.size(); ++INDEX){ SOLUTION_RAND[ITEMS_VARS_USED[INDEX]] = rand()*0.33; }
    return SOLUTION_RAND;
}

void ppsh_print_solution(GiNaC::exmap SOLUTION_NOW)
{
    for (GiNaC::exmap::iterator ITERATOR = SOLUTION_NOW.begin(); ITERATOR != SOLUTION_NOW.end(); ++ITERATOR)
    {
        cout<<ITERATOR->first<<" = "<<ITERATOR->second<<", ";
    }
    cout<<" -------------------------------------------------- "<<endl;
}

GiNaC::ex ppsh_subs_by_solv_inR( GiNaC::ex & POLYNOMIAL,GiNaC::exmap SOLUTION_NOW)
{
    GiNaC::ex RES_NUM = GiNaC::subs( POLYNOMIAL, ITEMS_VARS[0]==0);
    for (int INDEX_i = 1; INDEX_i < MAX_USED_VARS_NUM; ++INDEX_i){RES_NUM = GiNaC::subs( RES_NUM, ITEMS_VARS[INDEX_i]==SOLUTION_NOW[ITEMS_VARS[INDEX_i]] );}
    for (int INDEX_i = 0; INDEX_i < MAX_AUX_VARS_NUM; ++INDEX_i){RES_NUM = GiNaC::subs( RES_NUM, ITEMS_VARS_AUX[INDEX_i]==SOLUTION_NOW[ITEMS_VARS_AUX[INDEX_i]] );}
    return RES_NUM;
}

GiNaC::ex computing_sat_num(std::vector<GiNaC::ex> EQUATIONS_MQ, GiNaC::exmap TAB_SOLV)
{
    GiNaC::ex SAT_NUM = ppsh_subs_by_solv_inR(EQUATIONS_MQ[0],TAB_SOLV);
    for (int INDEX = 1; INDEX < EQUATIONS_MQ.size(); ++INDEX)
    { 
        SAT_NUM += ppsh_subs_by_solv_inR(EQUATIONS_MQ[INDEX],TAB_SOLV);
    }
    return SAT_NUM*SAT_NUM;
}

bool is_visited(GiNaC::exmap SOLUTION_NOW, std::vector<GiNaC::exmap> VISITED_POINTS)
{
    std::vector<GiNaC::exmap>::iterator ITERATOR;
    ITERATOR = find(VISITED_POINTS.begin(), VISITED_POINTS.end(), SOLUTION_NOW);
    if (ITERATOR == VISITED_POINTS.end()){return false;}
    return true;
}

std::map<GiNaC::exmap,bool> construct_visited_tab( int USED_VARS_NUM)
{
    std::map<GiNaC::exmap,bool> VISITED_POINTS_TAB;
    GiNaC::exmap SOLUTION_NOW;
    bool NEED_ADV = false;
    for (int INDEX_i = 0; INDEX_i < pow(2,USED_VARS_NUM); ++INDEX_i)
    {
        if(INDEX_i==0)
        {
            for (int INDEX_j = 0; INDEX_j < USED_VARS_NUM; ++INDEX_j){SOLUTION_NOW[ITEMS_VARS[INDEX_j]]=0;}
            VISITED_POINTS_TAB[SOLUTION_NOW] = 0;
            continue;
        }
        for (int INDEX_j = 0; INDEX_j < USED_VARS_NUM; ++INDEX_j)
        {
            if (INDEX_j==0)
            { 
                //SOLUTION_NOW[ITEMS_VARS[INDEX_j]] = ( GiNaC::ex_to<GiNaC::numeric>( SOLUTION_NOW[ITEMS_VARS[INDEX_j]]+1 ).to_int() )%2*1.0;
                if(SOLUTION_NOW[ITEMS_VARS[INDEX_j]]==1){SOLUTION_NOW[ITEMS_VARS[INDEX_j]]=0;}
                if(SOLUTION_NOW[ITEMS_VARS[INDEX_j]]==0){SOLUTION_NOW[ITEMS_VARS[INDEX_j]]=1;}
                NEED_ADV = (SOLUTION_NOW[ITEMS_VARS[INDEX_j]]==0);
                continue;
            }
            if(NEED_ADV)
            {
                //SOLUTION_NOW[ITEMS_VARS[INDEX_j]] = ( GiNaC::ex_to<GiNaC::numeric>( SOLUTION_NOW[ITEMS_VARS[INDEX_j]]+1 ).to_int() )%2*1.0;
                if(SOLUTION_NOW[ITEMS_VARS[INDEX_j]]==1){SOLUTION_NOW[ITEMS_VARS[INDEX_j]]=0;}
                if(SOLUTION_NOW[ITEMS_VARS[INDEX_j]]==0){SOLUTION_NOW[ITEMS_VARS[INDEX_j]]=1;}
                NEED_ADV = (SOLUTION_NOW[ITEMS_VARS[INDEX_j]]==0);
            }
        }
        VISITED_POINTS_TAB[SOLUTION_NOW] = 0;
        //for (int INDEX_j = 0; INDEX_j < USED_VARS_NUM; ++INDEX_j){cout<<SOLUTION_NOW[ITEMS_VARS[INDEX_j]];}
        //cout<<" "<<endl;
    }
    return VISITED_POINTS_TAB;
}

std::vector<GiNaC::ex> make_reduction_to_R(std::vector<GiNaC::ex> EQUATIONS_MQ)
{
    std::vector<GiNaC::ex> EQUATIONS_MQ_RED = EQUATIONS_MQ;
    int NUM_TERMS,NUM_K0;
    GiNaC::ex POLYNOMIAL;
    GiNaC::exmap SOLUTION_ALL0;
    for (int INDEX_i = 0; INDEX_i < MAX_USED_VARS_NUM; ++INDEX_i){SOLUTION_ALL0[ITEMS_VARS[INDEX_i]] = 0;}
    for (int INDEX_i = 0; INDEX_i < MAX_AUX_VARS_NUM; ++INDEX_i){SOLUTION_ALL0[ITEMS_VARS_AUX[INDEX_i]] = 0;}
    for (int INDEX_i = 0; INDEX_i < EQUATIONS_MQ_RED.size(); ++INDEX_i)
    {
        POLYNOMIAL = EQUATIONS_MQ[INDEX_i];
        NUM_TERMS  = POLYNOMIAL.nops();
        NUM_K0     = GiNaC::ex_to<GiNaC::numeric>(ppsh_subs_by_solv_inR(POLYNOMIAL, SOLUTION_ALL0)).to_int();
        for (int INDEX_k = NUM_K0; INDEX_k < NUM_TERMS/2; ++INDEX_k)
        {
            if(INDEX_k == NUM_K0){EQUATIONS_MQ_RED[INDEX_i] = POLYNOMIAL - 2.0*INDEX_k;continue;}
            EQUATIONS_MQ_RED[INDEX_i] *= POLYNOMIAL - 2.0*INDEX_k;
        }
        //cout<<EQUATIONS_MQ_RED[INDEX_i]<<endl;
    }
    return EQUATIONS_MQ_RED;
}

std::vector<GiNaC::ex> splitting_into_sparse_equations(std::vector<GiNaC::ex> EQUATIONS_MQ)
{
    std::vector<GiNaC::ex> EQUATIONS_MQ_RED;
    int NUM_POLYNOMIALS;bool IS_FIRST_SUB_POLY;
    std::vector<GiNaC::ex> MONOMIALS;
    GiNaC::ex POLYNOMIAL = 0;
    for (int INDEX_i = 0; INDEX_i < EQUATIONS_MQ.size(); ++INDEX_i)
    {
        NUM_POLYNOMIALS = MONOMIALS.size()/SPARSE_NUM + (MONOMIALS.size()%SPARSE_NUM > 0) ;
        MONOMIALS = ppsh_monomials_of(EQUATIONS_MQ[INDEX_i]);
        //cout<<"f_"<<INDEX_i<<" = "<< EQUATIONS_MQ[INDEX_i]<<endl;
        POLYNOMIAL = ITEMS_VARS_AUX[MAX_AUX_VARS_NUM];IS_FIRST_SUB_POLY = true;
        for (int INDEX_j = 0; INDEX_j < MONOMIALS.size(); ++INDEX_j)
        {
            POLYNOMIAL += MONOMIALS[INDEX_j];
            if((POLYNOMIAL.nops() == SPARSE_NUM-1) & !IS_FIRST_SUB_POLY)
            {
                POLYNOMIAL += ITEMS_VARS_AUX[MAX_AUX_VARS_NUM];
                EQUATIONS_MQ_RED.push_back(POLYNOMIAL);
                POLYNOMIAL = ITEMS_VARS_AUX[MAX_AUX_VARS_NUM];MAX_AUX_VARS_NUM++;
            }
            if((POLYNOMIAL.nops() == SPARSE_NUM) & IS_FIRST_SUB_POLY)
            {
                EQUATIONS_MQ_RED.push_back(POLYNOMIAL);
                POLYNOMIAL = ITEMS_VARS_AUX[MAX_AUX_VARS_NUM];MAX_AUX_VARS_NUM++;
                IS_FIRST_SUB_POLY = false;
            }
        }
        if(POLYNOMIAL.nops() > 1){EQUATIONS_MQ_RED.push_back(POLYNOMIAL);}
    }
    return EQUATIONS_MQ_RED;
}

int main(int argc, char const *argv[])
{
    srand(time(0));
    clock_t TIME_START, TIME_END;
    long double TIME_COST;
    std::map<string,GiNaC::symbol> MAP_STR_SYMBOL = construct_map(ITEMS_VARS);
    std::vector<GiNaC::ex> EQUATIONS_MQ  = ppsh_read_formulas_from_file("dataset/EQUATIONS_n"+ to_string(MAX_USED_VARS_NUM) +"_m"+ to_string(MAX_EQ_NUM) +"_F1.in",MAP_STR_SYMBOL);
    std::vector<GiNaC::symbol> ITEMS_VARS_USED{&ITEMS_VARS[0], &ITEMS_VARS[0] + MAX_USED_VARS_NUM};
    
    EQUATIONS_MQ = splitting_into_sparse_equations(EQUATIONS_MQ);
    for (int INDEX_i = 0; INDEX_i < EQUATIONS_MQ.size(); ++INDEX_i){cout<<"f_"<<INDEX_i<<" = "<<EQUATIONS_MQ[INDEX_i]<<endl;}
    std::vector<GiNaC::ex> EQUATIONS_MQ_RED = make_reduction_to_R(EQUATIONS_MQ);
    for (int INDEX_i = 0; INDEX_i < EQUATIONS_MQ_RED.size(); ++INDEX_i){cout<<"f_"<<INDEX_i<<" = "<<EQUATIONS_MQ_RED[INDEX_i]<<endl;}return 0;

    std::map<GiNaC::exmap,bool> VISITED_POINTS_TAB;
    // GiNaC::exmap SOLUTION_NOW = generating_rand_solv_inR(ITEMS_VARS_USED);
    // for (int INDEX_i = 0; INDEX_i < MAX_USED_VARS_NUM; ++INDEX_i){cout<<ITEMS_VARS_USED[INDEX_i]<<" = "<<SOLUTION_NOW[ITEMS_VARS_USED[INDEX_i]]<<endl;}
    // for (int INDEX_i = 0; INDEX_i < MAX_EQ_NUM; ++INDEX_i){cout<<"f_"<<INDEX_i<<" = "<<ppsh_subs_by_solv_inR(EQUATIONS_MQ[INDEX_i],SOLUTION_NOW)<<endl;}

    ITEMS_VARS_USED.insert(ITEMS_VARS_USED.end(), ITEMS_VARS_AUX.begin(), ITEMS_VARS_AUX.begin()+MAX_AUX_VARS_NUM);
    //for (int INDEX_i = 0; INDEX_i < ITEMS_VARS_USED.size(); ++INDEX_i){cout<<ITEMS_VARS_USED[INDEX_i]<<endl;}return 0;

    // ========================== Local Searching ==========================
    GiNaC::exmap SOLUTION_NOW = generating_rand_solv(ITEMS_VARS_USED);bool IS_UPDATED,IS_VISITED;GiNaC::ex SAT_NUM_NOW,SAT_NUM_NEXT;int RUNNING_TIMES = 0;
    GiNaC::exmap SOLUTION_NEXT;int TRAPPED_INTO_WHILE = 0;
    // std::vector<GiNaC::exmap> VISITED_POINTS;
    TIME_START = clock();
    while(true)
    {
        SAT_NUM_NOW = computing_sat_num(EQUATIONS_MQ_RED, SOLUTION_NOW);
        if(SAT_NUM_NOW == 0.0){break;}
        cout<<" --- RUNNING_TIMES = "<<RUNNING_TIMES<<", SAT_NUM_NOW = "<<SAT_NUM_NOW<<" --- "<<endl;
        IS_UPDATED = false;
        for (int INDEX_i = 0; INDEX_i < MAX_USED_VARS_NUM+MAX_AUX_VARS_NUM; ++INDEX_i)
        {
            SOLUTION_NEXT = SOLUTION_NOW;
            //cout<<"RUNNING HERE!!! --- 1"<<endl;
            //cout<<GiNaC::ex_to<GiNaC::numeric>( SOLUTION_NEXT[ITEMS_VARS_USED[INDEX_i]]+1 ).to_int()<<endl;
            //SOLUTION_NEXT[ITEMS_VARS_USED[INDEX_i]] = ( GiNaC::ex_to<GiNaC::numeric>( SOLUTION_NEXT[ITEMS_VARS_USED[INDEX_i]]+1 ).to_int() )%2;
            SOLUTION_NEXT[ITEMS_VARS_USED[INDEX_i]] = 2 - ( SOLUTION_NEXT[ITEMS_VARS_USED[INDEX_i]]+1 );
            //cout<<"RUNNING HERE!!! --- 2"<<endl;
            //SOLUTION_NEXT[ITEMS_VARS_USED[INDEX_i]] = swap_10( SOLUTION_NEXT[ITEMS_VARS_USED[INDEX_i]] );
            IS_VISITED = (VISITED_POINTS_TAB.count(SOLUTION_NEXT)>0);
            if (IS_VISITED){continue;}
            SAT_NUM_NEXT = computing_sat_num(EQUATIONS_MQ_RED, SOLUTION_NEXT);
            if(SAT_NUM_NOW > SAT_NUM_NEXT){SOLUTION_NOW = SOLUTION_NEXT;IS_UPDATED = true;break;}
            VISITED_POINTS_TAB[SOLUTION_NEXT] = true;
        }
        if(!IS_UPDATED)
        {
            IS_VISITED = true;
            TRAPPED_INTO_WHILE = 0;
            while(IS_VISITED)
            {
                SOLUTION_NOW = generating_rand_solv(ITEMS_VARS_USED);
                IS_VISITED = (VISITED_POINTS_TAB.count(SOLUTION_NOW)>0);
                //cout<<"TRAPPED_INTO_WHILE = "<<TRAPPED_INTO_WHILE<<endl;
                //TRAPPED_INTO_WHILE++;
            }
        }
        VISITED_POINTS_TAB[SOLUTION_NOW] = true;
        RUNNING_TIMES++;
    }
    TIME_END = clock();
    TIME_COST = (long double)(TIME_END - TIME_START) / CLOCKS_PER_SEC;
    cout << "Cost Time:" << TIME_COST << "s" << endl;
}