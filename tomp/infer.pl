%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%- op(

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%:- op(200, xfy, could).
could(Person, Action) :-
   could(Person, Action).

could(Person, Action, Thing) :-
   could(Person, Action, Thing).

could(Person, Action, Thing, Path) :-
   (wwould(Person, Action, Thing),
    % format(Find ~w -> ~w to ~w.\n",
    %        [Person, Thing, Action),
    call((path(Person, Thing, Path), !))).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% :- op(200, xfy, couldnt).
couldnt(Person, Action) :-
   couldnt(Person, Action, _).

couldnt(Person, Action, Thing) :-
   couldnt(Person, Action, Thing).

couldnt(Person, Action, Thing, Path) :- \+ could(Person, Action, Thing, Path).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% :- op(200, xfy, wwouldnt).
wwouldnt(X, Action) :-
   \+ wwould(X, Action).

wwouldnt(X, Action, Y) :-
   \+ wwould(X, Action, Y).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% :- op(200, xfy, wwould).
wwould(Start, Action) :-
   wwould(Start, Action).

wwould(Start, Action, X) :-
   wwwould(Start, Action, X).

% :- op(200, xfy, wwould_help).
wwould_help(Person, P2) :-
   wwould(Person, help, P2).

wwwould(Person, get_help, P2) :-
   wwould(P2, help, Person).

wwwould(Person, help, P2) :-
   human(Person),
   human(P2),
   Person \== P2,
   (
      like(Person,P2)
   ;  like(P2,Person)
   ).

% wwwould(Appliance, break, Appliance) :-
%    appliance(Appliance),
%    human(Human),
%    couldnt(Human, repair, Appliance).

% wwwould(Person, buy, Object) :-
%    object(Object),
%    has(Store, Object),
%    wwould(Person, shop_at, Store).

% wwwould(Cat, chase, C2) :-
%    cat(Cat),
%    cat(C2),
%    Cat \== C2.

% wwwould(Person, drink, Drink) :-
%    object(Drink),
%    drink(Person, Drink).

% wwwould(Person, eat, Food) :-
%    food(Food),
%    eat(Person, Food).

% wwwould(Human, operate, Appliance) :-
%    human(Human), 
%    appliance(Appliance).

% wwwould(Person, pet, Cat) :-
%    human(Person),
%    cat(Cat),
%    wwould(Person, help, Cat).

% wwwould(Human, repair, Appliance) :-
%    human(Human),
%    appliance(Appliance),
%    path(Human, screw).

% wwwould(Person, scare_off, Cat) :-
%    person(Person),
%    cat(Cat),
%    Person \== Cat,
%    wwouldnt(Person, help, Cat).

% wwwould(Person, smoke, Thing) :-
%    thing(Thing),
%    smoke(Person, Thing).
 
% wwwould(Human, shop_at, Store) :-
%    human(Human),
%    store, store(Store),
%    shop_at(Human, Store).

% wwwould(Human, shower, Appliance) :-
%    human(Human),
%    appliance(Appliance),
%    give(Appliance, water).

% wwwould(Person, starve_for, food) :-
%    person(Person),
%    couldnt(Person, eat).

% wwwould(Person, starve_for, water) :-
%    person(Person),
%    couldnt(Person, drink, water).
