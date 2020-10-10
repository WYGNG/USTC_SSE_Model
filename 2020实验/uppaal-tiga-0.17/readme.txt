Readme for UPPAAL-TIGA 4.1.11-0.17.
Uppsala University and Aalborg University.
Copyright (c) 1995 - 2002. All right reserved.

June 27th, 2012

1. Introduction
2. Installation
3. TIGA features
4. License Agreement

1. Introduction
===============

This is a development snapshot 4.1.11-0.17 of UPPAAL-TIGA -- a model checker
for timed game automata -- that will eventually lead to a new stable
release.

Note that UPPAAL-TIGA is free for non-profit applications but we want all
users to fill in a license agreement. This can be done online on the
web site http://www.uppaal.com/ or by sending in the form attached
below.

This product includes software developed by the Apache Software
Foundation (http://www.apache.org/).


2. Installation
===============

To install, unzip the zip-file uppaal-tiga-0.17.zip. This should create
the directory uppaal-tiga-0.17 containing at least the files tiga,
uppaal.jar, and the directories lib, bin-Linux, bin-Win32, and demo.
The bin-directories should all contain the two
files verifytga(.exe) and server(.exe) plus some additional files, 
depending on the platform. The demo-directory should contain some 
demo files with suffixes .xml and .q.

Note that UPPAAL-TIGA will not run without Java 6 or later installed on
the host system. Java 6 for SunOS, Windows95/98/Me/NT/2000/XP, and Linux
can be downloaded from http://java.sun.com.

To run UPPAAL-TIGA on Linux systems run the tiga script. To
run on Windows95/98/Me/NT/2000/XP systems double click the file
uppaal.jar. SunOS binaries will probably be available later.


3. TIGA Features
================

A timed game automaton is a timed automaton with transitions that can
be marked as controllable or uncontrollable. When marked controllable,
a transition can be fired by the controller whenever it is a valid
transition. When marked uncontrollable, a transition is under the
control of the environment and will be fired when the other player
wants to (obviously at the worst time for the controller). The
graphical user interface allow you to set the transitions to be
(un)controllable through the transition editor (tick box).

Specification of the winning conditions are performed in the
"verifier" part of UPPAAL-TIGA. First of all, you can still use the
classical formulae to check accessibility and/or liveness as in a
normal Uppaal engine. Indeed, prefixing the formula with the keyword
"control:" means that UPPAAL-TIGA will look for a strategy for the
controller to enforce the following formula to be true whatever the
opponent do. Until now we have defined four types of games:

Simple Reachability: We must reach 'win'.

        control: A<> win

Reachability with Avoidance: We must reach 'win' and avoid 'lose'

        control: A[ not lose U win ]

Weak Reachability: We may reach 'win' and must avoid 'lose'

        control: A[ not lose W win ]

Safety: We must avoid 'lose'

        control: A[] not lose

Example:
        control: A[ not (Main.L2 or Main.x>4) U Main.goal ]

Cooperative strategies:
        E<> control: prop
        where prop is any of the above properties.
        A cooperative strategy will suggest moves from the opponent
        or moves of the controller that should be allowed by the
        opponent to reach states from which there is a strategy.
        The output is a partitioning of the states between cooperative
        moves and non-cooperative moves (ordinary strategy).

Time optimal control:
        control_t*(u,g): prop
        where - prop is A<> win or A[ not lose U win ].
              - u is an upper-bound to prune the search that acts
                like an invariant but on the path.
              - g is the time to the goal from the current state
                (a lower-bound), also used to prune the search.
                States with t+g > u are pruned

Simulation checking:
        { A, B,... } <= { C,D,... }
  or    { C, D,... } >= { A,B,... }
Example: Define a system with processes A,B,C,D s.t. they do not
have loops with tau transitions. The actions used to check for
simulation are the synchronizations. Both systems (left and right)
are considered open for the purpose of simulation. When internal
synchronizations are possible, they are still visible actions
that should be matched by equivalent internal synchronizations.
The channels used must be the same. Avoid to mix up variables
between {A,B} and {C,D}. Do not define tau actions in {C,D} (no
synchronization) if you check {A,B} <= {C,D}.

Specific TIGA options
---------------------

  -o <0|1>
      Select order for forward search.
        0: Breadth first (default)
        1: Depth first
  -O <0|1>
      Select order for backward search. Default 1.
        0: Breadth first
        1: Depth first (default)
  -F <0|1|2|3|4>
      Select search priority between forward and backward.
        0: Automatic (default); reachability = -o0O1F3; safety = -o0O0F2
        1: Mixed search, i.e., one queue
        2: Forward first
        3: Backward first
        4: Alternate forward/backward
  -P Activate pruning for TIGA reachabibility properties,
     but counter-strategies will not be available and state-space
     reuse is ignored for these properties.
  -t0 Generate some strategy.
  -w <0|1|2>
      In conjunction with -t0 and no E<> control: or time optimal properties,
      define the type of output.
        0: A strategy (default)
        1: All winning actions of the current result (the search ends as soon
           as the initial state is known to be losing or winning)
        2: All winning actions of all the states (explore them all)



4. License Agreement
====================

By registering and downloading UPPAAL-TIGA you agreed to the following
agreement. You have to register to use the tool.
                                              
We (the licensee) understand that UPPAAL-TIGA includes the programs:
uppaal.jar, tiga, server, socketserver, verifytga,
and that they are supplied "as is", without expressed or
implied warranty. We agree on the following:

1. You (the licensers) do not have any obligation to provide any
   maintenance or consulting help with respect to UPPAAL-TIGA. 

2. You neither have any responsibility for the correctness of systems
   verified using UPPAAL-TIGA, nor for the correctness of UPPAAL-TIGA itself.

3. We will never distribute or modify any part of the UPPAAL-TIGA code
   (i.e. the source code and the object code) without a written
   permission of Wang Yi (Uppsala University) or Kim G Larsen (Aalborg
   University).
   
4. We will only use UPPAAL-TIGA for non-profit research purposes. This
   implies that neither UPPAAL-TIGA nor any part of its code should be used
   or modified for any commercial software product.

In the event that you should release new versions of UPPAAL-TIGA to us, we
agree that they will also fall under all of these terms.
