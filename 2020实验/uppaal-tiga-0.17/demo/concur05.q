/*
Winning in goal, no bad specified.
Property is satisfied.
*/
control: A<> Main.goal

/*
Just avoid losing.
Property is satisfied.
*/
control: A[] not Main.L4

/*
Weak winning.
Property is satisfied.
*/
control: A[ not Main.L4 W Main.goal ]

/*
Winning in goal, L4 is losing.
Property is satisfied.
*/
control: A[ not Main.L4 U Main.goal ]

/*
Winning in goal, L4 and L2 are losing.
Property is NOT satisfied.
*/
control: A[ not (Main.L2 or Main.L4) U Main.goal ]

/*
Init is winning.
Property is satisfied.
*/
control: A<> Main.L0

/*
Init is losing.
Property is NOT satisfied.
*/
control: A[ not Main.L0 U Main.goal ]

/*
Init is winning at x==0.
Property is satisfied.
*/
control: A<> (Main.L0 and Main.x==0)

/*
Init is winning at x>0.
Property is NOT satisfied.
*/
control: A<> (Main.L0 and Main.x>0)

/*
Winning through an uncontrollable move.
Property is satisfied.
*/
control: A<> (Main.L4 or Main.L2)

/*
Losing through an uncontrollable move.
Property is NOT satisfied.
*/
control: A[ not Main.L2 U Main.goal ]

/*
Winning in L4.
Property is NOT satisfied.
*/
control: A<> Main.L4

/*
Winning in goal but not too late.
Property is satisfied.
*/
control: A[ not(Main.goal and Main.x>2) U (Main.goal and Main.x==2) ]

/*
Winning in goal with conflicting timings.
Property is NOT satisfied.
*/
control: A[ not(Main.goal and Main.x>2) U (Main.goal and Main.x<2) ]

/*
Winning in goal with trivial timings.
Property is satisfied.
*/
control: A<> Main.goal and Main.x>=2

/*
Winning in goal with conflicting timings
Property is NOT satisfied.
*/
control: A<> Main.goal and Main.x<2

/*
Winning in goal (too) quickly.
Property is NOT satisfied.
*/
control: A[ Main.x<2 U Main.goal ]

/*
Winning in goal without waiting more than needed.
Property is satisfied.
*/
control: A[ Main.x<=2 U Main.goal ]
