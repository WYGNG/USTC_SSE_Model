//This file was generated from UPPAAL 4.0.2 (rev. 2491), August 2006

/*
===== Validation Properties:
*/
//NO_QUERY

/*
Gate can receive (and store in queue) msg's from approaching trains.
*/
E<> Gate.Occ

/*
Train 0 can reach crossing.
*/
E<> Train(0).Cross

/*
Train 1 can reach crossing.
*/
E<> Train(1).Cross

/*
Train 0 can be crossing bridge while Train 1 is waiting to cross.
*/
E<> Train(0).Cross and Train(1).Stop

/*
Train 0 can cross bridge while the other trains are waiting to cross.
*/
E<> Train(0).Cross and (forall (i : id_t) i != 0 imply Train(i).Stop)

/*
===== Safety Properties:
*/
//NO_QUERY

/*
There is never more than one train crossing the bridge (at
any time instance).
*/
A[] forall (i : id_t) forall (j : id_t) Train(i).Cross && Train(j).Cross imply i == j

/*
There can never be N elements in the queue (thus the array will not overflow).
*/
A[] Gate.list[N] == 0

/*
===== Liveness Properties:
*/
//NO_QUERY

/*
Whenever a train approaches the bridge, it will eventually cross.
*/
Train(0).Appr --> Train(0).Cross\
\


/*

*/
Train(1).Appr --> Train(1).Cross

/*

*/
Train(2).Appr --> Train(2).Cross

/*

*/
Train(3).Appr --> Train(3).Cross

/*

*/
Train(4).Appr --> Train(4).Cross

/*

*/
Train(5).Appr --> Train(5).Cross

/*
===== Deadlock checking:
*/
//NO_QUERY

/*
The system is deadlock-free.
*/
A[] not deadlock
