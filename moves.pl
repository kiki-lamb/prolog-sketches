%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- op(300, xfx, move).

move(Here, Here) :-
   fail.

move(Here, There) :-
   concrete(Here),
   person(Here),
   (
      (
         store(There)
      ;  person(There)
      ),
      would(Here, shop_at, There)
   )
   ;  (
      person(There),
      would(There, help, Here)
   )
   ;  (
      has(Here, There)
   ),%;
   %(
   %   appliance(There),
   %   would(Here, operate, There)
   %),
   concrete(There),
   There \== Here.
   
:- op(300, fx, start).
start(Here) :-
   concrete(Here),
   person(Here ).

