%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Graph search.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

search(Here, There) :-
   search(Here, There, _).

search(Here, There, Path) :-
   start Here,
   search(Here, There, Path, []).

search(Here, Here, Path, Build) :-
   reverse([Here|Build], Path).

search(Here, There, Path, Build) :-
   Here move Next, 
   Next nelem [Here|Build],
   search(Next, There, Path, [Here|Build]).

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
   format("   .oO> cached_path(~w, ~w, ~w)\n",
          [Here, There, Path]),
   fail.
   
log_paths_count :-
   bagof([X,Y,Z], (cached_path(Z,Y,X)), Tmp),
   length(Tmp, Count),
   format("        Charted ~w paths.\n\n", [Count]).

