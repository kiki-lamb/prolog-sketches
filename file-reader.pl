:- use_module(library(pio)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preds.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load_atomized_lines_from_file(Tag, File) :-
   load_atomized_lines_from_file(Tag, File, _).

load_atomized_lines_from_file(Tag, File, Out) :-
   P =.. [ r, _, _, _, _ ],
   retractall(P),
   phrase_from_file(lines(Lines), File),
   maplist(tagged_predify(Tag), Lines, TmpOut2),
   maplist(assert, TmpOut2, Out).

%-----------------------------------------------------------

tagged_predify(Tag, Line, G1) :-
   split_string(Line, " ", " ", [A1, A2, A3 | Words]),
   maplist(r_atom_codes, [ A1, A2, A3, Words ], Atoms),
   G1 =.. [Tag|Atoms].

%-----------------------------------------------------------
   
r_atom_codes(In, Out) :-
   atom_codes(Out, In).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grammar.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lines([])     --> end_of_sequence, !.
lines([L|Ls]) --> line(L),
                  lines(Ls).

line([])      --> ".\n", !.
line([])      --> end_of_sequence, !.
line([L|Ls])  --> [L], line(Ls).

%-----------------------------------------------------------

end_of_sequence([], []).
