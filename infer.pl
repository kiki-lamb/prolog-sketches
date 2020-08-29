%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
start(X)                             :- person(X) ;
                                        appliance(X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
move(Here, To)                       :- person(Here),
                                        (\+ cat(Here),
                                         (appliance(To)) ;
                                         (person(To), (like(Here,To) ;
                                                       like(To,Here))) ;
                                         store(To), shop_at(Here,To)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
stop(Here, To)                       :- (store(Here) ;
                                         appliance(Here)),
                                        has(Here, To).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
apath(Here, To)                      :- apath(Here, To, _).
apath(Here, To, Path)                :- path(start, Here, move, To, stop, Path).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
could(  Person, Action, Thing      ) :- could(Person, Action, Thing, _      ).
could(  Person, Action, Thing, Path) :- would(Person, Action, Thing         ),
                                        call((apath(Person,Thing,Path),   !)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
couldnt(Person, Action, Thing      ) :- couldnt(Person, Action, Thing, _    ).
couldnt(Person, Action, Thing, Path) :- \+ could(Person, Action, Thing, Path).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
would(Person,    shower,  Person)    :- human(Person),
                                        apath(Person, water).
would(Person,    starve,  Person)    :- couldnt(Person, eat, _).
would(Appliance, break,   Appliance) :- appliance(Appliance),
                                        couldnt(_,  repair, Appliance).
would(Person,    chase,   X)         :- cat(Person),
                                        cat(X),
                                        chase(Person, X).
would(Person,    drink,   X)         :- thing(X),
                                        drink(Person, X).
would(Person,    eat,     X)         :- thing(X),
                                        eat(Person, X).
would(Person,    shop_at, X)         :- store(X),
                                        shop_at(Person, X).
would(Person,    smoke,   X)         :- thing(X),
                                        smoke(Person, X).
would(Person,    repair,  X)         :- human(Person),
                                        appliance(X),
                                        apath(Person, nail).
would(Person,    pet,     X)         :- human(Person),
                                        cat(X),                                        
                                        (like(Person,X) ; like(X,Person)).
