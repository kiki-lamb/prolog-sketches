likes(sybil, kiki).
likes(kiki, sybil).

likes(boson, kiki).
likes(kiki, boson).


search(Here, Here, Path, [Here|Path]).

search(Here, There, Build, Path) :-
   likes(There, Next),
   not(member(Next, [There|Build])),
   search(Here, Next, [There|Build], Path).


  
