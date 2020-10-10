//This file was generated from UPPAAL TIGA 4.1.0-0.7 (rev. 2307), June 2006

/*
Property is satisfied.
*/
E<> (forall(i:black_t) Black(i).end) and (forall(i:red_t) Red(i).off)

/*
Property is satisfied.
*/
E<> (forall(i:black_t) Black(i).off) and (forall(i:red_t) Red(i).end)

/*

*/
//NO_QUERY

/*
Property is NOT satisfied.
*/
A<> (forall(i:black_t) Black(i).end) and (forall(i:red_t) Red(i).off)

/*
Property is NOT satisfied.
*/
A<> (forall(i:black_t) Black(i).off) and (forall(i:red_t) Red(i).end)

/*

*/
//NO_QUERY

/*
Property is satisfied.
*/
control: A<> (forall(i:black_t) Black(i).end) and (forall(i:red_t) Red(i).off)

/*
Property is satisfied.
*/
control: A<> (forall(i:black_t) Black(i).off) and (forall(i:red_t) Red(i).end)
