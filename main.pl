:- initialization(main).
:- consult("facts.pl").
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
    
main :- loop_paths; halt(0).
