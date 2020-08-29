%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
path(   Start, Here, Move, To,   Stop      ) :- path(Start, Here, Move, To, Stop, _).
path(   Start, Here, Move, To,   Stop, Path) :- call(Start, Here),
                                                search([], Here, Move, To, Stop, Tmp),
                                                reverse([To|Tmp], Path).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
search( Build, Here, Move, To,   Stop, Path) :- found(Build, Here, Move, To, Stop, Path) ;
                                                descend([Here|Build], Here, Move, To, Stop, Path).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
descend(Build, Here, Move, To,   Stop, Path) :- call(Move, Here, Next),
                                                not(member(Next, Build)),
                                                search(Build, Next, Move, To, Stop, Path).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
found(  Build, Here, _,    Here, _,    Path) :- Path = Build. 
found(  Build, Here, _,    To,   Stop, Path) :- call(Stop, Here, To),
                                                found([Here|Build], Here, _, Here, Stop, Path).
