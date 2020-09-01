:- use_module(library(pio)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lines([]) -->
   call(eos), !.

lines([CLine|Lines]) -->
   collect_line(CLine),
   lines(Lines).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

eos([], []).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

collect_lines(Ls, File) :-
   phrase_from_file(lines(Ls), File).

collect_line([]) -->
   (".\n" ; call(eos)), !.

collect_line([L|Ls]) -->
   [L], collect_line(Ls).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

suspicious_map(Build, Out) :-
   Out = Build.

suspicious_map(Using, In, Out) :-
   G =.. [ Using, In, [], Tmp ],
   call(G),
   reverse(Tmp, Out).


load_atom_lines_from_file(File) :-
   collect_lines(Ls, File),
   load_atom_lines_from_file(Ls, _).

load_atom_lines_from_file(In, Out) :-
   retractall(r(_,_,_,_)),
   suspicious_map(aasertify_lines, In, Out).

aasertify_lines([], Build, Out) :-
   suspicious_map(Build, Out), !.

aasertify_lines([Line|Lines], Build, Out) :-
   split_string(Line, " ", " ", Words),
   atomize(Words, [A1, A2, A3 | Atoms]),
   Term =.. [r, A1, A2, A3, Atoms],
   assertz(Term),
   aasertify_lines(Lines, Build, Out).


atomize(In, Out) :-
   suspicious_map(aatomize, In, Out).

aatomize([], Build, Out) :-
   suspicious_map(Build, Out), !.

aatomize([In|Ins], Build, Out) :-
  atom_codes(Atomic, In),
  aatomize(Ins, [Atomic|Build], Out).

