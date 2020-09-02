:- initialization(main).
:- consult("setup.pl").
:- consult("moves.pl").
:- consult("graph.pl").
:- consult("graph-caching.pl").
:- consult("infer.pl").

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

main :- 
   setup("dat.ssv"),
   nl,
   (
      possible_paths
   ;  true
   ),
   nl.


possible        :- possible(_,_,_).
possible(W,A,T) :-
   could(W,A,T),
   singular(A, SA),
   format("~w could ~w ~w.\n",
          [W, SA, T]),
   fail.

possible_paths          :- possible_paths(_,_,_,_).
possible_paths(P)       :- possible_paths(_,_,_,P).
possible_paths(W,A,T,P) :-
   could(W,A,T,[_|P]),
   singular(A, SA),
   format("~w could ~w ~w via ~w.\n",
           [W, SA, T, P]),
   fail.

looperp(Func) :-
   call(Func, Something),
   format("  -  ~w.\n", [Something]),
   fail.

desires        :- desires(_,_,_).
desires(P,A,X) :-
   would(P,A,X),
   format("~w would ~w ~w.\n", [P,A,X]),
   fail.

singular(In, Out) :-
   re_replace("s$", "", In, Out).

