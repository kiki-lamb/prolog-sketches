%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

path(Here, Move, To)                              :-
    path(Here, Move, To, _).

path(X, [], Path)                           :-
    exist(X), Path = [].

path(Here, Move, To, Path)                        :-
    search(Here, Move, To, TmpPath, []),
    reverse([To|TmpPath], Path).
    
search(Here, Move, To, Path, Build)               :-
    stop(Here, To, Path, Build);
    descend(Here, Move, To, Path, [Here|Build]).

descend(Here, Move, To, Path, Build) :-
    F =.. [Move, Here, Next],
    call(F),
    not(member(Next,Build)),
    search(Next, Move, To, Path, Build).

stop(Here, Here, Path, Build) :-
    Path = Build. 

stop(Here, To, Path, Build) :-
    has(Here, To),
    stop(Here, Here, Path, [Here|Build]).
