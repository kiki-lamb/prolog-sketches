:- use_module(library(pio)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

collect_line([]) -->
   (".\n" ; call(end_of_sequence)), !.

collect_line([L|Ls]) -->
   [L], collect_line(Ls).

collect_lines(Ls, File) :-
   phrase_from_file(lines(Ls), File).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lines([]) -->
   call(end_of_sequence), !.

lines([CLine|Lines]) -->
   collect_line(CLine),
   lines(Lines).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end_of_sequence([], []).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

suspicious_map(Using, In, Out) :-
   G =.. [ Using, In, [], Tmp ],
   call(G),
   reverse(Tmp, Out).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

asertify_lines([], Build, Out) :-
   Out = Build, !.

asertify_lines([Line|Lines], Build, Out) :-
   split_string(Line, " ", " ", Words),
   atomize(Words, [A1, A2, A3 | Atoms]),
   Term =.. [r, A1, A2, A3, Atoms],
   assertz(Term),
   asertify_lines(Lines, Build, Out).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

atomize(In, Out) :-
   suspicious_map(aatomize, In, Out).

aatomize([], Build, Out) :-
   Out = Build, !.

aatomize([In|Ins], Build, Out) :-
  atom_codes(Atomic, In),
  aatomize(Ins, [Atomic|Build], Out).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load_atom_lines_from_file(File) :-
   collect_lines(Ls, File),
   load_atom_lines_from_file(Ls, _).

load_atom_lines_from_file(In, Out) :-
   retractall(r(_,_,_,_)),
   suspicious_map(asertify_lines, In, Out).

