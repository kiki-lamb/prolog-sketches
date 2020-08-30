%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% start_2(X)              :- fail.
% move_2( Here, To)       :- fail.
% stop_2( Here, To)       :- fail.
% ppath_2(Here, To)       :- ppath_2(Here, To, _).
% ppath_2(Here, To, Path) :- fail.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a(   Obj,           SoughtType, _) :-
%   r( Obj,       a, SoughtType,  _);
%   r( Obj,       a, ActualType,  _),
%   a(ActualType,    SoughtType,  _).
% 
% does(_,   a) :- fail.
% does(Obj, Action) :-
%   Action \== a,
%   r( Obj, Action, _, _);
%   r( Obj, a, Actual, _), r(Actual, Action, _, _).
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% setup :-
%   r(Thing, Verb, Noun, Options),
%   format("+=> r(~w, ~w, ~w, ~w.\n",
%          [Thing, Verb, Noun, Options]),
%   fail.

manifest(X) :-
  format("Manifest ~s.\n",
         [X]).

loop_rs   :- r(Thing, Verb, Noun, Options),
             format("+=> r(~w, ~w, ~w, ~w.\n",
                    [Thing, Verb, Noun, Options]),
             manifest((r(Thing, Verb, Noun, Options))),
             fail.

setup     :- assertify_lines('dat.ssv'),
             loop_rs;
             true.


