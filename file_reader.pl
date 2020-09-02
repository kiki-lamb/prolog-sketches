:- use_module(library(pio)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preds
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load_atomized_lines_from_file(Tag, File) :-
   load_atomized_lines_from_file(Tag, File, _).

load_atomized_lines_from_file(Tag, File, Out) :- 
   retractall(r(_,_,_,_)),
   phrase_from_file(lines(In), File),
   maplist(tagged_predify(Tag), In, TmpOut2),
   maplist(assert, TmpOut2, Out).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tagged_predify(Tag, Line, G1) :-
   split_string(Line, " ", " ", [A1, A2, A3 | Words]),
   maplist(r_atom_codes, [ A1, A2, A3, Words ], Atoms),
   G1 =.. [Tag|Atoms].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%          
   
r_atom_codes(In, Out) :-
   atom_codes(Out, In).

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
