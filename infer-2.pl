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
%   r(Q, W, E, R),
%   format("+=> r(~w, ~w, ~w, ~w.\n",
%          [Q, W, E, R]),
%   fail.

loop_rs   :- r(Q, W, E, R),
             format("+=> r(~w, ~w, ~w, ~w.\n",
                    [Q, W, E, R]),
             fail.

setup     :- assertify_lines('dat.ssv'),
             loop_rs;
             true.


