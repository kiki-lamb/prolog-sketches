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

loop_as     :- a(Obj, Thing),
               G1 =.. [ Thing, Obj ],
               format("=a>       ~w.\n",
                      [G1]),                 
               assertz(G1),
               fail.

loop_likes  :- r(Thing, like, Thing2, _),
               G1 =.. [ like, Thing,  Thing2 ],
               G2 =.. [ like, Thing2, Thing  ],
               format("=like>    ~w.\n",
                      [G1]),                 
               assertz(G1),
               format("=like>    ~w.\n",
                      [G2]),                 
               assertz(G2),
               fail.

loop_shop_at :- r(Thing, shop_at, Thing2, _),
                G1 =.. [ shop_at, Thing,  Thing2 ],
                format("=shop_at> ~w.\n",
                       [G1]),                 
                assertz(G1),
                fail.

loop_dislike :- r(Thing, dislike, Thing2, _),
                G1 =.. [ dislike, Thing,  Thing2 ],
                format("=dislike> ~w.\n",
                       [G1]),                 
                assertz(G1),
                fail.

loop_rs     :- r(Thing, Verb, Noun, Options),
               format("\n+=> r(~w, ~w, ~w, ~w.\n",
                      [Thing, Verb, Noun, Options]),
               manifest((r(Thing, Verb, Noun, Options))),
               fail.

setup       :- clean_up,
               assertify_lines('dat2.ssv'),
               loop_as;
               loop_likes;
               loop_shop_at;
               loop_dislike;
               true.


