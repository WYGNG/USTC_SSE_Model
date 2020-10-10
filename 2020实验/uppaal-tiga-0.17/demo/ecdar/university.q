//This file was generated from (Academic) UPPAAL 4.1.4 (rev. 4598), October 2010

/*
You need to have University, Machine, and Researcher defined in your system.
Check if this composition obeys the definition of a specification.
*/
specification: (University || Machine || Researcher)

/*
You need to have Spec defined in your system.
Check if Spec obeys the definition of a specification.
*/
specification: Spec

/*
You need to have University, Machine, and Researcher defined in your system.
Check if this composition is consistent, i.e., admits implementations.
*/
consistency: (University || Machine || Researcher)

/*
You need to have University, Machine, and Researcher defined in your system.
Check if this composition is consistent, i.e., admits implementations with an added TCTL constraint.
*/
consistency: (University || Machine || Researcher : A[] not Researcher.Stuck)

/*
You need to have University, Machine, Researcher, and Spec defined in your system.
Check if the composition is a refinement of Spec.
*/
refinement: (University || Machine || Researcher) <= Spec

/*
You need to have HalfUni1, HalfUni2, Machine, Researcher, and Spec defined in your system.
Check if the composition is a refinement of Spec.
*/
refinement: ((HalfUni1 && HalfUni2) || Machine || Researcher) <= Spec
