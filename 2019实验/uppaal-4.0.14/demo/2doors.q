//This file was generated from UPPAAL 3.3.35, Mar 2003

/*
971204, Kim G. Larsen, Fredrik Larsson, Paul Pettersson & Arne Skou,
     at Fairmont Hotel, San Francisco, USA.
971208, Paul, finalized, in the air between San Francisco and London.
011015, Paul, added deadlock and livness properties.

TWO DOORS

This example was suggested to us by Alan Burns at RTSS'97. 

DESCRIPTION: A room has two doors which can not be open at the same
time.  A door starts to open if its button is pushed. The door opens
for six seconds, thereafter it stays open for at least four seconds,
but no more than eight seconds. The door takes six seconds to close
and it stays closed for at least five seconds.

EXERCISE: Model the system, write a requirement specification that shows 
that the system enjoys the mutex property (i.e. the two doors are never
open at the same time), also derive an upper bound for a door to open
(completely) after its button has been pushed, and show that the upper
bound is the least upper bound.

COMMENTS: The following assumptions are used in our model:
(i)  A door button should not be pushed while the door is opening, 
     open (or closing).
(ii) An upper bound is needed in location "closed", i.e. when the door 
     delays after it has been closed.

*/
//NO_QUERY

/*
Mutex: The two doors are never open at the same time.
*/
A[] not (Door1.open and Door2.open)

/*
Bounded Liveness: A door will open within 31 seconds.
*/
A[] (Door1.opening imply User1.w<=31) and \
    (Door2.opening imply User2.w<=31)

/*
Door 1 can open.
*/
E<> Door1.open

/*
Door 2 can open.
*/
E<> Door2.open

/*
Liveness: Whenever a button is pushed, the corresponding door will eventually open.
*/
Door1.wait --> Door1.open

/*

*/
Door2.wait --> Door2.open

/*
The system is deadlock-free.
*/
A[] not deadlock
