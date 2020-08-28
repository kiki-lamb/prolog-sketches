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
    found(Here, To, stop, Path, Build);
    descend(Here, Move, To, Path, [Here|Build]).

descend(Here, Move, To, Path, Build) :-
    G =.. [Move, Here, Next],call(G),
    not(member(Next,Build)),
    search(Next, Move, To, Path, Build).

found(Here, Here, _, Path, Build) :-
    Path = Build. 

found(Here, To, Stop, Path, Build) :-
    G =.. [Stop, Here, To], call(G),
    found(Here, Here, Stop, Path, [Here|Build]).
