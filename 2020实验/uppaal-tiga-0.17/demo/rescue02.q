//This file was generated from UPPAAL 4.0.0-pre2 (rev. 1834), May 2006

/*
Opponent can stay in init forever.
Property is NOT satisfied.
*/
control: A[ not Plane.Crashed U Plane.Saved ]

/*
Opponent can stay in init forever.
Property is NOT satisfied.
*/
control: A<> Plane.Saved

/*
Property is satisfied.
*/
E<> Plane.Saved

/*
Property is satisfied.
*/
E<> Plane.Crashed
