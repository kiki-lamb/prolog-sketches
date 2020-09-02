%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- op(300, fx, start).
start(Here) :-
   concrete(Here),
   person(Here ).

%-----------------------------------------------------------

:- op(300, xfx, move).

move(Here, Here) :-
   fail.

move(Here, There) :-
   concrete(Here),
   person(Here),
   (
      would(Here, shops_at, There)
   )
   ;  (
      person(There),
      likes(There, Here)
   )
   ;  (
      has(Here, There)
   ),
   concrete(There),
   There \== Here.
   
