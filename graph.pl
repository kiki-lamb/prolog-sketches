:- dynamic cache/3.         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

path(Here, To, Stop) :-
   path(Here, To, _).

path(Here, To, Path) :-
   (
      human(Here),
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
   format("Found Final.\n", []),

   Path = [Here|Build].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

descend(Build, Here, To,  Path) :-
   human(Next),
   Here \== Next,
   not(member(Next, Build)),
   search(Build, Next, To, Path).
