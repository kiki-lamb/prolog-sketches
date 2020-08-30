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
  split_string(Line, " ", " ", [First, Second | Others]),
  atomize([First, Second | Others], RAtoms),
  RTerm =.. [r | RAtoms],
  assertz(RTerm),

% atomize([Second, First | Others], Atoms),
% Term  =.. Atoms,
% format("~~=> ~w\n", [Term]),
% assertz(Term),

  aasertify_lines(Lines, Build, Out).

atomize(In, Out)                          :- collect(aatomize, In, Out).
aatomize([], Build, Out)                  :- collect(Build, Out), !.
aatomize([In|Ins], Build, Out)            :-
  atom_codes(Atomic, In),
  aatomize(Ins, [Atomic|Build], Out).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- dynamic r/3.
:- dynamic iz/2.

a(  Obj,           SoughtType) :-
  r( Obj,       a, SoughtType);
  r( Obj,       a, ActualType),
  a(ActualType,    SoughtType).

does(_,   a) :- fail.
does(Obj, Action) :-
  Action \== a,
  r( Obj, Action, _);
  r( Obj, a, Actual), r(Actual, Action, _).
  
main :-
  retractall(r(_,_,_)),
  clines(Ls, 'dat2.ssv'),
  assertify_lines(Ls, _),
  listing(r),
  go.

go :-
  (a(kiki, human),
   format("... human.\n", []));
%  spy(r/3),
%  spy(iz/2),
%  trace,
  (a(kiki, animal),
   format("... animal.\n", [])), !, false.



loop :-
  a(X, Y),
  format("~s, ~s.\n", [X, Y]),
  fail.

