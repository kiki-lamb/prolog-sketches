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
   \+( isa(Thing, Class)).

:- op(300, xfy, isa).
isa(Thing, Class) :-
   (
      r(Thing, isa, Class, _)
   ;  r(Thing, isa, ActualType, _),
      isa(ActualType, Class)
   ).

concrete(Thing) :-
   \+( abstract(Thing)).

abstract(Thing) :-
   _ isa Thing.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

combine(Left, Right, Out) :-
   findall([ L, R ], (member(L, Left), member(R, Right)), Out).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bind_classes :-
%   concrete(Thing),
   isa(Thing, Class),
   logged_assert_list([Class, Thing]),
   fail.

bind_classes(Left, Action, Right, Out) :-
   % format("[ Bind ~w ~w ~w ]:\n", [Left, Action, Right]),
   findall(L, (L isa Left),  Lefts ),
   % format("Lefts: ~w.\n",    [Lefts]),
   findall(R, (R isa Right), Rights ),
   % format("Rights: ~w.\n",   [Rights]),
   combine([Left | Lefts], [Right | Rights], Tmp),
   % format("Tmp: ~w.\n",   [Tmp]),
   findall([Action, L, R], (member([L, R], Tmp)), Out).
% format("Tmp2: ~w.\n",   [Tmp2]),

bind_classes(Left, Action, Right) :-
   bind_classes(Left, Action, Right, Out),
   maplist(logged_assert_list, Out).

bind_actions :-
   r(Actor, Action, Subject, _),
   Action \== isa,
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

logged_assert_list(L) :-
   G1 =..  L,
   format("    ~~=> ~w.\n", [G1]),
   assert(G1).

logged_assert(G1) :-
   format("    ~~=> ~w.\n", [G1]),
   assert(G1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setup :-
   % File = 'dat.ssv',
   File = 'small_world.ssv',   
   (
      assertify_lines(File),
      format("[[Setup]] Loaded lines from '~w'.\n",[File]);
      format("[[Setup]] ERROR: Could nod load lines from '~w'.\n",[File])
   ),      
   (
      format("[[Setup]] Defining Actors...\n",[]),
      actors(Actors),
      maplist(logged_assert, Actors)
   ),  
   (
      format("[[Setup]] Defining Actions...\n",[]),
      actions(Actions),
      maplist(logged_assert, Actions)
   ),   
   (
      format("[[Setup]] Defining Subjects...\n",[]),
      non_actor_subjects(Subjects),
      maplist(logged_assert, Subjects)
   ),   
   (
      format("[[Setup]] Binding Classes...\n",[]),
      bind_classes      
   ;  format("[[Setup]] Binding Actions...\n",[]),
      bind_actions      
   ;  format("[[Setup]] Binding mutual Likes.\n",[]),
      bind_mutual_likes
   ;  format("[[Setup]] Complete.\n",[]),
      true
   ).
%retract(r(_,_,_,_));
