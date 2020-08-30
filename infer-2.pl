:- consult("file_reader.pl").

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% start_2(X)              :- fail.
% move_2( Here, To)       :- fail.
% stop_2( Here, To)       :- fail.
% ppath_2(Here, To)       :- ppath_2(Here, To, _).
% ppath_2(Here, To, Path) :- fail.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

loop_as :-
  is_a(Thing, Class),
  declarify([Class, Thing]),
  fail.

:- op(300, xfy, isnt).
isnt(Thing, Class) :-
  \+( is_a(Thing, Class)).

:- op(300, xfy, is_a).
is_a(Thing, Class) :-
  (r(Thing, a,  Class, _) ;
   r(Thing, a,  ActualType, _),
   is_a(ActualType, Class)),
  !.

unique(Thing) :-
  \+ is_a(_, Thing).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

combine(Left, Right, Out) :-
  findall([ L, R ], (member(L, Left), member(R, Right)), Out).

bind_classes(Left, Action, Right) :-
  findall(L, (is_a(L, Left )), Lefts ),
  %format("Lefts: ~w.\n",    [Lefts]),
  findall(R, (is_a(R, Right)), Rights ),
  %format("Rights: ~w.\n",   [Rights]),
  combine([Left | Lefts], [Right | Rights], Tmp),
  %format("Tmp: ~w.\n",   [Tmp]),
  findall([Action, L, R], (member([L, R], Tmp)), Tmp2),
  %format("Tmp2: ~w.\n",   [Tmp2]),
  maplist(declarify, Tmp2).

actors(Out) :-
  findall(Actor, ((r(Actor, _, _, _))), Tmp),
  sort(Tmp, Out).

actions(Out) :-
  findall(Action, ((r(_, Action, _, _))), Tmp),
  sort(Tmp, Out).

subjects(Out) :-
  findall(Subject, ((r(_, _, Subject, _))), Tmp),
  sort(Tmp, Out).

non_actor_subjects(Out) :-
  actors(Actors),
  findall(Subject, ((r(_, _, Subject, _), not(member(Subject, Actors))   )), Tmp),
  sort(Tmp, Out).

bind :-
  r(Actor, Action, Subject, _),
  Action \== a,
  % format("Binding ~w(~w, ~w)...\n", [Action, Actor, Subject]),
  bind_classes(Actor, Action, Subject),
  fail.   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

assert1(G) :-
  catch((\+( G ), !), _, fail);
  assert(G).

declarify(L) :-
  G1 =..  L,
  %format("-=> ~w\n", [G1]),
  assert(G1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setup :-
  assertify_lines('dat2.ssv'),

  actors(Actors),
  maplist(assert, Actors),
  
  % actions(Actions),
  % maplist(assert, Actions),

  non_actor_subjects(Subjects),
  maplist(assert, Subjects),
  
  loop_as;
  
  bind;

  %retract(r(_,_,_,_));
  
  true.



    
    
