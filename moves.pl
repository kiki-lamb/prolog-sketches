%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- op(300, fx, start).

start(This) :-
   concrete(This),
   person(This);
   appliance(This).

%-----------------------------------------------------------

:- op(300, xfx, move).

move(This, This) :-
   fail.

move(This, That) :-
   (
      would( This, shop_at,       That)
   ;  would( This, operate,       That)
   ;  would( This, sleep_on,      That)
   ;  would( This, get_help_from, That)
   ;  would( This, give,          That)
   ).
   
