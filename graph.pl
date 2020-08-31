:- dynamic cache/3.         

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

move( Here, Here ) :- fail.
move( Here, There) :-
   concrete(There), person(There),
   concrete(Here ), person(Here ).

start(Here)       :-
   concrete(Here),  person(Here ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

path(Here, Here) :-
   fail.

path(Here, There) :-
   path(Here, There, _).

path(Here, Here, [Here]) :-
   fail.
%   start(Here),
%      format("   .> path(~w, ~w, ~w)\n",
%             [Here, Here, [Here]]).

path(Here, There, Path) :-
   (
      start(Here),
      search([], Here, There, Tmp),
      reverse([There|Tmp], Path),
      format(" .oO> path(~w, ~w, ~w)\n",
             [Here, There, Path])
   ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% search( _, Here, Here, _) :-
%   fail.

search( Build, Here, There, Path) :-
   (
      found(Build, Here, There, Path)
   ;  descend([Here|Build], Here, There, Path)
   ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

found(Build, Here, Here, Path) :-
   Path = Build.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

descend(_, Here, Here,  _) :-
   fail.

descend(Build, Here, There,  Path) :-
   move(Here, Next), 
   Here \== Next,
   not(member(Next, Build)),
   search(Build, Next, There, Path).
