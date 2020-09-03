:- consult("file-reader.pl").

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- op(400, xfx, is_a).

Thing is_a Class :-
   member_of(Thing, Class).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- op(400, xfx, elem).

This elem That :-
   member(This, That).

%-----------------------------------------------------------

:- op(400, xfx, nelem).

This nelem That :-
   \+ This elem That.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setup :-
   setup("dat.ssv").

setup(File) :-
   format("[[Setup]] Begin setup.\n",[]),
   setup_file(File),
   setup_actors,
   setup_subjects,
   setup_actions,   
   setup_class_bindings,
   setup_action_bindings,
   setup_mutual_likes,
   setup_paths,
   format("[[Setup]] Setup complete.\n",[]).

%-----------------------------------------------------------

setup_file(File) :-
   load_atomized_lines_from_file(raw_lines, File),
   format("[[Setup]] Loaded lines from '~w'.\n",[File]);
   format(
      "[[Setup]] ERROR: Could not load '~w'.\n",
      [File]
   ).

setup_actors :-
   format("[[Setup]] Defining Actors...\n",[]),
   actors(Actors),
%   maplist(logged_assert, Actors),
   maplist(reify, Actors).

setup_subjects :-
   format("[[Setup]] Defining Subjects...\n",[]),
   non_actor_subjects(Subjects),
%   maplist(logged_assert, Subjects),
   maplist(reify, Subjects).

setup_actions :-
   format("[[Setup]] Defining Actions...\n",[]),
   actions(Actions),
%   maplist(logged_assert, Actions),
   findall(
      [action, Action],
      (
         Action elem Actions,
         G1 =.. [Action, _],
         assert(G1)
      ), Tmp
   ),
   maplist(logged_assert_list, Tmp).

setup_class_bindings :-
   format("[[Setup]] Binding Classes...\n",[]),
   bind_classes;
   true.

setup_action_bindings :-
   format("[[Setup]] Binding Actions...\n",[]),
   bind_actions;
   true.

setup_mutual_likes :-
   format("[[Setup]] Binding mutual Likes.\n",[]),
   bind_mutual_likes;
   true.

setup_paths :-
   format("[[Setup]] Charting paths...\n",[]),
   cache_paths;
   log_paths,
   true.

%-----------------------------------------------------------

bind_classes :-
   Thing is_a Class,
   op(200, fx, Thing),
   logged_assert_list([Class, Thing]),
   fail.

bind_actions :-
   raw_lines(Actor, Action, Subject, _),
   Action \== isa,
%   op(200, xfx, Action),
   cross_bind(Actor, Action, Subject),
   fail.   

bind_mutual_likes :-
   raw_lines(Actor, likes, Subject, _),
   cross_bind(Subject, likes, Actor),
   fail.   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cross_bind(Left, Action, Right) :-
   findall(L, L is_a Left,  Lefts),
   findall(R, R is_a Right, Rights),
   findall(
      [ L, R ],
      (L elem [Left|Lefts], R elem [Right|Rights]),
      Tmp
   ),
   findall([Action, L, R], [L, R] elem Tmp, Tmp2),
   maplist(logged_assert_list, Tmp2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

actors(Out) :-
   findall(Actor, ((raw_lines(Actor, _, _, _))), Tmp),
   sort(Tmp, Out).

actions(Out) :-
   findall(Action, ((raw_lines(_, Action, _, _))), Tmp),
   sort(Tmp, Out).

subjects(Out) :-
   findall(Subject, ((raw_lines(_, _, Subject, _))), Tmp),
   sort(Tmp, Out).

%-----------------------------------------------------------

non_actor_subjects(Out) :-
   actors(Actors),
   findall(
      Subject,
      ((raw_lines(_, _, Subject, _),
        Subject nelem Actors)),
      Tmp),
   sort(Tmp, Out).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

reify(Thing) :-
   (
      _ is_a Thing,
      logged_assert(abstract(Thing))
   ;  logged_assert(concrete(Thing))
   ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

member_of(Thing, Class) :-
   raw_lines(Thing, isa, Class, _).
   

member_of(Thing, Class) :-
   raw_lines(Thing, isa, ActualType, _),
   member_of(ActualType, Class).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Logging
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

logged_assert_list(L) :-
   G1 =..  L,
   logged_assert(G1).

logged_assert(G1) :-
   dynamic(G1),
%   format("   -~~=> ~w.\n", [G1]),
   (
      retract(G1)
   ;  true
   ),
   clean_assert(G1).

clean_assert(G1) :-
   dynamic(G1),
   (retract(G1)
   ;  true,
      assertz(G1)).
