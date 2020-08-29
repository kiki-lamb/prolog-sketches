%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

start(X) :- person(X).

move(Here, To) :-
    (person(Here),
     ((appliance(To));
      (person(To), (like(Here,To) ;
                    like(To,Here))) ;
      store(To), shop(Here,To))).

stop(Location, Target) :-
    (store(Location);
     appliance(Location)),
    has(Location, Target).

apath(Here, To)       :- apath(Here, To, _).
apath(Here, To, Path) :-
    path(start, Here, move, To, stop, Path).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

could(   Person, Action, Thing      )   :- could(Person, Action, Thing, _).
could(   Person, Action, Thing, Path)   :-    
    a(   Person, Action, Thing      ),
    call((apath(Person,Thing,Path), !)).


couldnt(   Person, Action, Thing      ) :- couldnt(Person, Action, Thing, _).
couldnt(   Person, Action, Thing, Path) :-
    \+ could(Person, Action, Thing, Path).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a(Person,    shower, [])   :- human(Person),           apath(    Person, water               ).
a(Person,    starve, [])   :- person(   Person   ),  couldnt(    Person, eat,    _           ).
a(Appliance, break,  [])   :- appliance(Appliance),  couldnt(    _,      repair, Appliance   ).

a(Person,    chase,  X)    :- cat(      Person   ),    cat(      X),     chase(  Person, X   ).
a(Person,    drink,  X)    :- person(   Person   ),    thing(    X),     drink(  Person, X   ).
a(Person,    eat,    X)    :- person(   Person   ),    thing(    X),     eat(    Person, X   ).
a(Person,    shop,   X)    :- person(   Person   ),    store(    X),     shop(   Person, X   ).
a(Person,    smoke,  X)    :- person(   Person   ),    thing(    X),     smoke(  Person, X   ).
a(Person,    repair, X)    :- human(    Person   ),    appliance(X),     apath(  Person, nail).

