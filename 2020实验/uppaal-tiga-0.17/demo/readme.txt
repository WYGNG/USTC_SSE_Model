Demo examples:
==============

concur05: Example used in the paper
Efficient On-the-fly Algorithms for the Analysis of Timed Games,
Franck Cassez, Alexandre David, Emmanuel Fleury, Kim G. Larsen,
and Didier Lime.
In Proceedings of the 16th CONCUR Conference,
August 2005, pages 66-80, LNCS 3653.

prodcell-*: Production cell example configured
by default with 5 plates. You can change this
easily by modifying the constant PLATES. If you
set it to 1 the model will always be controllable
even if the name says it is not.
Configurations:
 control-det       controllable deterministic
 control-nondet    controllable non-deterministic
 uncontrol-det     uncontrollable deterministic
 uncontrol-nondet  uncontrollable non-deterministic
The model is said to be (non-)deterministic with
respect to timing constraints, i.e., if there are
uncertainties or not.

toy-*: Simple toy example to demonstrate
a number of simple cases. Some of them may
surprise you.

rescue-*: Variants of a simple example to
show more cases. In particular some of them
have strategies for the opponent that are
zeno loops, which cannot be avoided by the
tool at the moment unless the model is tweaked.
