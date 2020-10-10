//This file was generated from (Academic) UPPAAL 4.1.4 (rev. 4598), October 2010

/*
Using the Invariant to establish the overall property.
*/
refinement : ( SS7 || N0 ) <= S0

/*

*/
//NO_QUERY

/*

*/
refinement : ( SS6 || N7 ) <= SS7

/*

*/
refinement : ( SS5 || N6 ) <= SS6

/*

*/
refinement : ( SS4 || N5 ) <= SS5

/*

*/
refinement : ( SS3 || N4 ) <= SS4

/*

*/
refinement : ( SS2 || N3 ) <= SS3

/*

*/
refinement : ( SS1 || N2 ) <= SS2

/*

*/
refinement :   N1 <= SS1

/*

*/
//NO_QUERY

/*

*/
refinement : (N1 || N2) <= SS2

/*

*/
refinement : (N1 || N2 || N3) <= SS3

/*
Very expensive to check.
*/
refinement : (N1 || N2 ||  N3 || N4 ) <= SS4

/*

*/
//NO_QUERY

/*
Too expensive to check.
*/
refinement  :  ( N0 || N1 || N2 || N3 || N4 || N5 || N6 || N7  ) <= S0
