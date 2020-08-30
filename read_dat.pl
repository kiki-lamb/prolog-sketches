:- initialization(main).
:- use_module(library(pio)).
:- consult("file_reader.pl").

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
  clines(Ls, 'dat.ssv'),
  retractall(r(_,_,_)),
  retractall(r(_,_,_,_)),
  retractall(r(_,_,_,_,_)),
  retractall(r(_,_,_,_,_,_)),
  assertify_lines(Ls, _),
  listing(r).

