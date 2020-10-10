/*
Impossible to win.
Property is NOT satisfied.
*/
E<> forall (i:int[0,PLATES-1]) Plate(i).Safe

/*
Possible to lose.
Property is satisfied.
*/
E<> exists (i:int[0,PLATES-1]) Plate(i).BAD

/*
Not sure to win.
Property is NOT satisfied.
*/
A<> forall (i:int[0,PLATES-1]) Plate(i).Safe

/*
Property is NOT satisfied.
*/
control: A[ forall (i:int[0,PLATES-1]) not Plate(i).BAD U forall (i:int[0,PLATES-1]) Plate(i).Safe ]

/*
Property is NOT satisfied.
*/
control: A<> forall (i:int[0,PLATES-1]) Plate(i).Safe

/*
We don't want to lose.
Property is NOT satisfied.
*/
control: A[] not exists (i:int[0,PLATES-1]) Plate(i).BAD

/*
Property is NOT satisfied.
*/
control: A[ forall (i:int[0,PLATES-1]) not Plate(i).BAD W forall (i:int[0,PLATES-1]) Plate(i).Safe ]


