:- initialization(main).
:- consult("facts.pl").
:- consult("exists.pl").
:- consult("infer.pl").
:- consult("graph.pl").

possible        :- possible(_,_,_).
possible(W,A,T) :- could(W,A,T),
                  format("~w could ~w ~w.\n",
                         [W, A, T]),
                  fail.

possible_paths(P)       :- possible_paths(_,_,_,P).
possible_paths(W,A,T,P) :-
    person(W),
    could(W,A,T,P),
    format("~w could ~w ~w: ~w.\n",
           [W, A, T, P]),
    fail.

desires        :- desires(_,_,_).
desires(P,A,X) :- would(P,A,X),
                  format("~w would ~w ~w.\n", [P,A,X]),
                  fail.  

apaths         :- apaths(_,_,_).
apaths(W,T,P)  :- apath(W,T,P),
                  format("~w -> ~w: ~w\n", [W,T,P]),
                  fail.
    
main           :- apaths ;
                  possible ;
                  true.
