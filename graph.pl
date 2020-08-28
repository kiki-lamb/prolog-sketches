%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

path(Here, Move, To, Stop) :-
    path(Here, Move, To, Stop, _).

path(X, _, [], _, Path) :-
    exist(X), Path = [].

path(Here, Move, To, Stop, Path) :-
    search(Here, Move, To, Stop, TmpPath, []),
    reverse([To|TmpPath], Path).
    
search(Here, Move, To, Stop, Path, Build) :-
    found(Here, Move, To, Stop, Path, Build);
    descend(Here, Move, To, Stop, Path, [Here|Build]).

descend(Here, Move, To, Stop, Path, Build) :-
    G =.. [Move, Here, Next],call(G),
    not(member(Next,Build)),
    search(Next, Move, To, Stop, Path, Build).

found(Here, _, Here, _, Path, Build) :-
    Path = Build. 

found(Here, _, To, Stop, Path, Build) :-
    G =.. [Stop, Here, To], call(G),
    found(Here, _, Here, Stop, Path, [Here|Build]).
