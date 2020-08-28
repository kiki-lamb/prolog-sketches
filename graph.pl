%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

move(From, To):-
    ((human(From), appliance(To));
     (person(From), ((person(To), (like(From,To);
                                   like(To,From)));
                     (store(To), shop(From,To))))).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

stop(From, To) :-
    From == To;
    has(From, To).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

typed_path(Type, From, To)              :- typed_path(Type, From, To, _).

typed_path(Type, From, To, Path)        :-
    type(From, Type),
    path(From, To, Path).

path(From, To)                          :- path(From, To, _).

path(X, [], Path)                       :- entity(X), Path = [].

path(From, To, Path)                    :-
    path(From, To, TmpPath, []),
    reverse(TmpPath, TmpPath2),
    append(TmpPath2, [To], Path).

path(From, To, Path, Build)             :-
    stop(From, To),
    Path = [From|Build];
    (move(From, Next),
     not(member(Next,Build)),
     path(Next, To, Path, [From|Build])).
