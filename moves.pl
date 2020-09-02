%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- op(300, xfx, move).
move( Here, Here ) :- fail.

move( Here, There) :-
   concrete(There),
   person(  There),
   (
      (
         store(Here)
      ;  person(Here)
      ),
      would(There, shop_at, Here)
   )
   ;
   (
      person(Here),
      would(Here, help, There),
      There \== Here
   ),
   concrete(Here).

:- op(300, fx, start).
start(Here)       :-
   concrete(Here),  person(Here ).

