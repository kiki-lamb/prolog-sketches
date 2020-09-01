%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

move( Here, Here ) :- fail.

move( Here, There) :-
   concrete(Here),
   concrete(There),
   person(  Here), 
   (
      person(There),
      would(There, help, Here),
      There \= Here
   )
   ;
   (
      store(There),
      would(Here, shop_at, There)
   ).

start(Here)       :-
   concrete(Here),  person(Here ).

