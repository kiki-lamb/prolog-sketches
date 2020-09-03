:- dynamic cached_path/3. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- op(400, xfx, =>).

Here => (There, Path) :-
   path(Here, There, Path).

Here => There :-
   path(Here, There).

%-----------------------------------------------------------

:- op(400, xfx, <=).

There <= (Here, Path) :-
   path(Here, There, Path).

There <= Here :-
   path(Here, There).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main entry point.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Caching.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cache_paths :-
   cache_paths(_,_,_).

cache_paths(W,T,P) :-
   cache_path(W,T,P),
   fail.

cache_path(Here, There, Path) :-
   search(Here, There, Path),
   Here \== There,
   \+ ( try_cached_path(Here, There, Path)),
     retractall(cached_path(Here, There, _)),
   assertz(cached_path(Here, There, Path)).

%-----------------------------------------------------------

try_cached_path(Here, There, Path) :-
   cached_path(Here, There, Path).

try_cached_path(Here, There, Path) :-
   cached_path(There, Here, Tmp),
   reverse(Tmp, Path).   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Logging.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

log_paths :-
   log_path;
   nl,
   log_paths_count,
   true.

log_path :-
   cached_path(Here, There, Path),
   format("   .oO> cached_path(~w, ~w: ~w).\n",
           [Here, There, Path]),
    fail.
   
log_paths_count :-
   bagof([X,Y,Z], (cached_path(Z,Y,X)), Tmp),
   length(Tmp, Count),
   format("[[Setup]] Charted ~w paths.\n", [Count]).


