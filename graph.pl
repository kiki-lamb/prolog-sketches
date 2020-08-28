%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

path(Here, Move, To, Stop) :-
    path(Here, Move, To, Stop, _).

path(X, _, [], _, Path) :-
    exist(X), Path = [].

path(Here, Move, To, Stop, Path) :-
    search([], Here, Move, To, Stop, TmpPath),
    reverse([To|TmpPath], Path).
    
search(Build, Here, Move, To, Stop, Path) :-
    found(Build, Here, Move, To, Stop, Path);
    descend([Here|Build], Here, Move, To, Stop, Path).

descend(Build, Here, Move, To, Stop, Path) :-
    G =.. [Move, Here, Next],call(G),
    not(member(Next,Build)),
    search(Build, Next, Move, To, Stop, Path).

found(Build, Here, _, Here, _, Path) :-
    Path = Build. 

found(Build, Here, _, To, Stop, Path) :-
    G =.. [Stop, Here, To], call(G),
    found([Here|Build], Here, _, Here, Stop, Path).
