:- use_module(library(pio)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preds
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load_atomized_lines_from_file(TagAs, File) :-
   load_atomized_lines_from_file(TagAs, File, _).

load_atomized_lines_from_file(TagAs, File, Out) :- 
   retractall(r(_,_,_,_)),
   phrase_from_file(lines(In), File),
   atomize_lines(TagAs, In, TmpOut),
   maplist(assert, TmpOut, TmpOut2),
   reverse(TmpOut2, Out).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

atomize_lines(TagAs, Lines, Out) :-
   atomize_lines([], TagAs, Lines, Out).

atomize_lines(Build, _, [], Out) :-
   Out = Build, !.

atomize_lines(Build, TagAs, [Line|Lines], Out) :-
   split_string(Line, " ", " ", Words),
   atomize(Words, [A1, A2, A3 | Atoms]),
   G1 =.. [ TagAs, A1, A2, A3, Atoms ],
   atomize_lines([G1|Build], TagAs, Lines, Out).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

atomize(In, Out) :-
   atomize([], In, TmpOut),
   reverse(TmpOut, Out).

atomize(Build, [], Out) :-
   Out = Build, !.

atomize(Build, [In|Ins], Out) :-
  atom_codes(Atomic, In),
  atomize([Atomic|Build], Ins , Out).

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
