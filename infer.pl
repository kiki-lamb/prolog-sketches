%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
start(X)                               :- person(X) ;
                                          appliance(X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
move(Here, To)                         :- (person(Here),
                                          (would(Here, operate, To)));

                                          person(To), would(To, help, Here) ;
                                          store(To), would(Here, shop_at, To).

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

% would(X, Action, Thing)                 :- would(X, Action, Thing).

would(Appliance, break,     Appliance) :- appliance(Appliance),
                                           couldnt(_,  repair, Appliance).

would(Person,    help,      X)         :- (like(Person,X) ;
                                            like(X,Person)).

would(Person,    chase,     X)         :- cat(Person),
                                           cat(X).

would(Person,    drink,     X)         :- object(X),
                                           drink(Person, X).
would(Person,    eat,       X)         :- food(X),
                                           eat(Person, X).
would(Person,    pet,       X)         :- human(Person),
                                           cat(X),                                        
                                           (like(Person,X) ;
                                            like(X,Person)).

would(Person,    repair,    X)         :- human(Person),
                                           appliance(X),
                                           ppath(Person, screw).

would(Person,    scare_off, X)         :- human(Person),
                                           cat(X),                                        
                                           \+ (like(Person,X) ;
                                               like(X,Person)).

would(Person,    shop_at,   X)         :- store(X),
                                           shop_at(Person, X).

would(Person,    shower,    Person)    :- human(Person),
                                           ppath(Person, water).

would(Person,    smoke,     X)         :- thing(X),
                                           smoke(Person, X).

would(Person,    starve,    Person)    :- couldnt(Person, eat, _).

would(Person, operate, Appliance) :-
    human(Person),    
    appliance(Appliance).
