:- dynamic cache/3.         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

path(Here, To) :-
   path(Here, To, _).

path(Here, To, Path) :-
   (
      human(Here),
      human(To),
      Here \== To,
      
      search([], Here, To, Tmp),
      reverse([To|Tmp], Path)
   ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

search( Build, Here, To, Path) :-
   (
      found(Build, Here, To, Path)
   ;  descend([Here|Build], Here, To, Path)
   ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

found(Build, Here, Here, Path) :-
   Path = [Here|Build].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

descend(Build, Here, To,  Path) :-
   human(Next),
   Here \== Next,
   not(member(Next, Build)),
   search(Build, Next, To, Path).
