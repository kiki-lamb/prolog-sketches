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

manifest(r(Thing, a, person, _)) :-
  format("    Manifest person ~w.\n",
         [Thing]),
  assertz(person(Thing)).


manifest(Term) :-
  format("    Manifest nothing ~w.\n",
         [Term]).  

a(  Obj,             SoughtType) :-
  r(Obj,         a,  SoughtType, _);
  r(Obj,         a,  ActualType, _),
  a(ActualType,      SoughtType   ).

loop_as :-
  a(Obj, Thing),
  declarify(Thing, Obj).

declarify(Type, Thing) :-
  G1 =.. [ Type, Thing ],
  aassertz(Type, G1).

declarify(Type, Thing, Thing2) :-
  G1 =.. [ Type, Thing, Thing2 ],
  aassertz(Type, G1).

aassertz(Type, G1) :-
  assertz(G1),
  format("=+~w> ~w.\n",
         [Type, G1]),
  fail.

loop_binary(Action) :- r(Thing, Action, Thing2, _),
                       declarify(Action, Thing, Thing2).

loop_reflexive(Action) :- r(Thing, Action, Thing2, _),
                          (declarify(Action, Thing, Thing2);
                           declarify(Action, Thing2, Thing)).

setup :- clean_up,
         assertify_lines('dat2.ssv'),
         loop_as;
         loop_reflexive(like);
         loop_binary(shop_at);
         loop_binary(dislike);
         true.


