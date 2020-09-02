:- initialization(main).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

likes(sybil, kiki).
likes(kiki, sybil).

likes(boson, kiki).
likes(kiki, boson).

likes(boson, higgy).
likes(higgy, boson).

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
