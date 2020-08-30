:- use_module(library(pio)).

lliness([])                              --> call(eos), !.
lliness([CLine|Lliness])                 --> cline(CLine), lliness(Lliness).

eos([], []).

cline([])                                --> ( ".\n" ; call(eos) ), !.
cline([L|Ls])                            --> [L], cline(Ls).

clines(Ls, File)                          :- phrase_from_file(lliness(Ls), File).

collect(Build, Out)                       :- Out = Build.
collect(Using, In, Out)                   :-
  G =.. [ Using, In, [], Tmp ],
  call(G),
  reverse(Tmp, Out).

assertify_lines(In, Out)                  :- collect(aasertify_lines, In, Out).
aasertify_lines([], Build, Out)           :- collect(Build, Out), !.
aasertify_lines([Line|Lines], Build, Out) :-
  split_string(Line, " ", " ", Words),
  atomize(Words, [A1, A2, A3 | Atoms]),
  Term =.. [r, A1, A2, A3, Atoms],
  assertz(Term),
  aasertify_lines(Lines, Build, Out).

atomize(In, Out)                          :- collect(aatomize, In, Out).
aatomize([], Build, Out)                  :- collect(Build, Out), !.
aatomize([In|Ins], Build, Out)            :-
  atom_codes(Atomic, In),
  aatomize(Ins, [Atomic|Build], Out).

