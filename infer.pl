%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

could(Actor, Action, Thing) :-
   could(Actor, Action, Thing, _).

could(Actor, Action, Thing, Path) :-
   would(Actor, Action, Thing),
   path(Actor, Thing, Path).

%-----------------------------------------------------------

couldnt(Actor, Action) :-
   \+ could(Actor, Action, _).

couldnt(Actor, Action, Thing) :-
   \+ could(Actor, Action, Thing).

%-----------------------------------------------------------

wouldnt(Actor, Action) :-
   \+ would(Actor, Action, _).

wouldnt(Actor, Action, Subject) :-
   \+ would(Actor, Action, Subject).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

would(Actor, Action, Thing) :-
   concrete(Actor),
   wwould(Actor, Action, Thing),
   concrete(Thing),
   Thing \== Actor.

wwould(Actor, shop_at, Store) :-
   human(Actor),
   %(
      store(Store);
      human(Store),
   %),
   shop_at(Actor, Store).

wwould(Actor, pet, Subject) :-
   human(Actor),
   cute(Subject),
   wwould(Actor, help, Subject).

wwould(Actor, chase, Cat) :-
   cat(Actor),
   cat(Cat).

wwould(Actor, sleep_on, Appliance) :-
   cat(Actor),
   appliance(Appliance).

wwould(Actor, help, Person) :-
   person(Person),
   likes(Person, Actor).

wwould(Actor, get_help, Person) :-
   would(Person, help, Actor).

wwould(Actor, give, Object) :-
   object(Object),
   has(Actor, Object).

wwould(Human, operate, Appliance) :-
   human(Human), 
   appliance(Appliance).

wwould(Person, eat, Food) :-
   person(Person),
   eat(Person, Food),
   \+ dislike(Person, Food).

wwould(Person, drink, Food) :-
   person(Person),
   drink(Person, Food).

wwould(Person, smokes, Thing) :-
   human(Person),
   thing(Thing),
   smokes(Person, Thing).

wwould(Actor, scare_off, Cat) :-
   person(Actor),
   cat(Cat),
   Actor \== Cat,
   wouldnt(Actor, help, Cat).

wwould(Human, shower, Appliance) :-
   human(Human),
   appliance(Appliance),
   has(Appliance, water).

wwould(Actor, starve_for, food) :-
    person(Actor),
    couldnt(Actor, eat).

wwould(Actor, starve_for, water) :-
   person(Actor),
   couldnt(Actor, drink, water).
