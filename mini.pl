likes(sybil, kiki).
likes(kiki, sybil).

likes(boson, kiki).
likes(kiki, boson).


search(Here, Here, [Here|Path], Path).

search(Here, There, Path, Build) :-
   likes(There, Next),
   not(member(Next, [There|Build])),
   
   search(Here, Next, Path, [There|Build]).


  
