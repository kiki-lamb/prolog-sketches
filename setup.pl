:- consult("file_reader.pl").

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- op(400, xfx, is_a).

Thing is_a Class :-
   member_of(Thing, Class).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- op(400, xfx, elem).

This elem That :-
   member(This, That).

%-------------------------------------------------------------------------------

:- op(400, xfx, nelem).

This nelem That :-
   \+ This elem That.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setup :-
   % File = 'dat.ssv',
   File = 'small_world.ssv',   
   (
      load_atomized_lines_from_file(raw_lines, File),
      format("[[Setup]] Loaded lines from '~w'.\n",[File]);
      format("[[Setup]] ERROR: Could nod load lines from '~w'.\n",[File])
   ),
   (
      format("[[Setup]] Defining Actors...\n",[]),
      actors(Actors),
      maplist(clean_assert, Actors) ,
      maplist(reify, Actors)
   ),
      (
      format("[[Setup]] Defining Subjects...\n",[]),
      non_actor_subjects(Subjects),
      maplist(clean_assert, Subjects),
      maplist(reify, Subjects)
   ),   
   (
      format("[[Setup]] Defining Actions...\n",[]),
      actions(Actions),
      maplist(logged_assert, Actions),
      bagof([action, Action], (
               Action elem Actions,
               G1 =.. [Action, _],
               assert(G1),
               op(200, xfx, Action)
            ), Tmp),
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
      cache_paths
   ;  log_paths
   ;  nl,
      log_paths_count
   ,  format("[[Setup]] Complete.\n",[]),
      true
   ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

actors(Out) :-
   findall(Actor, ((raw_lines(Actor, _, _, _))), Tmp),
   sort(Tmp, Out).

actions(Out) :-
   findall(Action, ((raw_lines(_, Action, _, _))), Tmp),
   sort(Tmp, Out).

subjects(Out) :-
   findall(Subject, ((raw_lines(_, _, Subject, _))), Tmp),
   sort(Tmp, Out).

non_actor_subjects(Out) :-
   actors(Actors),
   findall(Subject, ((raw_lines(_, _, Subject, _), Subject nelem Actors)), Tmp),
   sort(Tmp, Out).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

reify(Thing) :-
   (
      _ is_a Thing,
      logged_assert(abstract(Thing))
   ;  logged_assert(concrete(Thing))
   ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bind_classes :-
   Thing is_a Class,
   logged_assert_list([Class, Thing]),
   fail.

bind_actions :-
   raw_lines(Actor, Action, Subject, _),
   Action \== isa,
   cross_bind(Actor, Action, Subject),
   fail.   

bind_mutual_likes :-
   raw_lines(Actor, like, Subject, _),
   cross_bind(Subject, like, Actor),
   fail.   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cross_bind(Left, Action, Right) :-
   findall(L, L is_a Left,  Lefts),
   findall(R, R is_a Right, Rights),
   findall([ L, R ], (L elem [Left | Lefts], R elem [Right | Rights]), Tmp),
   findall([Action, L, R], [L, R] elem Tmp, Tmp2),
   maplist(logged_assert_list, Tmp2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

member_of(Thing, Class) :-
   (
      raw_lines(Thing, isa, Class, _)
   ;  raw_lines(Thing, isa, ActualType, _),
      member_of(ActualType, Class)
   ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Logging
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
   clean_assert(G1).

clean_assert(G1) :-
   dynamic(G1),
   retract(G1)
   ;  true,
      assertz(G1).
