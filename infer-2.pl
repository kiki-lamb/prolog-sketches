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

clean_up  :- retractall(person2(_)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

is_a(Thing, Class) :-
  r(Thing, a,  Class, _) ;
  r(Thing, a,  ActualType, _),
  is_a(ActualType, Class).

loop_as :-
  is_a(Thing, Class),
  declarify(Class, Thing),
  fail.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


combine(Left, Right, Out) :-
  bagof([ L, R ], (member(L, Left), member(R, Right)), Out).

bind_list(Left, Right, Out) :-
  bagof(L, (is_a(L, Left )), Lefts ),
  bagof(R, (is_a(R, Right)), Rights),
  combine([Left | Lefts], [Right | Rights], Out).

bind_to(Class, Action, Subject) :-
  format("[~w ~w ~w]\n", [Class, Action, Subject]),
  dddeclarify(Action, Class, Subject);
  bagof(SubjectSubClass, (is_a(SubjectSubClass, Subject)), SubjectSubClasses),
  maplist(dddeclarify(Action, Class), SubjectSubClasses),

  bagof(SubClass,        (is_a(SubClass,        Class)),   SubClasses),
  
  format("~w actors:  ~w.\n", [ Class, SubClasses ]),
  format("~w targets: ~w.\n", [ Subject, SubjectSubClasses ]),
  
  maplist(derp(Action, SubClasses), SubjectSubClasses).



magic_loop(Action) :- 
  r(Class, Action, Subject, _),
  bind_to(Class, Action, Subject).
  
%  format("[ ~w ~w ~w ]\n", [Class, Action, Subject]),
%  declarify(Action, Class, Subject),
%
%  is_a(Thing, Class),
%  format("[ ~w ~w ~w ]\n", [Thing, Action, Subject]),
%  declarify(Action, Thing, Subject). 

loop_binary(Action) :-
  r(Thing, Action, Thing2, _),
  declarify(Action, Thing, Thing2),
  fail.

loop_reflex(Action) :-
  r(Thing, Action, Thing2, _),
  (declarify(Action, Thing, Thing2);
   declarify(Action, Thing2, Thing)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

declarify(Action, Thing) :-
  G1 =.. [ Action, Thing ],
  aassertz(Action, G1).

declarify(Action, Thing, Subject) :-
  G1 =.. [ Action, Thing, Subject ],
  aassertz(Action, G1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
aassertz(Action, G1) :-
  assertz(G1),
  format("=+~w> ~w.\n",
         [Action, G1]),
  fail.

setup :-
  clean_up,
  assertify_lines('dat2.ssv'),
%  loop_as;
%  loop_reflex(like);
%  magic_loop(eat);
%  magic_loop(drink);
%  magic_loop(give);
%  magic_loop(has);
%  magic_loop(smoke);
%  magic_loop(shop_at);
%  magic_loop(dislike);
%  retract(r(_,_,_,_));
  true.



    
    
