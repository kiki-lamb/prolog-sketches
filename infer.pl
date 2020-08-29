%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
start(X)                               :- person(X);
                                          appliance(X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
move(Here, To)                         :- would(Here, operate, To);
                                          would(To, help, Here);
                                          would(Here, shop_at, To).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
stop(Here, To)                         :- (store(Here) ;
                                           appliance(Here)),
                                          has(Here, To).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ppath(Here, To)                        :- ppath(Here, To, _).
ppath(Here, To, Path)                  :- path(start, Here, move, To, stop, Path).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
could(  Person, Action, Thing      )   :- could(Person, Action, Thing, _      ).
could(  Person, Action, Thing, Path)   :- would(Person, Action, Thing         ),
                                          call((ppath(Person,Thing,Path),   !)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
could_not(Person, Action, Thing      ) :- could_not(Person, Action, Thing, _    ).
could_not(Person, Action, Thing, Path) :- \+ could(Person, Action, Thing, Path).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

would_not(X, Action, Y): \+ would(X, Action, Y).

would(Appliance, break,     Appliance) :- appliance(Appliance),
                                           could_not(_,  repair, Appliance).

would(Person,    help,      X        ) :- person(Person),
                                          person(X),
                                          (like(Person,X) ;
                                           like(X,Person)).

would(Person,    chase,     X        ) :- cat(Person),
                                           cat(X).

would(Person,    drink,     X        ) :- object(X),
                                           drink(Person, X).

would(Person,    eat,       X        ) :- food(X),
                                           eat(Person, X).

would(Person,    pet,       X        ) :- cat(X),                                        
                                          would(Person, help, X).

would(Person,    repair,    X        ) :- human(Person),
                                           appliance(X),
                                           ppath(Person, screw).

would(Person,    scare_off, X        ) :- cat(X),
                                          \+ would(Person, help, cat).

would(Person,    smoke,     X        ) :- thing(X),
                                           smoke(Person, X).

would(Person,    shop_at,   X        ) :- human(Person),
                                          store(X),
                                          shop_at(Person, X).

would(Person,    shower,    Person)    :- human(Person),
                                           ppath(Person, water).

would(Person,    starve,    Person   ) :- could_not(Person, eat, _).

would(Person,    operate,   Appliance) :- human(Person),    
                                          appliance(Appliance).
