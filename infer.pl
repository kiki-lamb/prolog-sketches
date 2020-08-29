%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
start(X)                               :- person(X);
                                          appliance(X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
move(Here, To)                         :- would(Here, operate,  To);
                                          would(Here, get_help, To);
                                          would(Here, shop_at,  To).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
stop(Here, To)                         :- X = provider(Here, To),
%                                          format("~w provides ~w.\n", [Here, To]),
                                          X.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ppath(Here, To)                        :- ppath(Here, To, _).
ppath(Here, To, Path)                  :- path(start, Here, move, To, stop, Path).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
could(  Person, Action, Thing      )   :- could(Person, Action, Thing, _      ).
could(  Person, Action, Thing, Path)   :- % format("Could ~w ~w ~w?\n", [Person, Action, Thing]),
                                          X = (would(Person, Action, Thing         ),
                                               call((ppath(Person,Thing,Path),
                                                     !))),
%                                          ((X, format("~w CAN ~w ~w?\n", [Person, Action, Thing]));
%                                           format("~w CANNOT ~w ~w?\n", [Person, Action, Thing])),
                                          X.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
could_not(Person, Action, Thing      ) :- could_not(Person, Action, Thing, _   ).
could_not(Person, Action, Thing, Path) :- \+ could( Person, Action, Thing, Path).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

would_not(X, Action, Y) :- \+ would(X, Action, Y).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

would( Start,     Action,    X          ) :-
    start(Start), % bind early for ordering.
    wwould(Start, Action, X).

wwould(Person,    borrow,    Object     ) :- person(Person),
                                             object(Object),
                                             would(Someone, buy, Object),
                                             ppath(Person, Someone).

wwould(Appliance, break,     Appliance  ) :- appliance(Appliance),
                                             human(Human),
                                             could_not(Human,repair, Appliance).

wwould(Person,    buy,       Object     ) :- object(Object),
                                             has(Store, Object),
                                             wwould(Person, shop_at, Store).

wwould(Cat,       chase,     C2         ) :- cat(Cat),
                                             cat(C2),
                                             Cat \== C2.

wwould(Person,    drink,     Drink      ) :- object(Drink),
                                             drink(Person, Drink).

wwould(Person,    eat,       Food       ) :- food(Food),
                                             eat(Person, Food).

wwould(Person,    get_help,  P2         ) :- wwould(P2, help, Person).

wwould(Person,    help,      P2         ) :- person(Person),
                                             person(P2),
                                             (like(Person,P2) ;
                                              like(P2,Person)).

wwould(Human,     operate,   Appliance  ) :- human(Human),    
                                             appliance(Appliance).

wwould(Person,    pet,       Cat        ) :- human(Person),
                                             cat(Cat),
                                             wwould(Person, help, Cat).

wwould(Human,     repair,    Appliance  ) :- human(Human),
                                             appliance(Appliance),
                                             ppath(Human, screw).

wwould(Person,    scare_off, Cat        ) :- person(Person),
                                             cat(Cat),
                                             Person \== Cat,
                                             would_not(Person, help, Cat).

wwould(Person,    smoke,     Thing      ) :- thing(Thing),
                                             smoke(Person, Thing).

wwould(Human,     shop_at,   Store      ) :- human(Human),
                                             store(Store),
                                             shop_at(Human, Store).

wwould(Human,     shower,    Appliance  ) :- human(Human),
                                             appliance(Appliance),
                                             provider(Appliance, water).

wwould(Person,    starve,    Person     ) :- person(Person),
                                             could_not(Person, eat, _).
