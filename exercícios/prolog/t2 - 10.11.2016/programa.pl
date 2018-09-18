/*
	Bruno Aurelio Rozza de Moura Campos 14104255

   Programacao Logica - Prof. Alexandre G. Silva - UFSC
     Versao inicio      : 15out2015
     Adicao de repeticao: 12out2016
   
   Gramatica para implementacao de um subconjunto de comandos da Linguagem LOGO
   
   Area de teste:
     - https://turtleacademy.com/playground/pt

   Documentacao:
     - pf numero (ex: pf 50)
         'para frente' - avanca o numero de passos indicados pelo numero.
     - pt numero (ex: pt 100)
         'para tras' - recua o numero de passos indicados pelo numero.
     - gd numero (ex: gd 90)
         'gira `a direita' - gira a direita tantos graus quanto indicados.
     - ge numero (ex: ge 45)
         'gira `a esquerda' - gira a esquerda tantos graus quanto indicados.
     - repita numero <comando> (ex: repita 8[pf 50 gd 45])
         Repete comando/programa tantas vezes quanto indicadas pelo numero.
     - un
         'use nada' - levanta o lapis, nao deixando mais traço ao se deslocar.
     - ul
         'use lapis' - usa o lapis, desenhando/escrevendo ao se deslocar.
     - tartaruga
         Limpa os desenhos e reinicia no centro da tela (origem).

   Observacao:
     - Nao tente executar um comando sem antes carregar 'programa.pl'
*/


%---------------------------------------------------


programa --> [].
programa --> comando, programa.
programa(N) --> { atom_number(N, X), between(1,X,_) },  comando, programa,  { false }.


comando --> [pf], [N],  { atom_number(N, X), parafrente(X) }.
parafrente(N) :-
    ang(G),
    X is cos((G*pi)/180)*N,
    Y is sin((G*pi)/180)*N,
    deslocar(X, Y).


comando --> [pt], [N],  { atom_number(N, X), paratras(X) }.
paratras(N) :-
    ang(G),
    X is cos((G*pi)/180)*N,
    Y is sin((G*pi)/180)*N*(-1),
    deslocar(X, Y).


comando --> [gd], [G],  { atom_number(G, X), giradireita(X) }.

giradireita(G) :-
    ang(H),
    Angle is H + G,
    new_angle(Angle).


comando --> [ge], [G],  { atom_number(G, X), giraesquerda(X) }.

giraesquerda(G) :-
    ang(H),
    Angle is H - G,
    new_angle(Angle).


comando --> [repita], [N], bloco_inicio, programa(N), bloco_fim.

repita(N, Command) :-
    between(1, N, _),
    comando(Command),
    false.


comando --> [un],  { usenada }.

    nb_setval(lapis, 0).


comando --> [ul],  { uselapis }.

uselapis :-
    nb_setval(lapis, 1),
    nb_getval(indexId, LastID),
    NumID is LastID + 1,
    nb_setval(indexId, NumID),
    retractall(idlast(_)),
    asserta(idlast(NumID)),
    atom_concat(id, NumID, Id),
    nb_setval(atualId, Id),
    (NumID >= 2 -> xylast(X, Y), new(Id, X, Y);
     true).


comando --> [tartaruga],  { tartaruga }.

tartaruga :-
    retractall(xy(_, _, _)),
    nb_setval(indexId, -1),
    uselapis,
    nb_getval(atualId, Id),
    new(Id, 250, 250),
    retractall(xylast(_, _)),
    asserta(xylast(250, 250)).

%---------------------------------------------------


bloco_inicio --> ['['].
bloco_fim --> [']'].


%---------------------------------------------------


eos([], []).

replace(_, _) --> call(eos), !.
replace(Find, Replace), Replace -->
        Find,
        !,
        replace(Find, Replace).
replace(Find, Replace), [C] -->
        [C],
        replace(Find, Replace).

substitute(Find, Replace, Request, Result):-
        phrase(replace(Find, Replace), Request, Result).    

remove([],_,[]) :- !. 
remove([X|T],X,L1) :- !, remove(T,X,L1).         
remove([H|T],X,[H|L1]) :- remove(T,X,L1).


%---------------------------------------------------


cmd(Comando) :-
    substitute("[", " [ ", Comando, R1),
    atom_codes(_, R1),
    substitute("]", " ] ", R1, R2),
    atom_codes(A2, R2),
    atomic_list_concat(L1, ' ', A2),
    remove(L1, '', Cmd),
    programa(Cmd, []).


%---------------------------------------------------
% Referencias:
% http://www.pathwayslms.com/swipltuts/dcg/
% https://en.wikibooks.org/wiki/Prolog/Definite_Clause_Grammars
% http://stackoverflow.com/questions/6392725/using-a-prolog-dcg-to-find-replace-code-review
