%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
start(    X                                 ) :- person(X);
                                                 appliance(X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
move(     Here,   To                        ) :- would(Here, operate,  To);
                                                 would(Here, get_help, To);
                                                 would(Here, shop_at,  To).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
stop(     Here,   To                        ) :- provider(Here, To).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ppath(    Here,   To                        ) :- ppath(Here, To, _).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- dynamic m_path/3.

recover(Here, To, Path) :-
    (m_path(Here, To, Path);
     (m_path(To, Here, Tmp),
      format("   ... flip!\n", []),
      reverse(Tmp, Path))),
    !,
    format("   ... recover ~w -> ~w: ~w.\n", [Here, To, Path]).

ppath(    Here,   To,     Path              ) :-
%    format("Find ~w -> ~w.\n", [Here, To]),
    (

        recover(Here,To, Path)




,
     true);
    (path(start, Here, move, To, stop, Path),
%     format("   ... save ~w -> ~w: ~w\n", [Here, To, Path]),
     assert(m_path(Here,To,Path)), !);
%    format("Fail.\n\n", []),
    true.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- op(200, xfy, could).
could(    Person, Action                    ) :- could(Person, Action, _              ).
could(    Person, Action, Thing             ) :- could(Person, Action, Thing, _       ).
could(    Person, Action, Thing, Path       ) :- (would(Person, Action, Thing         ),
%                                                  format("Find ~w -> ~w to ~w.\n",
%                                                         [Person, Thing, Action]),
                                                  ppath(Person,Thing,Path)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
could_not(Person, Action, Thing             ) :- could_not(Person, Action, Thing, _   ).
could_not(Person, Action, Thing, Path       ) :- \+ could( Person, Action, Thing, Path).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

would(    Start,     Action,     X          ) :- start(Start), % bind early for ordering.
                                                 wwould(Start, Action, X).

would_not(X,         Action,     Y          ) :- \+ would(X, Action, Y).

% wwould(   Person,    borrow,     Object     ) :- person(Person),
%                                                  object(Object),
%                                                  would(Someone, buy, Object),
%                                                  Someone \= Person,
%                                                  ppath(Person, Someone).

wwould(   Appliance, break,      Appliance  ) :- appliance(Appliance),
                                                 human(Human),
                                                 could_not(Human, repair, Appliance).

wwould(   Person,    buy,        Object     ) :- object(Object),
                                                 has(Store, Object),
                                                 would(Person, shop_at, Store).

wwould(   Cat,       chase,      C2         ) :- cat(Cat),
                                                 cat(C2),
                                                 Cat \== C2.

wwould(   Person,    drink,      Drink      ) :- object(Drink),
                                                 drink(Person, Drink).

wwould(   Person,    eat,        Food       ) :- food(Food),
                                                 eat(Person, Food).

wwould(   Person,    get_help,   P2         ) :- would(P2, help, Person).

wwould(   Person,    help,       P2         ) :- person(Person),
                                                 person(P2),
                                                 Person \== P2,
                                                 (like(Person,P2) ;
                                                  like(P2,Person)).

wwould(   Human,     operate,    Appliance  ) :- human(Human),    
                                                 appliance(Appliance).

wwould(   Person,    pet,        Cat        ) :- human(Person),
                                                 cat(Cat),
                                                 would(Person, help, Cat).

wwould(   Human,     repair,     Appliance  ) :- human(Human),
                                                 appliance(Appliance),
                                                 ppath(Human, screw).

wwould(   Person,    scare_off,  Cat        ) :- person(Person),
                                                 cat(Cat),
                                                 Person \== Cat,
                                                 would_not(Person, help, Cat).

wwould(   Person,    smoke,      Thing      ) :- thing(Thing),
                                                 smoke(Person, Thing).

wwould(   Human,     shop_at,    Store      ) :- human(Human),
                                                 store(Store),
                                                 shop_at(Human, Store).

wwould(   Human,     shower,     Appliance  ) :- human(Human),
                                                 appliance(Appliance),
                                                 provider(Appliance, water).

wwould(   Person,    starve_for, food       ) :- person(Person),
                                                 could_not(Person, eat, _).

wwould(   Person,    starve_for, water      ) :- person(Person),
                                                 could_not(Person, drink, water).
