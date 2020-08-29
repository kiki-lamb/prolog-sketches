:- initialization(main).

vegetable(cabbage).
vegetable(turnip).
vegetable(potato).

% vegetable(Hybrid) :-
%     functor(Hybrid, hybrid, 2),
%     arg(1, Hybrid, Left),
%     arg(2, Hybrid, Right),
%
%     sort([X,Y], L),
%     L == [X,Y],
%     atom(Left),
%     atom(Right),
%     vegetable(Left),
%     vegetable(Right).

vegetable(hybrid(X,Y)) :-
    atom(X),
    atom(Y),
    X \== Y,
    sort([X,Y], L),
    L == [X,Y],
    vegetable(X),
    vegetable(Y).

loop :- 
    vegetable(X), 
 	format("Vegetable: ~w\n", [X]),
 	fail.

main :-
    vegetable(hybrid(cabbage,turnip)),
    write("Yum.\n"),
    loop;
    halt.
