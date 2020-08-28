%:- initialization loop_a
:- consult("facts.pl").
:- consult("graph.pl").
 
a(Appliance, break,  [])   :- appliance(Appliance), \+ could(    _,      repair, Appliance).
a(Person,    starve, [])   :- person(   Person   ), \+ could(    Person, eat,    _).
a(Person,    repair, X)    :- human(    Person   ),    appliance(X),     path(   Person, nail).
a(Person,    eat,    X)    :- person(   Person   ),    thing(    X),     eat(    Person, X).
a(Person,    drink,  X)    :- person(   Person   ),    thing(    X),     drink(  Person, X).
a(Person,    smoke,  X)    :- person(   Person   ),    thing(    X),     smoke(  Person, X).
a(Person,    shop,   X)    :- person(   Person   ),    store(    X),     shop(   Person, X).
a(Person,    chase,  X)    :- cat(      Person   ),    cat(      X),     chase(  Person, X).

could(   Person, Action, Thing      )   :- could(Person, Action, Thing, _).
could(   Person, Action, Thing, Path)   :-
    a(   Person, Action, Thing      ),
    path(Person, Thing,  Path       ).

loop :-
    could(W,A,T,P),
    format("~w could ~w ~w: ~w.\n", [W, A, T, P]),
    fail.

loop_a :-
    a(P,A,X),
    format("~w could ~w ~w.\n", [P,A,X]),
    fail.

main :- loop; halt(0).
