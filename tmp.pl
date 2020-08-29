vegetable(cabbage).
vegetable(turnip).
vegetable(potato).

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
    loop;
    vegetable(hybrid(cabbage,turnip)), 
    true,
    write("Yum.").
