%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- op(300, fx, start).
start(This) :-
   concrete(This),
   person(This ).

%-----------------------------------------------------------

:- op(300, xfx, move).

move(This, This) :-
   fail.

move(This, That) :-
   (
      would( This, shops_at, That)
   ;  would( This, operate,  That)
   ;  would( This, get_help, That)
   ;  would( This, give,     That)
   ).
   
