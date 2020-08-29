%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
start(X)                               :- person(X);
                                          appliance(X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
move(Here, To)                         :- would(Here, operate,  To);
                                          would(Here, get_help, To);
                                          would(Here, shop_at,  To).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
stop(Here, To)                         :- provider(Here, To).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ppath(Here, To)                        :- ppath(Here, To, _).
ppath(Here, To, Path)                  :- path(start, Here, move, To, stop, Path).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
could(  Person, Action, Thing      )   :- could(Person, Action, Thing, _      ).
could(  Person, Action, Thing, Path)   :- would(Person, Action, Thing         ),
                                          call((ppath(Person,Thing,Path)     )).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
could_not(Person, Action, Thing      ) :- could_not(Person, Action, Thing, _   ).
could_not(Person, Action, Thing, Path) :- \+ could( Person, Action, Thing, Path).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

would_not(X, Action, Y) :- \+ would(X, Action, Y).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

would(Person,    help,      P2         ) :- person(Person),
                                            person(P2),
                                            (like(Person,P2) ;
                                             like(P2,Person)).

would(Person,    get_help,  P2         ) :- would(P2, help, Person).

would(Appliance, break,     Appliance  ) :- could_not(_,  repair, Appliance).

would(Person,    buy,       Object     ) :- object(Object),
                                            has(Store, Object),
                                            would(Person, shop_at, Store).

would(Person,    chase,     Cat        ) :- cat(Person),
                                            cat(Cat).

would(Person,    drink,     Drink      ) :- object(Drink),
                                            drink(Person, Drink).

would(Person,    eat,       Food       ) :- food(Food),
                                            eat(Person, Food).

would(Human,     operate,   Appliance  ) :- human(Human),    
                                            appliance(Appliance).

would(Person,    pet,       Cat        ) :- cat(Cat),                                        
                                            would(Person, help, Cat).

would(Human,     repair,     Appliance ) :- human(Human),
                                            appliance(Appliance),
                                            ppath(Human, screw).

would(Person,    scare_off, Cat        ) :- cat(Cat),
                                            would_not(Person, help, cat).

would(Person,    smoke,     Thing      ) :- thing(Thing),
                                             smoke(Person, Thing).

would(Human,     shop_at,   Store      ) :- human(Human),
                                            store(Store),
                                            shop_at(Human, Store).

would(Human,     shower,    Human      ) :- human(Human),
                                            ppath(Human, water).

would(Person,    starve,    Person     ) :- could_not(Person, eat, _).
