type(X, store)     :- store(X).
type(X, person)    :- person(X).
type(X, cat)       :- cat(X).
type(X, beverage)  :- beverage(X).
type(X, alcohol)   :- alcohol(X).
type(X, vegetable) :- vegetable(X).
type(X, meat)      :- meat(X).
type(X, vegetable) :- vegetable(X).
type(X, appliance) :- appliance(X).
type(X, thing)     :- thing(X).
type(X, food)      :- food(X).
type(X, human)     :- human(X).
type(X, entity)    :- entity(X).

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

dislike(kiki, cat_food).
dislike(kiki, tequila).

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
has(kiki, water)        :- could(_, repair, sink).

like(sybil, kiki).
like(kiki, boson).
like(higgy, boson).

eat(sybil, turkey).
eat(sybil, X)           :- vegetable(X).
eat(kiki,  X)           :- food(X), \+ eat(sybil, X), \+ dislike(kiki, X).
eat(Who,   X)           :- cat(Who), meat(X).

drink(sybil, pepsi).
drink(sybil, tequila).
drink(kiki, energy_drink).
drink(kiki, X) :- alcohol(X), \+ dislike(kiki, X).
drink(Cat, water) :- cat(Cat).
    
smoke(X,     weed) :- human(X).
smoke(kiki,  cigarette).

human(X)  :- person(X), \+ cat(X).    

location(X) :- store(X).

entity(X) :- person(X); thing(X); location(X).

provider(X, Thing) :- (person(X); store(X)), has(X, Thing).
