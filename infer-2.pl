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
  r(Obj,         a2, SoughtType, _);
  r(Obj,         a2, ActualType, _),
  a(ActualType,      SoughtType   ).


loop_as   :- a(Obj, Thing),
             G =.. [ Thing, Obj ],
             format(">=> ~w.\n",
                    [G]),

             assertz(G),
             fail.

loop_rs   :- r(Thing, Verb, Noun, Options),
             format("\n+=> r(~w, ~w, ~w, ~w.\n",
                    [Thing, Verb, Noun, Options]),
             manifest((r(Thing, Verb, Noun, Options))),
             fail.

setup     :- clean_up,
             assertify_lines('dat2.ssv'),
             %             loop_rs;
             loop_as;
             true.


