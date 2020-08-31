:- dynamic cache/3.         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

path(Here, To) :-
   path(Here, To, _).

path(Here, Here, [Here]) :-
   human(Here),
      format(" -~~-> path(~w, ~w, ~w)\n",
             [Here, To, Path]).

path(Here, To, Path) :-
   (
      human(Here),                  
      human(To),
      Here \== To,
      
      search([], Here, To, Tmp),
      reverse([To|Tmp], Path),
      format(" -~~=> path(~w, ~w, ~w)\n",
             [Here, To, Path])
   ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

search( Build, Here, To, Path) :-
   (
      found(Build, Here, To, Path)
   ;  descend([Here|Build], Here, To, Path)
   ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

found(Build, Here, Here, Path) :-
   Path = Build.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

descend(Build, Here, To,  Path) :-
   human(Next),
   Here \== Next,
   not(member(Next, Build)),
   search(Build, Next, To, Path).
