:- use_module(library(pio)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grammar.
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

end_of_sequence([], []).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preds
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load_atom_lines_from_file(File) :- load_atom_lines_from_file(File, _).
load_atom_lines_from_file(File, Out) :-
   phrase_from_file(lines(In), File),
   retractall(r(_,_,_,_)),

   atomize_and_assert_lines(TmpOut, In),
   reverse(TmpOut, Out).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

atomize_and_assert_lines(Lines, Out) :-
   atomize_and_assert_lines([], Lines, Out).
   
atomize_and_assert_lines(Build, [], Out) :-
   Out = Build, !.

atomize_and_assert_lines(Build, [Line|Lines], Out) :-
   split_string(Line, " ", " ", Words),
   atomize(Words, [A1, A2, A3 | Atoms]),
   Term =.. [r, A1, A2, A3, Atoms],
   assertz(Term),
   atomize_and_assert_lines(Build, Lines, Out).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

atomize(In, Out) :-
   atomize([], In, TmpOut),
   reverse(TmpOut, Out).

atomize(Build, [], Out) :-
   Out = Build, !.

atomize(Build, [In|Ins], Out) :-
  atom_codes(Atomic, In),
  atomize([Atomic|Build], Ins , Out).

