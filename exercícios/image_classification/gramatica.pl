/*
Bruno Aurelio Rozza de Moura Campos (14104255)
William Muller (14101401)

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

programa --> [].
programa --> comando, programa.
programa(N) --> { atom_number(N, X), between(1,X,_) },  comando, programa,  { false }.

comando --> [pf], [N],  { atom_number(N, X), parafrente(X) }.
comando --> [pt], [N],  { atom_number(N, X), paratras(X) }.
comando --> [gd], [G],  { atom_number(G, X), giradireita(X) }.
comando --> [ge], [G],  { atom_number(G, X), giraesquerda(X) }.
comando --> [repita], [N], bloco_inicio, programa(N), bloco_fim.
comando --> [un],  { usenada }.
comando --> [ul],  { uselapis }.
comando --> [tartaruga],  { tartaruga }.


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

substitute(Find, Replace, Request, Result) :- phrase(replace(Find, Replace), Request, Result).    

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
