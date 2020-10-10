//This file was generated from UPPAAL 3.6 Beta 3 (rev. 1796), April 2006

/*
Fischer's mutual exclusion protocol.
*/
//NO_QUERY

/*
Mutex requirement.
*/
A[] forall (i:id_t) forall (j:id_t) P(i).cs && P(j).cs imply i == j

/*
The system is deadlock free.
*/
A[] not deadlock

/*
Whenever P(1) requests access to the critical section it will eventually enter the wait state.
*/
P(1).req --> P(1).wait

/*

*/
//NO_QUERY
