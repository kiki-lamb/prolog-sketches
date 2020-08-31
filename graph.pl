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
      start(Here),
      start(There),
      search([], Here, There, Tmp),
      reverse([There|Tmp], Path),
      reverse(Path, Rev),

      format(" .oO> path(~w, ~w, ~w)\n",
             [Here, There, Path]),

      
      assertz(cached_path(Here, There, Path)),
      assertz(cached_path(There, Here, Rev))
   ).

sspath(Here, There, Path) :-
   spath(Here, There, Path).

spath(Here, There, Path) :-
   (
      cached_path(Here, There, Path),
      format(" ...> path(~w, ~w, ~w)\n",
             [Here, There, Path])
   )
   -> true
   ;
   once(
      (
         reverse(Path, Rev),
         path(Here, There, Path),
         assertz(cached_path(Here, There, Path)),
         assertz(cached_path(There, Here, Rev))
      )).


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
