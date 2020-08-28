path(From, To)                          :- path(From, To, _).
path(_, [], Path)                       :- Path = [].
path(From, To, Path)                    :-
    path(From, To, TmpPath, []),
    reverse(TmpPath, TmpPath2),
    append(TmpPath2, [To], Path).
path(From, To, Path, Build)             :-
    traverse(From, Next),
    not(member(Next,Build)),
    path(Next, To, Path, [From|Build]).
path(From, From, Build, Path)           :-
    Path = Build.

traverse(From, To):-
    (human(From),  appliance(To));
    (person(From), person(To), like(From,To));
    (person(From), person(To), like(To,From));
    (person(From), store(To),  shop(From,To));
    (thing(To),    has(From, To)).

