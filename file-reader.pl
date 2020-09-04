:- initialization(main).
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

line([])     --> end_of_sequence, !.
line([])     --> "\n", !.
line([L|Ls]) --> word(L),
                 line(Ls).



word([])      --> end_of_sequence, !.
word([])      --> " ", !.
word([])      --> ".", !.
word([L|Ls])  --> [L],
                  word(Ls).

%-----------------------------------------------------------

end_of_sequence([], []).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

convert_words(LLs, Out) :-
   maplist(r_atom_codes, LLs, Out).

main :-
   phrase_from_file(lines(Ls), "tiny.ssv"),
   findall(Y, (member(X, Ls), convert_words(X, Y)), Out),
   nl,
   format("~w\n", [Out]),
   nl.
