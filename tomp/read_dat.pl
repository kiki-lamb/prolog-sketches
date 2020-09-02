:- initialization(main).
:- use_module(library(pio)).
:- consult("file_reader.pl").

a(   Obj,           SoughtType) :-
  r( Obj,       a, SoughtType);
  r( Obj,       a, ActualType),
  a(ActualType,    SoughtType).

does(_,   a) :- fail.
does(Obj, Action) :-
  Action \== a,
  r( Obj, Action, _);
  r( Obj, a, Actual), r(Actual, Action, _).
  
main :-
  assertify_lines('dat.ssv'),
  listing(r).

loop :-
  r(Q, W, E, R),
  format("+=> r(~w, ~w, ~w, ~w.\n", [Q, W, E, R]),
  fail.
