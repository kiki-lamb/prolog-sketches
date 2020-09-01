:- consult("file_reader.pl").


memberof(Thing, Class) :-
   (
      r(Thing, isa, Class, _)
   ;  r(Thing, isa, ActualType, _),
      memberof(ActualType, Class)
   ).

reify(Thing) :-
   (
      memberof(_, Thing),
      logged_assert(abstract(Thing))
   ;  logged_assert(concrete(Thing))
   ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

combine(Left, Right, Out) :-
   findall([ L, R ], (member(L, Left), member(R, Right)), Out).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bind_classes :-
   memberof(Thing, Class),
   logged_assert_list([Class, Thing]),
   fail.

bind_classes(Left, Action, Right, Out) :-
   findall(L, (memberof(L, Left)),  Lefts ),
   findall(R, (memberof(R, Right)), Rights ),
   combine([Left | Lefts], [Right | Rights], Tmp),
   findall([Action, L, R], (member([L, R], Tmp)), Out).


bind_classes(Left, Action, Right) :-
   bind_classes(Left, Action, Right, Out),
   maplist(logged_assert_list, Out).

bind_actions :-
   r(Actor, Action, Subject, _),
   Action \== isa,
   bind_classes(Actor, Action, Subject),
   fail.   

bind_mutual_likes :-
   r(Actor, like, Subject, _),
   bind_classes(Subject, like, Actor),
   fail.   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

logged_assert_list(L) :-
   G1 =..  L,
   logged_assert(G1).

logged_assert(G1) :-
   dynamic(G1),
   format("   -~~=> ~w.\n", [G1]),
   (
      retract(G1)
   ;  true
   ),
   assertz(G1).

unlogged_assert(G1) :-
   dynamic(G1),
   retract(G1)
   ;  true,
      assertz(G1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
      maplist(unlogged_assert, Actors) ,
      maplist(reify, Actors)
   ),
      (
      format("[[Setup]] Defining Subjects...\n",[]),
      non_actor_subjects(Subjects),
      maplist(unlogged_assert, Subjects),
      maplist(reify, Subjects)
   ),   
   (
      format("[[Setup]] Defining Actions...\n",[]),
      actions(Actions),
      maplist(logged_assert, Actions),
      bagof([action, Action], (member(Action, Actions)), Tmp),
      maplist(logged_assert_list, Tmp)
   ),   
   (
      format("[[Setup]] Binding Classes...\n",[]),
      bind_classes      
   ;  format("[[Setup]] Binding Actions...\n",[]),
      bind_actions      
   ;  format("[[Setup]] Binding mutual Likes.\n",[]),
      bind_mutual_likes
   ;  format("[[Setup]] Charting paths...\n",[]),
      stash_paths;
      log_paths;
      nl,
      log_paths_count
   ;  format("[[Setup]] Complete.\n",[]),
      true
   ), !.
%retract(r(_,_,_,_));
