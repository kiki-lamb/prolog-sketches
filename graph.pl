%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

path(Start, Here, Move, To, Stop) :-
    path(Start, Here, Move, To, Stop, _).

path(Start, Here, _, [], _, Path) :-
    G =.. [Start, Here], call(G),
    Path = [].

path(Start, Here, Move, To, Stop, Path) :-
    G =.. [Start, Here], call(G),
    search([], Here, Move, To, Stop, Tmp),
    reverse([To|Tmp], Path).
    
search(Build, Here, Move, To, Stop, Path) :-
    found(Build, Here, Move, To, Stop, Path);
    descend([Here|Build], Here, Move, To, Stop, Path).

descend(Build, Here, Move, To, Stop, Path) :-
    G =.. [Move, Here, Next], call(G),
    not(member(Next,Build)),
    search(Build, Next, Move, To, Stop, Path).

found(Build, Here, _, Here, _, Path) :-
    Path = Build. 

found(Build, Here, _, To, Stop, Path) :-
    G =.. [Stop, Here, To], call(G),
    found([Here|Build], Here, _, Here, Stop, Path).
