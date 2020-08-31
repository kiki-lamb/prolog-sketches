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

path(Here, Here, [Here]) :-
   fail.

:- dynamic cached_path/3. 

path(Here, There, Path) :-
   (
      cached_path(Here, There, Path),
      format(" ...> cached_path(~ws, ~w, ~w)\n",
             [Here, There, Path])
   )
   -> true
   ;
   once((stash_path(Here, There, Path))).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

stash_paths        :-
   stash_paths(_,_,_).

stash_paths(W,T,P) :-
   stash_path(W,T,P),
   fail.

stash_path(Here, There, Path) :-
   (
      search([], Here, There, Tmp),
      reverse([There|Tmp], Path),
      reverse(Path, Rev),
      
      format(" .oO> cached_path(~w, ~w, ~w)\n",
             [Here, There, Path]),
      
      retractall(cached_path(Here, There, Path)),
      assertz(cached_path(Here, There, Path)),

      Here \== There,
      (
         retractall(cached_path(There, Here, Rev)),
         assertz(cached_path(There, Here, Rev))
      )   
   ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

search( Build, Here, There, Path) :-
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
