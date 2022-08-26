#include "ppsh_functions.hpp"
#include <vector>
#include <string>
#include <iostream>
#include <cstring>
#include <fstream>
#include <map>
#include <ctime>
// g++ app_local_searching.cpp -o app -lginac -lcln

using namespace std;

# define MAX_USED_VARS_NUM 16
# define MAX_EQ_NUM 16

GiNaC::exmap generating_rand_solv(const std::vector<GiNaC::symbol>& ITEMS_VARS_USED)
{
    GiNaC::exmap SOLUTION_RAND;
    for (int INDEX = 0; INDEX < ITEMS_VARS_USED.size(); ++INDEX){ SOLUTION_RAND[ITEMS_VARS_USED[INDEX]] = rand()%2; }
    return SOLUTION_RAND;
}

int computing_sat_num(std::vector<GiNaC::ex> EQUATIONS_MQ, GiNaC::exmap TAB_SOLV, std::vector<GiNaC::symbol> const& ITEMS_VARS)
{
    int SAT_NUM = 0;int VALUE = 0;
    for (int INDEX = 0; INDEX < EQUATIONS_MQ.size(); ++INDEX)
    { 
        VALUE = GiNaC::ex_to<GiNaC::numeric>( ppsh_subs_by_solv(EQUATIONS_MQ[INDEX],TAB_SOLV,ITEMS_VARS) ).to_int();
        if(VALUE==0){SAT_NUM++;}
    }
    return SAT_NUM;
}

bool is_visited(GiNaC::exmap SOLUTION_NOW, std::vector<GiNaC::exmap> VISITED_POINTS)
{
    std::vector<GiNaC::exmap>::iterator ITERATOR;
    ITERATOR = find(VISITED_POINTS.begin(), VISITED_POINTS.end(), SOLUTION_NOW);
    if (ITERATOR == VISITED_POINTS.end()){return false;}
    return true;
}

std::map<GiNaC::exmap,bool> construct_visited_tab( int USED_VARS_NUM, std::vector<GiNaC::symbol> ITEMS_VARS)
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
                SOLUTION_NOW[ITEMS_VARS[INDEX_j]] = ( GiNaC::ex_to<GiNaC::numeric>( SOLUTION_NOW[ITEMS_VARS[INDEX_j]]+1 ).to_int() )%2;
                NEED_ADV = (SOLUTION_NOW[ITEMS_VARS[INDEX_j]]==0);
                continue;
            }
            if(NEED_ADV)
            {
                SOLUTION_NOW[ITEMS_VARS[INDEX_j]] = ( GiNaC::ex_to<GiNaC::numeric>( SOLUTION_NOW[ITEMS_VARS[INDEX_j]]+1 ).to_int() )%2;
                NEED_ADV = (SOLUTION_NOW[ITEMS_VARS[INDEX_j]]==0);
            }
        }
        VISITED_POINTS_TAB[SOLUTION_NOW] = 0;
        //for (int INDEX_j = 0; INDEX_j < USED_VARS_NUM; ++INDEX_j){cout<<SOLUTION_NOW[ITEMS_VARS[INDEX_j]];}
        //cout<<" "<<endl;
    }
    return VISITED_POINTS_TAB;
}

// =======================  Symbols Define  =======================
GiNaC::symbol x0("x0"),x1("x1"), x2("x2"), x3("x3"), x4("x4"), x5("x5"), x6("x6"), x7("x7"), x8("x8"), x9("x9"), x10("x10"), x11("x11"), x12("x12"), x13("x13"), x14("x14"), x15("x15"), x16("x16"), x17("x17"), x18("x18"), x19("x19"), x20("x20"), x21("x21"), x22("x22"), x23("x23"), x24("x24"), x25("x25"), x26("x26"), x27("x27"), x28("x28"), x29("x29"), x30("x30"), x31("x31"), x32("x32"), x33("x33"), x34("x34"), x35("x35"), x36("x36"), x37("x37"), x38("x38"), x39("x39"), x40("x40"), x41("x41"), x42("x42"), x43("x43"), x44("x44"), x45("x45"), x46("x46"), x47("x47"), x48("x48"), x49("x49"), x50("x50"), x51("x51"), x52("x52"), x53("x53"), x54("x54"), x55("x55"), x56("x56"), x57("x57"), x58("x58"), x59("x59"), x60("x60"), x61("x61"), x62("x62"), x63("x63"), x64("x64"), x65("x65"), x66("x66"), x67("x67"), x68("x68"), x69("x69"), x70("x70"), x71("x71"), x72("x72"), x73("x73"), x74("x74"), x75("x75"), x76("x76"), x77("x77"), x78("x78"), x79("x79"), x80("x80"), x81("x81"), x82("x82"), x83("x83"), x84("x84"), x85("x85"), x86("x86"), x87("x87"), x88("x88"), x89("x89"), x90("x90"), x91("x91"), x92("x92"), x93("x93"), x94("x94"), x95("x95"), x96("x96"), x97("x97"), x98("x98"), x99("x99"), x100("x100");
std::vector<GiNaC::symbol> ITEMS_VARS {x0,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31,x32,x33,x34,x35,x36,x37,x38,x39,x40,x41,x42,x43,x44,x45,x46,x47,x48,x49,x50,x51,x52,x53,x54,x55,x56,x57,x58,x59,x60,x61,x62,x63,x64,x65,x66,x67,x68,x69,x70,x71,x72,x73,x74,x75,x76,x77,x78,x79,x80,x81,x82,x83,x84,x85,x86,x87,x88,x89,x90,x91,x92,x93,x94,x95,x96,x97,x98,x99,x100};

int main(int argc, char const *argv[])
{
    srand(time(0));
    clock_t TIME_START, TIME_END;
    long double TIME_COST;
    std::map<string,GiNaC::symbol> MAP_STR_SYMBOL = construct_map(ITEMS_VARS);
    std::vector<GiNaC::ex> EQUATIONS_MQ  = ppsh_read_formulas_from_file("dataset/EQUATIONS_n"+ to_string(MAX_USED_VARS_NUM) +"_m"+ to_string(MAX_EQ_NUM) +"_F1.in",MAP_STR_SYMBOL);
    
    //for (int INDEX_i = 0; INDEX_i < EQUATIONS_MQ.size(); ++INDEX_i){cout<< EQUATIONS_MQ[INDEX_i] <<endl;}
    //return 0;
    
    std::vector<GiNaC::symbol> ITEMS_VARS_USED{&ITEMS_VARS[0], &ITEMS_VARS[0] + MAX_USED_VARS_NUM};
    std::map<GiNaC::exmap,bool> VISITED_POINTS_TAB;

    // ========================== Local Searching ==========================
    GiNaC::exmap SOLUTION_NOW = generating_rand_solv(ITEMS_VARS_USED);bool IS_UPDATED,IS_VISITED;int SAT_NUM_NOW,SAT_NUM_NEXT;int RUNNING_TIMES = 0;
    GiNaC::exmap SOLUTION_NEXT;
    std::vector<GiNaC::exmap> VISITED_POINTS;
    TIME_START = clock();
    while(true)
    {
        SAT_NUM_NOW = computing_sat_num(EQUATIONS_MQ, SOLUTION_NOW, ITEMS_VARS);
        if(SAT_NUM_NOW == MAX_EQ_NUM){break;}
        cout<<"--- RUNNING_TIMES = "<<RUNNING_TIMES<<", SAT_NUM_NOW = "<<SAT_NUM_NOW<<" ---"<<endl;
        IS_UPDATED = false;
        for (int INDEX_i = 0; INDEX_i < MAX_USED_VARS_NUM; ++INDEX_i)
        {
            SOLUTION_NEXT = SOLUTION_NOW;
            SOLUTION_NEXT[ITEMS_VARS_USED[INDEX_i]] = ( GiNaC::ex_to<GiNaC::numeric>( SOLUTION_NEXT[ITEMS_VARS_USED[INDEX_i]]+1 ).to_int() )%2;
            IS_VISITED = (VISITED_POINTS_TAB.count(SOLUTION_NEXT)>0);
            if (IS_VISITED){continue;}
            SAT_NUM_NEXT = computing_sat_num(EQUATIONS_MQ, SOLUTION_NEXT, ITEMS_VARS);
            if(SAT_NUM_NOW < SAT_NUM_NEXT)
            {
                SOLUTION_NOW = SOLUTION_NEXT;IS_UPDATED = true;break;
            }
            VISITED_POINTS_TAB[SOLUTION_NEXT] = true;
        }
        if(!IS_UPDATED)
        {
            IS_VISITED = true;
            while(IS_VISITED)
            {
                SOLUTION_NOW = generating_rand_solv(ITEMS_VARS_USED);
                IS_VISITED = (VISITED_POINTS_TAB.count(SOLUTION_NOW)>0);
            }
        }
        VISITED_POINTS_TAB[SOLUTION_NOW] = true;
        RUNNING_TIMES++;
    }
    TIME_END = clock();
    TIME_COST = (long double)(TIME_END - TIME_START) / CLOCKS_PER_SEC;
    cout << "Cost Time:" << TIME_COST << "s" << endl;
}
