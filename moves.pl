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
   would(Here, shops_at, There)
   ;  would(Here, get_help, There)
   ;  would(Here, give, There).
   
   
