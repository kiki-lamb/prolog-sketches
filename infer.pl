%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
start(X)                               :- person(X) ;
                                          appliance(X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
move(Here, To)                         :- person(Here),
                                          (\+ cat(Here),
                                           (appliance(To)) ;

                                           (person(To), would(To, help, Here)) ;
                                           store(To), would(Here, shop_at, To)).

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
couldnt(Person, Action, Thing      )   :- couldnt(Person, Action, Thing, _    ).
couldnt(Person, Action, Thing, Path)   :- \+ could(Person, Action, Thing, Path).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

would(X, Action, Thing)                 :- wwould(X, Action, Thing).

wwould(Appliance, break,     Appliance) :- appliance(Appliance),
                                           couldnt(_,  repair, Appliance).

wwould(Person,    help,      X)         :- (like(Person,X) ;
                                            like(X,Person)).

wwould(Person,    chase,     X)         :- cat(Person),
                                           cat(X).

wwould(Person,    drink,     X)         :- object(X),
                                           drink(Person, X).
wwould(Person,    eat,       X)         :- food(X),
                                           eat(Person, X).
wwould(Person,    pet,       X)         :- human(Person),
                                           cat(X),                                        
                                           (like(Person,X) ;
                                            like(X,Person)).

wwould(Person,    repair,    X)         :- human(Person),
                                           appliance(X),
                                           ppath(Person, screw).

wwould(Person,    scare_off, X)         :- human(Person),
                                           cat(X),                                        
                                           \+ (like(Person,X) ;
                                               like(X,Person)).

wwould(Person,    shop_at,   X)         :- store(X),
                                           shop_at(Person, X).

wwould(Person,    shower,    Person)    :- human(Person),
                                           ppath(Person, water).

wwould(Person,    smoke,     X)         :- thing(X),
                                           smoke(Person, X).

wwould(Person,    starve,    Person)    :- couldnt(Person, eat, _).

wwould(Person, operate, Appliance) :-
    \+ cat(Person),
    (appliance(Appliance)).
