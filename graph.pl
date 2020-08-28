%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

move(Here, To):-
    ((human(Here), appliance(To));
     (person(Here), ((person(To), (like(Here,To);
                                   like(To,Here)));
                     (store(To), shop(Here,To))))).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

path(Here, To)                              :-
    path(Here, To, _).

path(X, [], Path)                           :-
    exist(X), Path = [].

path(Here, To, Path)                        :-
    search(Here, To, TmpPath, []),
    reverse([To|TmpPath], Path).
    
search(Here, To, Path, Build)               :-
    stop(Here, To, Path, Build);
    descend(Here, To, Path, [Here|Build]).

descend(Here, To, Path, Build) :-
    move(Here, Next),
    not(member(Next,Build)),
    search(Next, To, Path, Build).

stop(Here, Here, Path, Build) :-
    Path = Build. 

stop(Here, To, Path, Build) :-
    has(Here, To),
    stop(Here, Here, Path, [Here|Build]).
