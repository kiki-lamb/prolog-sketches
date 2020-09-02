:- initialization(main).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- op(400, xfx, likes).

sybil   likes kiki.
kiki    likes boson.
boson   likes higgy.
X       likes Y :-
   Y likes X.


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
   likes(Here, Next),
   Next ne [Here|Build],
   search(Next, There, Path, [Here|Build]).

main :-
   search(higgy, sybil, Path),
   format("~w.\n", [Path]),
   search(sybil, higgy, Path2),
   format("~w.\n", [Path2]),
   halt.
