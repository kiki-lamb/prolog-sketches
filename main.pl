:- initialization(setup("dat.ssv")).
:- consult("setup.pl").
:- consult("moves.pl").
:- consult("graph.pl").
:- consult("infer.pl").
:- debug.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

possible        :- possible(_,_,_).
possible(W,A,T) :- could(W,A,T),
                   format("~w could ~w ~w.\n",
                          [W, A, T]),
                   fail.

possible_paths          :- possible_paths(_,_,_,_).
possible_paths(P)       :- possible_paths(_,_,_,P).
possible_paths(W,A,T,P) :-
    could(W,A,T,P),
    format("~w could ~w ~w: ~w.\n",
           [W, A, T, P]),
    fail.

looperp(Func) :-
   call(Func, Something),
   format("  -  ~w.\n", [Something]),
   fail.

desires        :- desires(_,_,_).
desires(P,A,X) :- would(P,A,X),
                  format("~w would ~w ~w.\n", [P,A,X]),
                  fail.  
