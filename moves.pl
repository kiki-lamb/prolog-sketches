%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- op(300, fx, start).

start(This) :-
   concrete(This),
   person(This).


start(This) :-
   appliance(This).

%-----------------------------------------------------------

:- op(300, xfx, move).

move(This, This) :- fail.
move(This, That) :- would( This, shop_at,       That).
move(This, That) :- would( This, operate,       That).
move(This, That) :- would( This, sleep_on,      That).
move(This, That) :- would( This, get_help_from, That).
move(This, That) :- would( This, provide,       That).

   
