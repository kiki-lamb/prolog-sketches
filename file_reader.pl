:- use_module(library(pio)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

collect_line([]) -->
   (".\n" ; end_of_sequence), !.

collect_line([L|Ls]) -->
   [L], collect_line(Ls).

lines([]) -->
   call(end_of_sequence), !.

lines([CLine|Lines]) -->
   collect_line(CLine),
   lines(Lines).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end_of_sequence([], []).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

atomize_and_assert_lines([], Build, Out) :-
   Out = Build, !.

atomize_and_assert_lines([Line|Lines], Build, Out) :-
   split_string(Line, " ", " ", Words),
   atomize(Words, [A1, A2, A3 | Atoms]),
   Term =.. [r, A1, A2, A3, Atoms],
   assertz(Term),
   atomize_and_assert_lines(Lines, Build, Out).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

atomize(In, Out) :-
   atomize([], In, Tmp),
   reverse(Tmp, Out).

atomize(Build, [], Out) :-
   Out = Build, !.

atomize(Build, [In|Ins], Out) :-
  atom_codes(Atomic, In),
  atomize([Atomic|Build], Ins , Out).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load_atom_lines_from_file(File) :-
   phrase_from_file(lines(Ls), File),
%  load_atom_lines_from_file(Ls, _).
% 
%  load_atom_lines_from_file(In, Out) :-
   retractall(r(_,_,_,_)),
   atomize_and_assert_lines(In, [], Tmp),
   reverse(Tmp, Out).

