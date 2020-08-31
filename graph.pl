%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

move( Here, Here ) :- fail.
move( Here, There) :-
   concrete(There), person(There),
   concrete(Here ), person(Here ),
   There \= Here.

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

% path(Here, , Path) :-

:- dynamic cached_path/3. 

path(Here, There, Path) :-
   (
      cached_path(Here, There, Path),
      format(" ...> path(~ws, ~w, ~w)\n",
             [Here, There, Path])
   )
   -> true
   ;
   once(
      (
         path(Here, There, Path),
         stash(Here, There, Path)
      )).

stash_path(Here, There, Path) :-
   (
      start(Here),
      start(There),
      search([], Here, There, Tmp),
      reverse([There|Tmp], Path),
   
      format(" .oO> path(~w, ~w, ~w)\n",
             [Here, There, Path]),
      
      stash(Here, There, Path)
   ).

stash(Here, There, Path) :-
   reverse(Path, Rev),
   retractall(cached_path(Here, There, Path)),
   assertz(cached_path(Here, There, Path)),
   Here \== There,
   (
      retractall(cached_path(There, Here, Rev)),
      assertz(cached_path(There, Here, Rev))
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
   not(member(Next, Build)),
   search(Build, Next, There, Path).
