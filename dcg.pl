% :- initialization(main).
:- use_module(library(pio)).
:- use_module(library(dcg/basics)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grammar.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


lines([])     --> end_of_sequence, !.
lines([[L]|Ls]) --> line(L),
                  lines(Ls).

line([])      --> end_of_sequence, !.
line([])      --> ".\n", !.
line([L|Ls])  --> word(L),
                  line(Ls).


words([])     --> end_of_sequence, !.
words([L|Ls]) --> word(L),
                  words(Ls).

word([])      --> end_of_sequence, !.
word([])      --> " ", !.
word([])      --> ".", !.
word([L|Ls])  --> [L], word(Ls).


end_of_sequence([], []).

ml(L, L2)  :- maplist(string_codes, L, L2).
mll(L, L2) :- maplist(ml, L, L2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

main :-
   phrase_from_file(lines(Lines), "tiny.ssv"),
   nl,
   write(Lines),
   nl, nl,
   maplist(mll, Lines2, Lines),
   nl,
   write(Lines2),
   nl, nl.

