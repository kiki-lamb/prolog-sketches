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

