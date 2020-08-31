:- dynamic cache/3.         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

start(X) :- human(X). 

move(To, To) :- fail.
move(From,  To) :- human(To), From \== To.

stop(To, To).
stop(_,   _) :- fail.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

path(Start, Here, Move, To, Stop) :-
   path(Start, Here, Move, To, Stop, _).

path(Start, Here, Move, To, Stop, Path) :-
   (
      call(Start, Here),
      search([], Here, Move, To, Stop, Tmp),
      reverse([To|Tmp], Path)
   ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

search( Build, Here, Move, To, Stop, Path) :-
   (
      found(Build, Here, To, Stop, Path)
   ;  descend([Here|Build], Here, Move, To, Stop, Path)
   ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

found(Build, Here, Here, _, Path) :-
   format("Found Final.\n", []),

   Path = Build.

found(Build, Here, To, Stop, Path) :-
   format("Found.\n", []),

   call(Stop, Here, To),
   found([Here|Build], Here, Here, Stop, Path).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

descend(Build, Here, Move, To,   Stop, Path) :-
   call(Move, Here, Next),
   not(member(Next, Build)),
   search(Build, Next, Move, To, Stop, Path).
