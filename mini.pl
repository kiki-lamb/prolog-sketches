likes(sybil, kiki).
likes(kiki, sybil).

likes(boson, kiki).
likes(kiki, boson).


search(Here, Here, Path, [Here|Path]).

search(Here, There, Build, Path) :-
   likes(Here, Next), 
   not(member(Next, [Here|Build])),
   search(Next, There, [Here|Build], Path).


  
