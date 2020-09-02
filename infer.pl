%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

could(Person, Action) :-
   could(Person, Action, _).

could(Person, Action, Subject) :-
   could(Person, Action, Subject, _).

could(Person, Action, Subject, Path) :-
   (would(Person, Action, Subject),
    call((path(Person, Subject, Path), !))).

:- op(200, xfy, op_could).
op_could(Person, Action) :-
   could(Person, Action).

%--------------------------------------------------------------------------------------------

couldnt(Person, Action) :-
   \+ could(Person, Action, _).

couldnt(Person, Action, Thing) :-
   \+ could(Person, Action, Thing).

 :- op(200, xfy, op_couldnt).
op_couldnt(Person, Action) :-
   couldnt(Person, Action).

%--------------------------------------------------------------------------------------------

wouldnt(Person, Action) :-
   \+ wwould(Person, Action, _).

wouldnt(Person, Action, Subject) :-
   \+ wwould(Person, Action, Subject).

:- op(200, xfy, op_wouldnt).
op_wouldnt(Person, Action) :-
   wouldnt(Person, Action).

%--------------------------------------------------------------------------------------------

would(Start, Action) :-
   would(Start, Action, _).

would(Start, Action, Subject) :-
   wwould(Start, Action, Subject).

:- op(200, xfy, op_would).
op_would(Person, Action) :-
   would(Person, Action).

%--------------------------------------------------------------------------------------------

:- op(200, xfy, would_help).
would_help(Person, Subject) :-
   wwould(Person, help, Subject).

%--------------------------------------------------------------------------------------------

:- dynamic help/2.

wwould(Person, get_help, Subject) :-
   wwould(Subject, help, Person).

wwould(Person, help, Subject) :-
   concrete(Person),
   concrete(Subject),
   person(Person),
   person(Subject),
   Person \== Subject,
   (
      likes(Person,Subject)
   ;  likes(Subject,Person)
   ).


wwould(Person, Action, Subject) :-
%   format("Checking ~w, ~w, ~w...\n",
%          [Person, Action, Subject]),
   concrete(Person),
   concrete(Subject),
   person(Person),
   call(Action, Person, Subject).
          
% wwould(Appliance, break, Appliance) :-
%    appliance(Appliance),
%    human(Human),
%    couldnt(Human, repair, Appliance).

% wwould(Person, buy, Object) :-
%    object(Object),
%    has(Store, Object),
%    wwould(Person, shop_at, Store).

% wwould(Cat, chase, C2) :-
%    cat(Cat),
%    cat(C2),
%    Cat \== C2.

% wwould(Person, drink, Drink) :-
%    object(Drink),
%    drink(Person, Drink).

% wwould(Person, eat, Food) :-
%    food(Food),
%    eat(Person, Food).

% wwould(Human, operate, Appliance) :-
%    human(Human), 
%    appliance(Appliance).

% wwould(Person, pet, Cat) :-
%    human(Person),
%    cat(Cat),
%    wwould(Person, help, Cat).

% wwould(Human, repair, Appliance) :-
%    human(Human),
%    appliance(Appliance),
%    path(Human, screw).

% wwould(Person, scare_off, Cat) :-
%    person(Person),
%    cat(Cat),
%    Person \== Cat,
%    wwouldnt(Person, help, Cat).

% wwould(Person, smoke, Thing) :-
%    thing(Thing),
%    smoke(Person, Thing).
 
% wwould(Human, shop_at, Store) :-
%    human(Human),
%    store, store(Store),
%    shop_at(Human, Store).

% wwould(Human, shower, Appliance) :-
%    human(Human),
%    appliance(Appliance),
%    give(Appliance, water).

% wwould(Person, starve_for, food) :-
%    person(Person),
%    couldnt(Person, eat).

% wwould(Person, starve_for, water) :-
%    person(Person),
%    couldnt(Person, drink, water).
