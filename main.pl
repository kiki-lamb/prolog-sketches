:- initialization(main).
:- consult("graph.pl").
:- consult("facts.pl").
:- consult("exists.pl").
:- consult("infer.pl").

possible :-
    could(W,A,T),
    format("~w could ~w ~w.\n", [W, A, T]),
    fail.

possible_paths :-
    person(W),
    could(W,A,T,P),
    format("~w could ~w ~w: ~w.\n", [W, A, T, P]),
    fail.

desires :-
    a(P,A,X),
    format("~w would ~w ~w.\n", [P,A,X]),
    fail.  

loop_paths :-
    path(_,_,P),
    format("~w\n", [P]),
    fail.

ploop_paths :-
    path(W,T,P),
    format("~w -> ~w: ~w\n", [W,T,P]),
    fail.

ploop_person_paths :-
    person(W), path(W,T,P), 
    format("~w -> ~w: ~w\n", [W,T,P]),
    fail.
    
main :- ploop_person_paths; true. % halt.
