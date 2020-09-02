:- initialization(main).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- op(400, xfx, links).

sybil   links kiki.
kiki    links boson.
boson   links higgy.
X       links Y :-
   Y links X.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- op(400, xfx, e).

This elem That :-
   member(This, That).

%-------------------------------------------------------------------------------

:- op(400, xfx, ne).

This nelem That :-
   \+ This elem That.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- op(400, xfx, =>).

Here => (There, Path) :-
   search(Here, There, Path).

Here => There :-
   Here => (There, _).

:- op(400, xfx, <=).

There <= (Here, Path) :-
   Here => (There, Path).

There <= Here :-
   Here => There.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

search(Here, There) :-
   search(Here, There, _).
      
search(Here, There, Path) :-
   search(Here, There, Path, []).

search(Here, Here, Path, Build) :-
   reverse([Here|Build], Path).

search(Here, There, Path, Build) :-
   Here links Next,
   Next nelem [Here|Build],
   search(Next, There, Path, [Here|Build]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

main :-
   higgy => (sybil, Path),
   format("~w.\n", [Path]),

   sybil => (higgy, Path2),
   format("~w.\n", [Path2]),

   higgy => sybil,
   format("Yes.\n", []),

   sybil => higgy,
   format("Yes.\n", []),
   
   halt.
