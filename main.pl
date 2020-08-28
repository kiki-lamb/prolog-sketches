%:- initialization loop_a
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

main :- loop; halt(0).
