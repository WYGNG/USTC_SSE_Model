//This file was generated from (Academic) UPPAAL 4.1.4 (rev. 4598), October 2010

/*
Holds by definition. Same as G1 <= Q.
*/
refinement: G1 <= ((A1 || G2) \ A2)

/*
Same as Q <= G1, here not satisfied.
*/
refinement: ((A1 || G2) \ A2) <= G1

/*
Same as Q <= Imp.
*/
refinement:  ((A1 || G1) \ A2) <= Imp

/*
Same as Imp <= Q.
*/
refinement: Imp <= ((A1 || G1) \ A2)

/*
Holds iff Q <= Imp.
*/
refinement: (A1 || G1) <= (A2 || Imp)

/*
Holds iff Imp <= Q.
*/
refinement: (A2 || Imp) <= (A1 || G1)

/*

*/
refinement: G1 <= Imp

/*

*/
refinement: Imp <= G1

/*
Holds by definition.
*/
refinement: G1 <= Q

/*

*/
refinement: Q <= G1

/*

*/
refinement: Q <= Imp

/*

*/
refinement: Imp <= Q
