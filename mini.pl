:- initialization(main).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- op(400, xfx, links).

sybil   links kiki.
kiki    links boson.
boson   links higgy.
X       links Y :-
   Y links X.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- op(400, xfx, ne).

This ne That :-
   not(member(This, That)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

search(Here, There, Path) :-
   search(Here, There, Path, []).

search(Here, Here, Path, Build) :-
   reverse([Here|Build], Path).

search(Here, There, Path, Build) :-
   Here links Next,
   Next ne [Here|Build],
   search(Next, There, Path, [Here|Build]).

main :-
   search(higgy, sybil, Path),
   format("~w.\n", [Path]),
   search(sybil, higgy, Path2),
   format("~w.\n", [Path2]),
   halt.
