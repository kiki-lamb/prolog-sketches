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
    %person(W),
    path(boson,T,P), 
    format("~w -> ~w: ~w\n", [boson,T,P]),
    fail.
    
main :- ploop_paths; true. % halt.
