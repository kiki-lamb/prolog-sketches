singular(In, Out) :-
   re_replace("s$", "", In, Out).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

could(Actor, Action, Thing) :-
   could(Actor, Action, Thing, _).

could(Actor, Action, Thing, Path) :-
   would(Actor, Action, Thing),
   path(Actor, Thing, Path).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

would(Actor, Action, Thing) :-
   concrete(Actor),
   wwould(Actor, Action, Thing),
   concrete(Thing),
   Thing \== Actor.

wwould(Actor, shop_at, Store) :-
   human(Actor),
   (
      store(Store);
      human(Store)
   ),
   shop_at(Actor, Store).

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

wwould(Person, drinks, Food) :-
   person(Person),
   drinks(Person, Food).

wwould(Person, smokes, Thing) :-
   human(Person),
   thing(Thing),
   smokes(Person, Thing).

%wwould(Actor, Action, Something) :-
%   catch(
%      (
%         G1 =.. [Action, Actor, Something],
%         call(G1)
%      ), _, fail
%   ),
%   format("SUCCESS! ~w ~w ~w\n", [Actor, Action, Something]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% could(Actor, Action) :-
%    could(Actor, Action, _).
% 
% could(Actor, Action, Subject) :-
%    could(Actor, Action, Subject, _).
% 
% could(Actor, Action, Subject, Path) :-
%    (would(Actor, Action, Subject),
%     call((path(Actor, Subject, Path), !))).
% 
% %-----------------------------------------------------------
% 
% couldnt(Actor, Action) :-
%    \+ could(Actor, Action, _).
% 
% couldnt(Actor, Action, Thing) :-
%    \+ could(Actor, Action, Thing).
% 
% %-----------------------------------------------------------
% 
% wouldnt(Actor, Action) :-
%    \+ would(Actor, Action, _).
% 
% wouldnt(Actor, Action, Subject) :-
%    \+ would(Actor, Action, Subject).
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

% wwould(Actor, help, Subject) :-
%    concrete(Actor),
%    concrete(Subject),
%    person(Actor),
%    person(Subject),
%    Actor \== Subject,
%    format("Doing this one, ~w help ~w?\n",
%           [Actor, Subject]),
%    (
%       likes(Actor,Subject)
%    ;  likes(Subject,Actor)
%    ).


%wwould(Actor, Action, Subject) :-
%   format("Checking ~w, ~w, ~w...\n",
%          [Actor, Action, Subject]),
%   concrete(Actor),
%   concrete(Subject),
%   person(Actor),
%   call(Action, Actor, Subject).
          
% wwould(Appliance, break, Appliance) :-
%    appliance(Appliance),
%    human(Human),
%    couldnt(Human, repair, Appliance).

% wwould(Actor, buy, Object) :-
%    object(Object),
%    has(Store, Object),
%    wwould(Actor, shop_at, Store).

% wwould(Cat, chase, C2) :-
%    cat(Cat),
%    cat(C2),
%    Cat \== C2.

% wwould(Actor, drink, Drink) :-
%    object(Drink),
%    drink(Actor, Drink).

% wwould(Actor, eat, Food) :-
%    food(Food),
%    eat(Actor, Food).

% wwould(Actor, pet, Cat) :-
%    human(Actor),
%    cat(Cat),
%    wwould(Actor, help, Cat).

% wwould(Human, repair, Appliance) :-
%    human(Human),
%    appliance(Appliance),
%    path(Human, screw).

% wwould(Actor, scare_off, Cat) :-
%    person(Actor),
%    cat(Cat),
%    Actor \== Cat,
%    wwouldnt(Actor, help, Cat).

% wwould(Actor, smoke, Thing) :-
%    thing(Thing),
%    smoke(Actor, Thing).
 
% wwould(Human, shop_at, Store) :-
%    human(Human),
%    store, store(Store),
%    shop_at(Human, Store).

% wwould(Human, shower, Appliance) :-
%    human(Human),
%    appliance(Appliance),
%    give(Appliance, water).

% wwould(Actor, starve_for, food) :-
%    person(Actor),
%    couldnt(Actor, eat).

% wwould(Actor, starve_for, water) :-
%    person(Actor),
%    couldnt(Actor, drink, water).
