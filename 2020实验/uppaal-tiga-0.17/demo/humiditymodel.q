//This file was generated from UPPAAL TIGA 4.1.0-0.7 (rev. 2307), June 2006

/*

*/
control : A[] ZC.Decided imply forall (c0 : choice_t)\
	                      forall (c1 : choice_t)\
	                      forall (in : intbool_t)\
	                      forall (out : intbool_t)\
	                      forall (heat : intbool_t) (flow_balance(c0,c1,in,out) imply obj_func >= compute_objective_function(c0,c1,in,out,heat))
