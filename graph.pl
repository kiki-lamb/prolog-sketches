:- dynamic cache/3.         

start(Here)       :- human(Here).
move( Here, Here) :- fail.
move( _,   There) :- human(There).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

path(Here, There) :-
   path(Here, There, _).

path(Here, Here, [Here]) :-
   human(Here),
      format("   .> path(~w, ~w, ~w)\n",
             [Here, Here, [Here]]).

path(Here, There, Path) :-
   (
      human(Here),                  
      human(There),
      Here \== There,
      
      search([], Here, There, Tmp),
      reverse([There|Tmp], Path),
      format(" .oO> path(~w, ~w, ~w)\n",
             [Here, There, Path])
   ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

search( Build, Here, There, Path) :-
   (
      found(Build, Here, There, Path)
   ;  descend([Here|Build], Here, There, Path)
   ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

found(Path, Here, Here, Path).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

descend(_, Here, Here,  _) :-
   false.

descend(Build, Here, There,  Path) :-
   human(Next),
   Here \== Next,
   not(member(Next, Build)),
   search(Build, Next, There, Path).
