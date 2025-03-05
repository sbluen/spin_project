
#define N 4 //number of nodes
#define L 100 //buffer size, not used anymore
#define true 1
#define false 0
#define WON 100000  //not used anymore

//conditions to check
#define one_leader (nr_leaders<=1)
#define leader_exists (nr_leaders == 1)
#define leader_highest (leader == N)
#define message_performance (msg_count <= 2 * N * logn + N)
#define iter_limit max_iter_count<=2 

/*
typedef array { //used for 2d arrays
    byte a[4];
};
array sent[N];
*/
//byte readindex[N];
//byte writeindex[N];

typedef msg {byte message;};
chan q[N] =[L] of {int}; //message buffers

byte nr_leaders=0;
int leader = 0;
int msg_count = 0;
byte max_iter_count;
int logn = 0;   //log(N) for verification


proctype node(int id_input){
    int id;
    //int readindex=0;
    //int writeindex=0;
    int d=0;
    int e=0;
    int f=0;
    bool announced=false;
    bool bypass=false;
    int prev;
    byte line = 1;
    byte iter_count = 0;

START:

    id = id_input;
    prev = 0;
    if 
        :: (id == 0) -> prev = N - 1;
        :: (id != 0) -> prev = id - 1;
    fi;

    printf("node %d initialized\n", id);

interpret:
if
    :: (line == 1 && bypass == false)-> line = 1 + 1; iter_count++; goto interpret;
    :: (line == 1 && bypass == true)-> line = 1 + 1; bypass=false; goto interpret;

    :: (line == 2 && bypass == false)-> line = 2 + 1; goto interpret;
    :: (line == 2 && bypass == true)-> line = 2 + 1; bypass=false; goto interpret;

    :: (line == 3 && bypass == false)-> line = 3 + 1; goto sendd;
    :: (line == 3 && bypass == true)-> line = 3 + 1; bypass=false; goto interpret;

    :: (line == 4 && bypass == false)-> line = 4 + 1; goto gete;
    :: (line == 4 && bypass == true)-> line = 4 + 1; bypass=false; goto interpret;

    :: (line == 5 && bypass == false)-> 
        if :: (e == id) -> line = 5 + 1;
        :: else -> line = 8;
        fi;
        goto interpret;
    :: (line == 5 && bypass == true)-> line = 5 + 1; bypass=false; goto interpret;

    :: (line == 6 && bypass == false)-> line = 6 + 1; goto announce;
    :: (line == 6 && bypass == true)-> line = 6 + 1; bypass=false; goto interpret;

    :: (line == 7 && bypass == false)-> line = 7 + 1; goto interpret;
    :: (line == 7 && bypass == true)-> line = 7 + 1; bypass=false; goto interpret;

    :: (line == 8 && bypass == false) ->
        if :: (d>e) -> line = 8 + 1;
        :: else -> line = 11;
        fi;
        goto interpret;
    :: (line == 8 && bypass == true)-> line = 8 + 1; bypass=false; goto interpret;

    :: (line == 9 && bypass == false)-> line = 9 + 1; goto sendd;
    :: (line == 9 && bypass == true)-> line = 9 + 1; bypass=false; goto interpret;

    :: (line == 10 && bypass == false)-> line = 13; goto interpret;
    :: (line == 10 && bypass == true)-> line = 10 + 1; bypass=false; goto interpret;

    :: (line == 11 && bypass == false)-> line = 11 + 1; goto sende;
    :: (line == 11 && bypass == true)-> line = 11 + 1; bypass=false; goto interpret;

    :: (line == 12 && bypass == false)-> line = 12 + 1; goto interpret;
    :: (line == 12 && bypass == true)-> line = 12 + 1; bypass=false; goto interpret;

    :: (line == 13 && bypass == false)-> line = 13 + 1; goto getf;
    :: (line == 13 && bypass == true)-> line = 13 + 1; bypass=false; goto interpret;

    :: (line == 14 && bypass == false) ->
        if :: (f == id) -> line = 14 + 1;
        :: else -> line = 17;
        fi;
        goto interpret;
    :: (line == 14 && bypass == true)-> line = 14 + 1; bypass=false; goto interpret;

    :: (line == 15 && bypass == false)-> line = 15 + 1; goto announce;
    :: (line == 15 && bypass == true)-> line = 15 + 1; bypass=false; goto interpret;

    :: (line == 16 && bypass == false)-> line = 16 + 1; goto interpret;
    :: (line == 16 && bypass == true)-> line = 16 + 1; bypass=false; goto interpret;

    :: (line == 17 && bypass == false) ->
    if :: (e >= d && e>= f) -> line = 17 + 1;
    :: else -> line = 20;
    fi;
    goto interpret;
    :: (line == 17 && bypass == true)-> line = 17 + 1; bypass=false; goto interpret;

    :: (line == 18 && bypass == false)-> line = 18 + 1; goto interpret;
    :: (line == 18 && bypass == true) ->line = 18 + 1; bypass=false; goto interpret;

    :: (line == 19 && bypass == false)-> line = 19 + 1; goto interpret;
    :: (line == 19 && bypass == true)-> line = 19 + 1; bypass=false; goto interpret;

//to "receive(d);"
    :: (line == 20 && bypass == false)-> line = 24; goto interpret;
    :: (line == 20 && bypass == true)-> line = 20 + 1; bypass=false; goto interpret;

    :: (line == 21 && bypass == false) ->line = 21 + 1; goto interpret;
    :: (line == 21 && bypass == true) ->line = 21 + 1; bypass=false; goto interpret;

    :: (line == 22 && bypass == false) ->line = 1; goto interpret;
    :: (line == 22 && bypass == true) ->line = 22 + 1; bypass=false; goto interpret;

    :: (line == 23 && bypass == false) ->line = 23 + 1; goto interpret;
    :: (line == 23 && bypass == true) ->line = 23 + 1; bypass=false; goto interpret;

    :: (line == 24 && bypass == false) ->line = 24 + 1; goto getd;
    :: (line == 24 && bypass == true) ->line = 24 + 1; bypass=false; goto interpret;

    :: (line == 25 && bypass == false) ->
    if :: (d == id) -> line = 25 + 1;
    :: else -> line = 28;
    fi;
    goto interpret;
    :: (line == 25 && bypass == true)-> line = 25 + 1; bypass=false; goto interpret;

    :: (line == 26 && bypass == false)-> line = 26 + 1; goto interpret;
    :: (line == 26 && bypass == true)-> line = 26 + 1; bypass=false; goto interpret;

    :: (line == 27 && bypass == false)-> line = 27 + 1; goto interpret;
    :: (line == 27 && bypass == true)-> line = 27 + 1; bypass=false; goto interpret;

    :: (line == 28 && bypass == false) ->line = 28 + 1; goto sendd;
    :: (line == 28 && bypass == true) ->line = 28 + 1; bypass=false; goto interpret;

    :: (line == 29 && bypass == false) ->line = 24; goto interpret;
fi;

n2n:
goto done;


sendd:
q[id]!d;
msg_count++;
bypass=true;
goto interpret;

sende:
q[id]!d;
msg_count++;
bypass=true;
goto interpret;

getd:
q[prev]?d;
/*
if
    :: (d == WON) -> goto done;
    :: (d != WON) -> skip;
fi;
*/
bypass=true;
goto interpret;

gete:
q[prev]?e;
/*
if
    :: (e == WON) -> goto done;
    :: (e != WON) -> skip;
fi;
*/
bypass=true;
goto interpret;


getf:
q[prev]?f;
/*
if
    :: (f == WON) -> goto done;
    :: (f != WON) -> skip;
fi;
*/
bypass=true;
goto interpret;

announce:
announced=true;
nr_leaders++;
leader = id;
//q[id]!WON;
goto done;

done:
//cleanup tasks for verification
atomic{
if :: (iter_count > max_iter_count) -> max_iter_count = iter_count;
:: else
fi;
}

}

init{
    //run node(5);

    int lv;
    int temp = N;
    do
        :: (temp > 0) -> temp = temp / 2; logn++;
        :: (temp == 0) -> break;
    od;
    atomic {
    lv=0;
    do
      :: lv < N -> run node(lv); lv++
      :: lv == N -> break
    od;
  }  
}

never  {    /* [] one_leader */
accept_init:
T0_init:
        do
        :: ((one_leader)) -> goto T0_init
        od;
}
never  {    /* <> leader_exists */
T0_init:
        do
        :: atomic { ((leader_exists)) -> assert(!((leader_exists))) }
        :: (1) -> goto T0_init
        od;
accept_all:
        skip
}
never  {    /* <> leader_highest */
T0_init:
        do
        :: atomic { ((leader_highest)) -> assert(!((leader_highest))) }
        :: (1) -> goto T0_init
        od;
accept_all:
        skip
}
never  {    /* [] message_performance */
accept_init:
T0_init:
        do
        :: ((message_performance)) -> goto T0_init
        od;
}
never  {    /* [] iter_limit */
accept_init:
T0_init:
        do
        :: ((iter_limit)) -> goto T0_init
        od;
}

