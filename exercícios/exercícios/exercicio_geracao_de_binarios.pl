% dı́gitos binários(FATOS)  
    dı́gito(0).
    dı́gito(1).

% restriçoes para a soluçao(INFERENCIAS)
binário(N) :-
    N = (A,B,C),
    dı́gito(A),
    dı́gito(B),
    dı́gito(C).
