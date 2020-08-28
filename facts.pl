store(freshco).
store(home_hardware).
store(lcbo).
store(mr_meat).
store(dave).
store(chicken_freak).

person(sybil).
person(kiki).
person(higgy).
person(boson).

cat(higgy).
cat(boson).

chase(higgy, boson).
chase(boson, higgy).

shop(kiki,  lcbo).
shop(kiki,  chicken_freak).
shop(kiki,  freshco).
shop(sybil, home_hardware).
shop(sybil, mr_meat).
shop(sybil, dave).

beverage(X) :- alcohol(X).
beverage(energy_drink).
beverage(pepsi).
beverage(water).

alcohol(beer).
alcohol(tequila).
alcohol(vodka).

vegetable(cabbage).
vegetable(turnip). 
vegetable(potato). 

meat(turkey).
meat(cat_food).
meat(pepperoni).
meat(steak).

dislikes(kiki, cat_food).
dislikes(kiki, tequila).

appliance(dish_washer).
appliance(sink).

thing(X) :- food(X); beverage(X); appliance(X).
thing(nail).
thing(weed).
thing(cigarette).

food(X)                 :- vegetable(X); meat(X).

has(freshco, X)         :- vegetable(X).
has(mr_meat, X)         :- meat(X).
has(lcbo, X)            :- alcohol(X).
has(chicken_freak, X)   :- beverage(X), \+ alcohol(X), X \= water.
has(chicken_freak,         cat_food).
has(chicken_freak,         cigarette).
has(home_hardware,         nail).
has(dave,                  weed).
    
like(sybil, kiki).
like(kiki, boson).
like(higgy, boson).

eat(sybil, turkey).
eat(sybil, X)           :- vegetable(X).
eat(kiki,  X)           :- food(X), \+ eat(sybil, X), \+ dislikes(kiki, X).
eat(Who,   X)           :- cat(Who), meat(X).

drink(sybil, pepsi).
drink(sybil, tequila).
drink(kiki, energy_drink).
drink(kiki, X) :- alcohol(X), \+ dislikes(kiki, X).
drink(Cat, water) :- cat(Cat).
    
smoke(X,     weed) :- human(X).
smoke(kiki,  cigarette).

human(X)  :- person(X), \+ cat(X).    

