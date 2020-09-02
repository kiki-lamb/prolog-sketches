%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

move( Here, Here ) :- fail.
move( Here, There) :-
   concrete(There), person(There),
   concrete(Here ), person(Here ),
   There \= Here.

start(Here)       :-
   concrete(Here),  person(Here ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

path(Here, There) :-
   path(Here, There, _).

%path(Here, Here, [Here]) :-
%   fail.

:- dynamic cached_path/3. 

path(Here, There, Path) :-
   (try_path(Here, There, Path)) ->
      true
   ;  once((
         (stash_path(Here, There, Path)),
         true
      )),
      try_path(Here, There, Path).

try_path(Here, There, Path) :-
   cached_path(Here, There, Path)
   ;  cached_path(There, Here, Tmp),
      reverse(Tmp, Path).   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

stash_paths        :-
   stash_paths(_,_,_).

stash_paths(W,T,P) :-
   stash_path(W,T,P),
   fail.

log_paths :-
   cached_path(Here, There, Path),
   format("   .oO> cached_path(~w, ~w, ~w)\n",
          [Here, There, Path]),
   fail.
   
log_paths_count :-
   bagof([X,Y,Z], (cached_path(Z,Y,X)), Tmp),
   length(Tmp, Count),
   format("        Charted ~w paths.\n\n", [Count]).

stash_path(Here, There, Path) :-
   search(Here, There, Path),
   Here @> There,
   \+ ( try_path(Here, There, Path)),
     retractall(cached_path(Here, There, _)),
   assertz(cached_path(Here, There, Path)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

search(Here, There, Path) :-
   search([], Here, There, Tmp),
   reverse([There|Tmp], Path).

search(Build, Here, There, Path) :-
   (
      start(Here),
      start(There),
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