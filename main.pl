:- initialization(main).
:- consult("facts.pl").
:- consult("exists.pl").
:- consult("graph.pl").
 
loop :-
    could(W,A,T,P),
    format("~w could ~w ~w: ~w.\n", [W, A, T, P]),
    fail.

loop_a :-
    a(P,A,X),
    format("~w could ~w ~w.\n", [P,A,X]),
    fail.

loop_paths :-
    path(_,_,P),
    format("~w\n", [P]),
    fail.

ploop_paths :-
    typed_path(person,W,T,P),
    format("~w -> ~w: ~w\n", [W,T,P]),
    fail.
    
main :- ploop_paths; true.
