:- dynamic cache/3.         

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

move( Here, Here) :- fail.
move( _,   There) :- /* concrete(There), */ person(There).
start(Here)       :- /* concrete(Here),  */ person(Here).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

path(Here, Here) :-
   fail.

path(Here, There) :-
   path(Here, There, _).

path(Here, Here, [Here]) :-
   start(Here),
      format("   .> path(~w, ~w, ~w)\n",
             [Here, Here, [Here]]).

path(Here, There, Path) :-
   (
      search([], Here, There, Tmp),
      reverse([There|Tmp], Path),
      format(" .oO> path(~w, ~w, ~w)\n",
             [Here, There, Path])
   ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

search( _, Here, Here, _) :-
   fail.

search( Build, Here, There, Path) :-
   (
      found(Build, Here, There, Path)
   ;  descend([Here|Build], Here, There, Path)
   ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

found(Path, Here, Here, Path).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

descend(_, Here, Here,  _) :-
   fail.

descend(Build, Here, There,  Path) :-
   move(Here, Next), 
   Here \== Next,
   not(member(Next, Build)),
   search(Build, Next, There, Path).
