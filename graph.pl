:- dynamic cached_path/3. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- op(400, xfx, =>).

Here => (There, Path) :-
   search(Here, There, Path).

Here => There :-
   Here => (There, _).

:- op(400, xfx, <=).

There <= (Here, Path) :-
   Here => (There, Path).

There <= Here :-
   Here => There.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main entry point.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Caching.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
%-------------------------------------------------------------------------------

try_cached_path(Here, There, Path) :-
   cached_path(Here, There, Path)
   ;  cached_path(There, Here, Tmp),
      reverse(Tmp, Path).   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Graph search.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

search(Here, There, Path) :-
   start(Here),
   search(Here, There, Path, []).

%-------------------------------------------------------------------------------

search(Here, Here, Path, Build) :-
   reverse([Here|Build], Path).

search(Here, There, Path, Build) :-
   move(Here, Next), 
   not(member(Next, [Here|Build])),
   search(Next, There, Path, [Here|Build]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Logging.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

log_paths :-
   cached_path(Here, There, Path),
   format("   .oO> cached_path(~w, ~w, ~w)\n",
          [Here, There, Path]),
   fail.
   
log_paths_count :-
   bagof([X,Y,Z], (cached_path(Z,Y,X)), Tmp),
   length(Tmp, Count),
   format("        Charted ~w paths.\n\n", [Count]).

