//This file was generated from UPPAAL 3.6 Beta 1-pre1 (rev. 1625), Mar 2006

/*
Mutex requirement.
*/
A[] forall (i:pid_t) forall (j:pid_t) P(i).cs && P(j).cs imply i==j

/*

*/
//NO_QUERY
