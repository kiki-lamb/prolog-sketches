likes(sybil, kiki).
likes(kiki, sybil).

likes(boson, kiki).
likes(kiki, boson).

likes(boson, higgy).
likes(higgy, boson).

search(Here, Here, Path, Build) :-
   reverse([Here|Build], Path).

search(Here, There, Path, Build) :-
   likes(Here, Next),
   not(member(Next, [Here|Build])),
   search(Next, There, Path, [Here|Build]).
