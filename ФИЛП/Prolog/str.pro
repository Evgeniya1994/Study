app([], X, X).
app([H|T], X, [H|Y]) :- app(T, X, Y).
fill(0, _, []).
fill(N, X, [X|L]) :- M is N-1, fill(M, X, L).
range(M, M, [M]).
range(M, N, [M|L]) :- M1 is M+1, range(M1, N, L).
sievel(_, [], []).
sievel(X, [H|T], R) :- M is H mod X, M =:= 0 -> sievel(X, T, R).
sievel(X, [H|T], [H|R]) :- sievel(X, T, R), !.
