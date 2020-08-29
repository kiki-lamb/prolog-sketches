vegetable(cabbage).
vegetable(turnip).
vegetable(potato).

% vegetable(hybrid(X,Y)) :-
%     X @< Y,
%     vegetable(X),
%     vegetable(Y).

loop :- 
    % Desired behaviour: 
    %   print a list of 6 items, including 3 hybrid variants.
    % Actual behaviour: 
    %   only 3 non-hybrid options are printed.
    vegetable(X),
    format("Vegetable: ~w\n", [X]),
    fail.


:- op(500, xf, is_dead).

is_dead(X) :-
  vegetable(X).

main :- % Query this...
    loop ;
    true.
