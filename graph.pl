%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

traverse(From, To):-
    ((human(From), appliance(To));
     (person(From), ((person(To), (like(From,To);
                                   like(To,From)));
                     (store(To), shop(From,To))));
     (entity(From), thing(To), has(From, To))).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

path(From, To)                          :- path(From, To, _).
path(X, [], Path)                       :- entity(X), Path = [].
path(From, To, Path)                    :-
    path(From, To, TmpPath, []),
    reverse(TmpPath, TmpPath2),
    append(TmpPath2, [To], Path).
path(From, To, Path, Build)             :-
    traverse(From, Next),
    not(member(Next,Build)),
    path(Next, To, Path, [From|Build]).
path(From, From, Path, Build)           :-
    (entity(From),
     Path = Build);
    fail.

