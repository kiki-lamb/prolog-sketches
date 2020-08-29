%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
appliance(dish_washer).
appliance(sink).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
thing(screw).
thing(weed).
thing(cigarette).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
beverage(energy_drink).
beverage(pepsi).
beverage(water).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
alcohol(beer).
alcohol(tequila).
alcohol(vodka).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%:- dynamic(vegetable/1).
vegetable(cabbage).
vegetable(turnip). 
vegetable(potato). 

vegetable([X|Y]) :-
    [Z|Zs] = Y,
    Zs == [],
    X \== Z,
    vegetable(X),
    vegetable(Z).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
meat(turkey).
meat(cat_food).
meat(pepperoni).
meat(steak).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
person(sybil).
person(kiki).
person(higgy).
person(boson).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cat(higgy).
cat(boson).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
store(freshco).
store(home_hardware).
store(lcbo).
store(mr_meat).
store(dave).
store(chicken_freak).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
shop_at(kiki,  lcbo).
shop_at(kiki,  chicken_freak).
shop_at(kiki,  freshco).
shop_at(sybil, home_hardware).
shop_at(sybil, mr_meat).
shop_at(sybil, dave).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dislike(kiki, cat_food).
dislike(kiki, tequila).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
like(sybil, kiki).
like(kiki,  boson).
like(kiki,  higgy).
like(higgy, boson).

