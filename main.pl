:- initialization(main).
:- consult("graph.pl").
:- consult("setup.pl").
:- consult("infer.pl").

main :-
   set_prolog_flag(answer_write_options,[max_depth(100)]),
   setup. %,
%   paths;
%   true.

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

desires        :- desires(_,_,_).
desires(P,A,X) :- would(P,A,X),
                  format("~w would ~w ~w.\n", [P,A,X]),
                  fail.  

paths         :- paths(_,sybil,_).
paths(W,T,P)  :- path(W,T,P),
                 % format("~w -> ~w: ~w\n", [W,T,P]),
                 fail.
