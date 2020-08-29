%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
start(X)                             :- person(X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
move(Here, To)                       :- person(Here),
                                        (\+ cat(Here),
                                         (appliance(To)) ;
                                         (person(To), (like(Here,To) ;
                                                       like(To,Here))) ;
                                         store(To), shop_at(Here,To)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
stop(Here, Target)                   :- (store(Here) ;
                                         appliance(Here)),
                                        has(Here, Target).

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
would(Person,    shower,  [])        :- human(Person),
                                        apath(Person, water).
would(Person,    starve,  [])        :- person(Person),
                                        couldnt(Person, eat, _).
would(Appliance, break,   [])        :- appliance(Appliance),
                                        couldnt(_,  repair, Appliance).
would(Person,    chase,   X)         :- cat(Person),
                                        cat(X),
                                        chase(Person, X).
would(Person,    drink,   X)         :- person(Person),
                                        thing(X),
                                        drink(Person, X).
would(Person,    eat,     X)         :- person(Person),
                                        thing(X),
                                        eat(Person, X).
would(Person,    shop_at, X)         :- person(Person),
                                        store(X),
                                        shop_at(Person, X).
would(Person,    smoke,   X)         :- person(Person),
                                        thing(X),
                                        smoke(Person, X).
would(Person,    repair,  X)         :- human(Person),
                                        appliance(X),
                                        apath(Person, nail).
