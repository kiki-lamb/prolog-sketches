%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

could(   Person, Action, Thing      )   :- could(Person, Action, Thing, _).
could(   Person, Action, Thing, Path)   :-
    a(   Person, Action, Thing      ),
    path(Person, Thing,  Path       ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a(Appliance, break,  [])   :- appliance(Appliance), \+ could(    _,      repair, Appliance   ).
a(Person,    starve, [])   :- person(   Person   ), \+ could(    Person, eat,    _           ).
a(Person,    chase,  X)    :- cat(      Person   ),    cat(      X),     chase(  Person, X   ).
a(Person,    drink,  X)    :- person(   Person   ),    thing(    X),     drink(  Person, X   ).
a(Person,    eat,    X)    :- person(   Person   ),    thing(    X),     eat(    Person, X   ).
a(Person,    repair, X)    :- human(    Person   ),    appliance(X),     path(   Person, nail).
a(Person,    shop,   X)    :- person(   Person   ),    store(    X),     shop(   Person, X   ).
a(Person,    smoke,  X)    :- person(   Person   ),    thing(    X),     smoke(  Person, X   ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

traverse(From, To):-
    (human(From),
     appliance(To));

    (person(From), 
     
     ((person(To),
       (like(From,To); like(To,From)));

      (store(To),
       shop(From,To))));
     
    (thing(To),
     has(From, To)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
    (thing(From),
     Path = Build) ; fail.

