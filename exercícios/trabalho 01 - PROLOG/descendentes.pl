filha(marta,charlotte).
filha(charlotte,caroline).
filha(caroline,laura).
filha(laura,rose).

descendente(X,Y) :- filha(X,Y).
descendente(X,Y) :- filha(X,Z),descendente(Z,Y).

 
