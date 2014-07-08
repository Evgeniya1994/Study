path(X, Z, Path) :-
    length(Path, _),
    path_r(X, Z, Path).
 
path_r(Z, Z, []).
path_r(X, Z, [X|Path]) :-
    arc(X, Y),
    path(Y, Z, Path).