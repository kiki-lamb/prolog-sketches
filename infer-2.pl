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

loop_as :-
  is_a(Thing, Class),
  declarify([Class, Thing]),
  fail.

is_a(Thing, Class) :-
  r(Thing, a,  Class, _) ;
  r(Thing, a,  ActualType, _),
  is_a(ActualType, Class).

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
  format("Tmp2: ~w.\n",   [Tmp2]),
  maplist(declarify, Tmp2).

actions(Out) :-
  findall(Action, ((r(_, Action, _, _))), Tmp),
  sort(Tmp, Out).

bind :-
  r(Subject, Action, Target, _),
  Action \== a,
  format("Binding ~w(~w, ~w)...\n", [Action, Subject, Target]),
  bind_classes(Subject, Action, Target),
  fail.    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

assert1(G) :-
  catch((\+( G ), !), _, fail);
  assert(G).

declarify(L) :-
  G1 =..  L,
  assert(G1),
  format("-=> ~w\n", [G1]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setup :-
  assertify_lines('dat2.ssv'),
  loop_as;
  bind;
%  retract(r(_,_,_,_));
  true.



    
    
