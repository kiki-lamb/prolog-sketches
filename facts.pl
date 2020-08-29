%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dislike(kiki, cat_food).
dislike(kiki, tequila).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
object(X)              :- food(X) ;
                          beverage(X) ;
                          alcohol(X);
                          appliance(X) ;
                          thing(X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
soft_drink(X)         :- beverage(X), 
                         water \= X,
                         \+ alcohol(X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
food(X)               :- vegetable(X) ;
                         meat(X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
has(freshco, X)       :- vegetable(X).
has(mr_meat, X)       :- meat(X).
has(lcbo, X)          :- alcohol(X).
has(chicken_freak, X) :- soft_drink(X).
has(chicken_freak,       cat_food).
has(chicken_freak,       cigarette).
has(home_hardware,       screw).
has(dave,                weed).
has(sink, water)      :- could(_, repair, sink),
                         !.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eat(sybil,               turkey).
eat(sybil, X)         :- vegetable(X).
eat(kiki,  X)         :- food(X),
                         \+ eat(sybil, X),
                         \+ dislike(kiki, X).
eat(Cat,   X)         :- cat(Cat),
                         meat(X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
drink(sybil,             pepsi).
drink(sybil,             tequila).
drink(kiki,              energy_drink).
drink(kiki, X)        :- alcohol(X),
                         \+ dislike(kiki, X).
drink(Cat, water)     :- cat(Cat).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
smoke(X, weed)        :- human(X).
smoke(kiki,              cigarette).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
human(X)              :- person(X),
                         \+ cat(X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
location(X)           :- store(X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exist(X)              :- person(X) ;
                         thing(X) ;
                         location(X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
provider(X, Thing)    :- (person(X) ;
                          store(X)),
                         has(X, Thing).
