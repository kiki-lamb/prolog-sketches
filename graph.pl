:- dynamic cache/3.         

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
stash(Here, To, Path) :- assert(cache(Here, To, Path)).

recover(Here, To, Path) :-
   ((cache(Here, To, Path) ;
     (cache(To, Here, Tmp),
      reverse(Tmp,Path))),
    
    format("... grab ~w -> ~w: ~w.\n",
           [Here, To, Path]),    
    !).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

path(   Start, Here, Move, To,   Stop      ) :- path(Start, Here, Move, To, Stop, _).
path(   Start, Here, Move, To,   Stop, Path) :- %recover(Here, To),
                                                recover(Here, To, Path);
                                                
                                                call(Start, Here),
                                                search([], Here, Move, To, Stop, Tmp),
                                                reverse([To|Tmp], Path),
                                                
                                                format("... stash ~w -> ~w: ~w.\n",
                                                      [Here, To, Path]),

                                                stash(Here, To, Path).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
search( Build, Here, Move, To,   Stop, Path) :- found(Build, Here, To, Stop, Path) ;
                                                descend([Here|Build], Here, Move, To, Stop, Path).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
found(  Build, Here,       Here, _,    Path) :- Path = Build. 
found(  Build, Here,       To,   Stop, Path) :- call(Stop, Here, To),
                                                found([Here|Build], Here, Here, Stop, Path).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
descend(Build, Here, Move, To,   Stop, Path) :- call(Move, Here, Next),
                                                not(member(Next, Build)),
                                                search(Build, Next, Move, To, Stop, Path).
