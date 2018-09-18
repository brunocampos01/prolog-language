/*
   Programacao Logica - Prof. Alexandre G. Silva - 30set2015

   Conversao de banco de dados "desenhos.pl" para uma saida padrao na 
   tela, a ser direcionada, por exemplo, para um arquivo "desenhos.svg" 
   e visualizada em um navegador.
   
   swipl -f db2svg.pl -t halt > desenhos.svg 2> stderr.txt
*/

:- initialization(convert).

svgheader :-
   writeln('<?xml version="1.0" encoding="UTF-8" standalone="no"?>\n<svg xmlns="http://www.w3.org/2000/svg"
     width="1000.0"
     height="1000.0"
     viewBox="0 0 1000.0 1000.0" >').

svgpath([], _).
svgpath(_, []).
svgpath([X|Lx], [Y|Ly]) :-
    write(X), write(','), write(Y), write(' '),
    svgpath(Lx, Ly).

svgbody([]).
svgbody([Id|T]) :-
    findall(X, xy(Id,X,_), Lx),
    findall(Y, xy(Id,_,Y), Ly),
    write('<path style="fill:none;stroke:#000000;stroke-width:1px" id="'), write(Id), write('" d="m '),
    svgpath(Lx, Ly),
    write('z" />'), nl,
    svgbody(T).

svgfooter :- writeln('</svg>').

convert :-
    retractall(xy(_,_,_)),
    consult('desenhos.pl'),
    findall(Id, xy(Id,_,_), L),
    list_to_set(L, Lid),
    svgheader,
    svgbody(Lid),
    svgfooter.
