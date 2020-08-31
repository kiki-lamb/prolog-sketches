%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

start(X) :-
   T = tracing,
   (
      (tracing, format("Disable tracing.\n", []))
   ;  true
   ),
   
   R = (
      person(X)
   ;  appliance(X)
   ),
   
   (
      (T, format("Resume tracing.\n", []))
   ;  true
   ),               

   R.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

move(Here, To) :-
   (
      would(Here, operate, To)
   ;  would(Here, get_help, To)
   ;  would(Here, shop_at, To)
   ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

stop(Here, To) :-
   has(Here, To).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ppath(Here, To) :-
   ppath(Here, To).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ppath(Here, To, Path) :-
   path(start, Here, move, To, stop, Path).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- op(200, xfy, could).
could(Person, Action) :-
   could(Person, Action).

could(Person, Action, Thing) :-
   could(Person, Action, Thing).

could(Person, Action, Thing, Path) :-
   (would(Person, Action, Thing),
    % format(Find ~w -> ~w to ~w.\n",
    %        [Person, Thing, Action),
    call((ppath(Person, Thing, Path), !))).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- op(200, xfy, couldnt).
couldnt(Person, Action) :-
   couldnt(Person, Action, _).

couldnt(Person, Action, Thing) :-
   couldnt(Person, Action, Thing).

couldnt(Person, Action, Thing, Path) :- \+ could(Person, Action, Thing, Path).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- op(200, xfy, would).
would(Start, Action) :-
   would(Start, Action).

would(Start, Action, X) :-
   start(Start), % bind early for ordering.
   wwould(Start, Action, X).

:- op(200, xfy, wouldnt).
wouldnt(X, Action) :-
   \+ would(X, Action).

wouldnt(X, Action, Y) :-
   \+ would(X, Action, Y).

wwould(Appliance, break, Appliance) :-
   appliance(Appliance),
   human(Human),
   couldnt(Human, repair, Appliance).

wwould(Person, buy, Object) :-
   object(Object),
   has(Store, Object),
   would(Person, shop_at, Store).

wwould(Cat, chase, C2) :-
   cat(Cat),
   cat(C2),
   Cat \== C2.

wwould(Person, drink, Drink) :-
   object(Drink),
   drink(Person, Drink).

wwould(Person, eat, Food) :-
   food(Food),
   eat(Person, Food).

wwould(Person, get_help, P2) :-
   would(P2, help, Person).

wwould(Person, help, P2) :-
   person(Person),
   person(P2),
   Person \== P2,
   (
      like(Person,P2)
   ;  like(P2,Person)
   ).

wwould(Human, operate, Appliance) :-
   human(Human), 
   appliance(Appliance).

wwould(Person, pet, Cat) :-
   human(Person),
   cat(Cat),
   would(Person, help, Cat).

wwould(Human, repair, Appliance) :-
   human(Human),
   appliance(Appliance),
   ppath(Human, screw).

wwould(Person, scare_off, Cat) :-
   person(Person),
   cat(Cat),
   Person \== Cat,
   wouldnt(Person, help, Cat).

wwould(Person, smoke, Thing) :-
   thing(Thing),
   smoke(Person, Thing).

wwould(Human, shop_at, Store) :-
   human(Human),
   store(Store),
   shop_at(Human, Store).

wwould(Human, shower, Appliance) :-
   human(Human),
   appliance(Appliance),
   give(Appliance, water).

wwould(Person, starve_for, food) :-
   person(Person),
   couldnt(Person, eat).

wwould(Person, starve_for, water) :-
   person(Person),
   couldnt(Person, drink, water).
