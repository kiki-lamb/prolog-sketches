:- initialization(main).
:- consult("facts.pl").
:- consult("exists.pl").
:- consult("infer.pl").
:- consult("graph.pl").

possible       :- could(W,A,T),
                  format("~w could ~w ~w.\n",
                         [W, A, T]),
                  fail.

possible_paths :- person(W),
                  could(W,A,T,P),
                  format("~w could ~w ~w: ~w.\n",
                         [W, A, T, P]),
                  fail.

desires        :- would(P,A,X),
                  format("~w would ~w ~w.\n", [P,A,X]),
                  fail.  

apaths         :- apath(W,T,P),
                  format("~w -> ~w: ~w\n", [W,T,P]),
                  fail.
    
main           :- apaths ;
                  possible ;
                  true.
