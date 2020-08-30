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

:- op(300, xfy, isnt).
isnt(Thing, Class) :-
  \+( is_a(Thing, Class)).

:- op(300, xfy, is_a).
is_a(Thing, Class) :-
   (
      r(Thing, is_a, Class, _)
   ;  r(Thing, is_a, ActualType, _),
      is_a(ActualType, Class)
   ).

unique(Thing) :-
  \+( _ is_a Thing).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

combine(Left, Right, Out) :-
  findall([ L, R ], (member(L, Left), member(R, Right)), Out).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bind_classes :-
  is_a(Thing, Class),
  assert_list([Class, Thing]),
  fail.

bind_classes(Left, Action, Right, Out) :-
  % format("[ Bind ~w ~w ~w ]:\n", [Left, Action, Right]),
  findall(L, (L is_a Left),  Lefts ),
  % format("Lefts: ~w.\n",    [Lefts]),
  findall(R, (R is_a Right), Rights ),
  % format("Rights: ~w.\n",   [Rights]),
  combine([Left | Lefts], [Right | Rights], Tmp),
  % format("Tmp: ~w.\n",   [Tmp]),
  findall([Action, L, R], (member([L, R], Tmp)), Out).
  % format("Tmp2: ~w.\n",   [Tmp2]),
  
bind_classes(Left, Action, Right) :-
  bind_classes(Left, Action, Right, Out),
  maplist(assert_list, Out).

bind_actions :-
  r(Actor, Action, Subject, _),
  Action \== is_a,
  % format("[[ Binding ~w... ]]\n", [Action]),
  bind_classes(Actor, Action, Subject),
  fail.   

bind_mutual_likes :-
  r(Actor, like, Subject, _),
  bind_classes(Subject, like, Actor),
  fail.   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
  findall(
     Subject, ((
                    r(_, _, Subject, _),
                    not(member(Subject, Actors))
                 )),
     Tmp
  ),
  sort(Tmp, Out).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

assert_list(L) :-
  G1 =..  L,
  %format("-=> ~w\n", [G1]),
  assert(G1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setup :-
  assertify_lines('dat2.ssv'),
  (
      actors(Actors),
      maplist(assert, Actors)
  ),  
  (
      actions(Actions),
      maplist(assert, Actions)
  ),
  (
      non_actor_subjects(Subjects),
      maplist(assert, Subjects)
  ),  
  (
     bind_classes
  ;  bind_actions
  ;  bind_mutual_likes
  ;  true
  ).
  %retract(r(_,_,_,_));
  



    
    
