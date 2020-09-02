would(Person, shops_at, Store) :-
   concrete(Store),
   store(Store),
   shops_at(Person, Store).

would(Person, help, P2) :-
   concrete(P2),
   person(P2),
   likes(P2, Person).

would(Person, get_help, P2) :-
   would(P2, help, Person).

would(Here, give, Thing) :-
   concrete(Here), 
   has(Here, Thing).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% could(Person, Action) :-
%    could(Person, Action, _).
% 
% could(Person, Action, Subject) :-
%    could(Person, Action, Subject, _).
% 
% could(Person, Action, Subject, Path) :-
%    (would(Person, Action, Subject),
%     call((path(Person, Subject, Path), !))).
% 
% %-----------------------------------------------------------
% 
% couldnt(Person, Action) :-
%    \+ could(Person, Action, _).
% 
% couldnt(Person, Action, Thing) :-
%    \+ could(Person, Action, Thing).
% 
% %-----------------------------------------------------------
% 
% wouldnt(Person, Action) :-
%    \+ would(Person, Action, _).
% 
% wouldnt(Person, Action, Subject) :-
%    \+ would(Person, Action, Subject).
% 
% 
% %-----------------------------------------------------------
% 
% would(Start, Action) :-
%    would(Start, Action, _).
% 
% would(Start, Action, Subject) :-
%    wwould(Start, Action, Subject).

%-----------------------------------------------------------

% wwould(Person, help, Subject) :-
%    concrete(Person),
%    concrete(Subject),
%    person(Person),
%    person(Subject),
%    Person \== Subject,
%    format("Doing this one, ~w help ~w?\n",
%           [Person, Subject]),
%    (
%       likes(Person,Subject)
%    ;  likes(Subject,Person)
%    ).


%wwould(Person, Action, Subject) :-
%   format("Checking ~w, ~w, ~w...\n",
%          [Person, Action, Subject]),
%   concrete(Person),
%   concrete(Subject),
%   person(Person),
%   call(Action, Person, Subject).
          
% wwould(Appliance, break, Appliance) :-
%    appliance(Appliance),
%    human(Human),
%    couldnt(Human, repair, Appliance).

% wwould(Person, buy, Object) :-
%    object(Object),
%    has(Store, Object),
%    wwould(Person, shops_at, Store).

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
 
% wwould(Human, shops_at, Store) :-
%    human(Human),
%    store, store(Store),
%    shops_at(Human, Store).

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
