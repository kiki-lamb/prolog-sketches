:- initialization(main).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- op(400, xfy, likes).

sybil   likes kiki.
kiki    likes boson.
boson   likes higgy.
X       likes Y :-
   Y likes X.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

search(Here, There, Path) :-
   search(Here, There, Path, []).

search(Here, Here, Path, Build) :-
   reverse([Here|Build], Path).

search(Here, There, Path, Build) :-
   likes(Here, Next),
   not(member(Next, [Here|Build])),
   search(Next, There, Path, [Here|Build]).

main :-
   search(higgy, sybil, Path),
   format("~w.\n", [Path]),
   search(sybil, higgy, Path2),
   format("~w.\n", [Path2]),
   halt.
