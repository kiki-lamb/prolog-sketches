vegetable(cabbage).
vegetable(turnip).
vegetable(potato).

vegetable(Hybrid) :-
    functor(Hybrid, hybrid, 2),
    arg(1, Hybrid, X),
    arg(2, Hybrid, Y),
    X @< Y, 
    vegetable(X),
    vegetable(Y).

loop :- 
    % Desired behaviour: 
    %   print a list of 6 items, including 3 hybrid variants.
    % Actual behaviour: 
    %   only 3 non-hybrid options are printed.
    vegetable(X),
    format("Vegetable: ~w\n", [X]),
    fail.

main :- % Query this...
    loop ;
    true.
