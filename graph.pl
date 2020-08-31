:- dynamic cache/3.         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

start(X) :- human(X). 

move(To, To) :- fail.
move(From,  To) :- human(To), From \== To.

stop(To, To).
stop(_,   _) :- fail.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

path(Here, To, Stop) :-
   path(Here, To, _).

path(Here, To, Path) :-
   (
      call(Start, Here),
      search([], Here, To, Tmp),
      reverse([To|Tmp], Path)
   ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

search( Build, Here, To, Path) :-
   (
      found(Build, Here, To, Path)
   ;  descend([Here|Build], Here, To, Path)
   ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

found(Build, Here, Here, _, Path) :-
   format("Found Final.\n", []),

   Path = Build.

found(Build, Here, To, Path) :-
   format("Found.\n", []),

   call(Here, To),
   found([Here|Build], Here, Here, Path).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

descend(Build, Here, To,   Path) :-
   call(Here, Next),
   not(member(Next, Build)),
   search(Build, Next, To, Path).
