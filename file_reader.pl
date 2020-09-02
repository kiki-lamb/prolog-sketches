:- use_module(library(pio)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preds
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load_atomized_lines_from_file(Tag, File) :-
   load_atomized_lines_from_file(Tag, File, _).

load_atomized_lines_from_file(Tag, File, Out) :- 
   retractall(r(_,_,_,_)),
   phrase_from_file(lines(In), File),
   atomize_lines(Tag, In, TmpOut),
   maplist(assert, TmpOut, TmpOut2),
   reverse(TmpOut2, Out).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

atomize_lines(Tag, Lines, Out) :-
   atomize_lines([], Tag, Lines, Out).

atomize_lines(Build, _, [], Out) :-
   Out = Build, !. %,
%   format("List is ~w.\n", [Out]).

atomize_lines(Build, Tag, [Line|Lines], Out) :-
   split_string(Line, " ", " ", Words),

%   atomize(Words, [A1, A2, A3 | Atoms]),
%   G1 =.. [ Tag, A1, A2, A3, Atoms ],

   f_atomize(Tag, Words, G1),
   
   atomize_lines([G1|Build], Tag, Lines, Out).

f_atomize(Tag, [A1, A2, A3 | Atoms], G1) :- 
   atomize([ A1, A2, A3, Atoms ], Thonk),
   
   G1 =.. [Tag|Thonk].
   

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
