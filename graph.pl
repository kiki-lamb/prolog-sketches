:- dynamic cached_path/3. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

path(Here, There) :-
   path(Here, There, _).

path(Here, There, Path) :-
   (try_cached_path(Here, There, Path)) ->
      true
   ;  once(
         (
            (cache_path(Here, There, Path)),
            true
         )
      ),
      try_cached_path(Here, There, Path).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Caching
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try_cached_path(Here, There, Path) :-
   cached_path(Here, There, Path)
   ;  cached_path(There, Here, Tmp),
      reverse(Tmp, Path).   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cache_paths :-
   cache_paths(_,_,_).

cache_paths(W,T,P) :-
   cache_path(W,T,P),
   fail.

cache_path(Here, There, Path) :-
   search(Here, There, Path),
   Here @> There,
   \+ ( try_cached_path(Here, There, Path)),
     retractall(cached_path(Here, There, _)),
   assertz(cached_path(Here, There, Path)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Graph search
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

search(Here, There, Path) :-
   start(Here),
   search([], Here, There, Tmp),
   reverse([There|Tmp], Path).

search(Build, Here, There, Path) :-
   (
      found(Build, Here, There, Path)
      ;  descend([Here|Build], Here, There, Path)
   ).

found(Build, Here, Here, Path) :-
   Path = Build.

descend(_, Here, Here, _) :-
   fail.

descend(Build, Here, There,  Path) :-
   move(Here, Next), 
   not(member(Next, Build)),
   search(Build, Next, There, Path).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Logging
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

log_paths :-
   cached_path(Here, There, Path),
   format("   .oO> cached_path(~w, ~w, ~w)\n",
          [Here, There, Path]),
   fail.
   
log_paths_count :-
   bagof([X,Y,Z], (cached_path(Z,Y,X)), Tmp),
   length(Tmp, Count),
   format("        Charted ~w paths.\n\n", [Count]).

