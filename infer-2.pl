:- consult("file_reader.pl").

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% start_2(X)              :- fail.
% move_2( Here, To)       :- fail.
% stop_2( Here, To)       :- fail.
% ppath_2(Here, To)       :- ppath_2(Here, To, _).
% ppath_2(Here, To, Path) :- fail.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% does(_,   a) :- fail.
% does(Obj, Action) :-
%   Action \== a,
%   r( Obj, Action, _, _);
%   r( Obj, a, Actual, _), r(Actual, Action, _, _).
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% setup :-
%   r(Thing, Verb, Noun, Options),
%   format("+=> r(~w, ~w, ~w, ~w.\n",
%          [Thing, Verb, Noun, Options]),
%   fail.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clean_up  :- retractall(person2(_)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

is_a(Thing, Class) :-
  r(Thing, a,  Class, _) ;
  r(Thing, a,  ActualType, _),
  is_a(ActualType, Class).

loop_as :-
  is_a(Thing, Class),
  declarify(Class, Thing),
  fail.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

combine(Left, Right, Out) :-
  bagof([ L, R ], (member(L, Left), member(R, Right)), Out).

bind_classes(Left, Action, Right) :-
  bagof(L, (is_a(L, Left )), Lefts ),
  format("Lefts: ~w.\n",    [Lefts]),
  
  bagof(R, (is_a(R, Right)), Rights ),
  format("Rights: ~w.\n",   [Rights]),
  
  combine([Left | Lefts], [Right | Rights], Tmp),
  format("Tmp: ~w.\n",   [Tmp]),

  bagof([Action, L, R], (member([L, R], Tmp)), Tmp2),
  format("Tmp2: ~w.\n",   [Tmp2]),
  
  maplist((declarify(Action)), Tmp2, _).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

declarify([Action, Thing, Subject]) :-
  G1 =..  [Action, Thing, Subject],
  aassertz(Action, G1).

declarify(Action, Thing, Subject) :-
  G1 =.. [ Action, Thing, Subject ],
  aassertz(Action, G1).

declarify(Action, Thing) :-
  G1 =.. [ Action, Thing ],
  aassertz(Action, G1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

aassertz(Action, G1) :-
  assertz(G1),
  format("=+~w> ~w.\n",
         [Action, G1]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setup :-
  clean_up,
  assertify_lines('dat2.ssv'),
  loop_as;
%  loop_reflex(like);
%  magic_loop(eat);
%  magic_loop(drink);
%  magic_loop(give);
%  magic_loop(has);
%  magic_loop(smoke);
%  magic_loop(shop_at);
%  magic_loop(dislike);
%  retract(r(_,_,_,_));
  true.



    
    
