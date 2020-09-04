%:- initialization(main).
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


%-----------------------------------------------------------

possible          :- possible(_,_,_,_).
possible(P)       :- possible(_,_,_,P).
possible(W,A,T,P) :-
   could(W,A,T,[_|P]),
   singular(A, SA),
   add_spaces(SA, SAA),
   smart_capitalize(W, WUC),
   smart_capitalize(T, TUC),
   format("~w could ~w ~w.\n",
          [WUC, SAA, TUC]),
%   format("~w could ~w ~w via ~w.\n",
%           [W, SAA, T, P]),
   fail.
%-----------------------------------------------------------

possible_paths          :- possible_paths(_,_,_,_).
possible_paths(P)       :- possible_paths(_,_,_,P).
possible_paths(W,A,T,P) :-
   could(W,A,T,[_|P]),
   singular(A, SA),
   add_spaces(SA, SAA),
   smart_capitalize(W, WUC),
   smart_capitalize(T, TUC),
   format("~w could ~w ~w via ~w.\n",
           [WUC, SAA, TUC, P]),
%   format("~w could ~w ~w via ~w.\n",
%           [W, SAA, T, P]),
   fail.

%-----------------------------------------------------------

looperp(Func) :-
   call(Func, Something),
   format("  -  ~w.\n", [Something]),
   fail.

%-----------------------------------------------------------

desires        :- desires(_,_,_).
desires(P,A,X) :-
   would(P,A,X),
   format("~w would ~w ~w.\n", [P,A,X]),
   fail.

%-----------------------------------------------------------

singular(In, Out) :-
   re_replace("s$", "", In, Out).

add_spaces(In, Out) :-
   re_replace("_", " ", In, Out).
   
capitalize(WordLC, WordUC) :-
    atom_chars(WordLC, [FirstChLow|LWordLC]),
    atom_chars(FirstLow, [FirstChLow]),
    upcase_atom(FirstLow, FirstUpp),
    atom_chars(FirstUpp, [FirstChUpp]),
    atom_chars(WordUC, [FirstChUpp|LWordLC]).

smart_capitalize(In, Out) :-
   (person(In); store(In)),
   capitalize(In, Out), !.

smart_capitalize(Out, Out).
