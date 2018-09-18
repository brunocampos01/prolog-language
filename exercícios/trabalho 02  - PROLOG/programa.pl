/*
%% INE5416 - Paradigmas de Programação
%% Bruno Aurélio Rôzza de Moura Campos (14104255)
%% William Muller (14101401)
   
   RECOMENDACOES:
   - O nome deste arquivo deve ser 'programa.pl'   
   - O nome do banco de dados deve ser 'desenhos.pl'  
   - Dicas de uso podem ser obtidas na execucação: 
     ?- menu.
    
   - Exemplo de uso:
     ?- load.
     ?- searchAll(id1).
*/
%%T2A

% Apaga os predicados 'xy' da memoria e carrega os desenhos a partir de um arquivo de banco de dados
load :-
    retractall(xy(_,_,_)),
    open('desenhos.pl', read, Stream),
    repeat,
        read(Stream, Data),
        (Data == end_of_file -> true ; assert(Data), fail),
        !,
        close(Stream).

% Ponto de deslocamento, se <Id> existente
new(Id,X,Y) :-
    xy(Id,_,_),
    assertz(xy(Id,X,Y)),
    !.

% Ponto inicial, caso contrario
new(Id,X,Y) :-
    asserta(xy(Id,X,Y)),
    !.

% Exibe opcoes de busca
search :-
    write('searchAll(Id).     -> Ponto inicial e todos os deslocamentos de <Id>'), nl,
    write('searchFirst(Id,N). -> Ponto inicial e os <N-1> primeiros deslocamentos de <Id>'), nl,
    write('searchLast(Id,N).  -> Lista os <N> ultimos deslocamentos de <Id>').

searchAll(Id) :-
    listing(xy(Id,_,_)).

% Exibe opcoes de alteracao
change :-
    write('change(Id,X,Y,Xnew,Ynew).  -> Altera um ponto de <Id>'), nl,
    write('changeFirst(Id,Xnew,Ynew). -> Altera o ponto inicial de <Id>'), nl,
    write('changeLast(Id,Xnew,Ynew).  -> Altera o deslocamento final de <Id>').

% Grava os desenhos da memoria em arquivo
commit :-
    open('desenhos.pl', write, Stream),
    telling(Screen),
    tell(Stream),
    listing(xy),
    tell(Screen),
    close(Stream).

% Exibe menu principal
menu :-
    write('load.        -> Carrega todos os desenhos do banco de dados para a memoria'), nl,
    write('new(Id,X,Y). -> Insere um deslocamento no desenho com identificador <Id>'), nl,
    write('                (se primeira insercao, trata-se de um ponto inicial)'), nl,
    write('search.      -> Consulta pontos dos desenhos'), nl,
    write('change.      -> Modifica um deslocamento existente do desenho'), nl,
    write('remove.      -> Remove um determinado deslocamento existente do desenho'), nl,
    write('undo.        -> Remove o deslocamento inserido mais recentemente'), nl,
    write('commit.      -> Grava alteracoes de todos dos desenhos no banco de dados').


%– searchFirst(Id,N). → Lista ponto inicial e N − 1 deslocamentos iniciais de Id
searchFirst(Id, N) :-
    findall(V, (xy(Id, X, Y), append([Id], [X], L), append(L, [Y], V)), All),
    between(1, N, Mid),
    nth1(Mid, All, Vertex),
    write(Vertex),
    write(' '),
    false.

%%questao 2
%– searchLast(Id,N). → Lista os N ultimos deslocamentos de ´ Id
searchLast(Id, N) :-
    findall(V, (xy(Id, X, Y), append([Id], [X], L), append(L, [Y], V)), All),
    length(All, S),
    Init is S - N,
    between(Init, S, Mid),
    nth0(Mid, All, Vertex),
    write(Vertex),
    write(' '),
    false.

%– undo. → Remove o deslocamento inserido mais recentemente
undo :-
    list(X, Y, Z),
    retract(xy(X, Y, Z)),
    retract(list(X, Y, Z)),
    !.

%– change(Id,X,Y,Xnew,Ynew). → Altera um ponto de Id
change(Id, X, Y, Xnew, Ynew) :-
    (findall(V, (xy(I, A, B), append([I], [A], L), append(L, [B], V)), All),
     length(All, T),
     retractall(xy(_, _, _)),
     retractall(list(_, _, _)),
     between(0, T, K),
     nth0(K, All, P),
     nth0(0, P, IdP),
     nth0(1, P, XP),
     nth0(2, P, YP),
     (IdP = Id, XP = X, YP = Y -> new(IdP, Xnew, Ynew);
      new(IdP, XP, YP)),
     false);
    true.

%– changeFirst(Id,Xnew,Ynew). → Altera o ponto inicial de Id
changeFirst(Id, Xnew, Ynew) :-
    remove(Id, _, _),
    !,
    asserta(xy(Id, Xnew, Ynew)),
    assertz(list(Id, Xnew, Ynew)).

%– changeLast(Id,Xnew,Ynew). → Altera o deslocamento final de Id
changeLast(Id, Xnew, Ynew) :-
    findall(V, (xy(Id, X, Y), append([Id], [X], L), append(L, [Y], V)), All),
    last(All, Last),
    nth0(0, Last, IdL),
    nth0(1, Last, XL),
    nth0(2, Last, YL),
    remove(IdL, XL, YL),
    assertz(xy(Id, Xnew, Ynew)),
    asserta(list(Id, Xnew, Ynew)),
    !.

%%questao 3
quadrado(Id, X, Y, Lado) :-
    new(Id, X, Y),
    new(Id, Lado, 0),
    new(Id, 0, Lado),
    NLado is (-1) * Lado,
    new(Id, NLado, 0).

%%questao 4
figura(Id, X, Y) :-
    Right is X*2,
    BigLeft is (-2)*X,
    Left is (-1)*X,
    Up is (-1)*Y,
    new(Id, X, Y),
    new(Id, Right, 0),
    new(Id, 0, Y),
    new(Id, X, 0),
    new(Id, 0, Y),
    new(Id, BigLeft, 0),
    new(Id, 0, Up),
    new(Id, Left, 0),
    new(Id, 0, Up).

%%questao 5
replica(Id, N, Dx, Dy) :-
    between(1, N, T),
    (findall(V, (xy(Id, X, Y), append([Id], [X], L), append(L, [Y], V)), All),
     length(All, S),
     between(0, S, K),
     nth0(K, All, M),
     nth0(0, M, IdM),
     nth0(1, M, XM),
     nth0(2, M, YM),
     atom_concat(IdM, '_r', Temp),
     atom_concat(Temp, T, NewId),
     NewX is XM + (Dx*T),
     NewY is YM + (Dy*T),
     ((K =:= 0) -> new(NewId, NewX, NewY);
       new(NewId, XM, YM))),
    false.


%%T2B
/*
   Programacao Logica - Prof. Alexandre G. Silva - UFSC
     Versao inicial     : 30set2015
     Adicao de gramatica: 15out2015
     Ultima atualizacao : 12out2016
   
   RECOMENDACOES:
   
   - O nome deste arquivo deve ser 'programa.pl'
   - O nome do banco de dados deve ser 'desenhos.pl'
   - O nome do arquivo de gramatica deve ser 'gramatica.pl'
   
   - Dicas de uso podem ser obtidas na execucação: 
     ?- menu.
     
   - Exemplo de uso:
     ?- load.
     ?- searchAll(id1).

   - Exemplos de uso da gramatica:
     ?- comando([pf, '10'], []).
     Ou simplesmente:
     ?- cmd("pf 10").
   
     ?- comando([repita, '5', '[', pf, '50', gd, '45', ']'], []).
     Ou simplesmente:
     ?- cmd("repita 5[pf 50 gd 45]").
     
   - Colocar o nome e matricula de cada integrante do grupo
     nestes comentarios iniciais do programa
*/

:- set_prolog_flag(double_quotes, codes).
:- initialization(new0).

% Coloca tartaruga no centro da tela (de 1000x1000)
new0 :-
    consult('gramatica.pl'),
    load,
    xylast(X, Y),
    new(id1, X, Y).

new_angle(Ang) :-
    retractall(ang(_)),
    asserta(ang(Ang)).

deslocar(X, Y) :-
    nb_getval(lapis, L),
    nb_getval(atualId, Id),
    xylast(OldX, OldY),
    (L =:= 1 -> new(Id, X, Y)),
    retractall(xylast(_, _)),
    NewX is OldX + X,
    NewY is OldY + Y,
    asserta(xylast(NewX, NewY)).


%%– Acrescente uma nova funcionalidade à gramática e implemente seu respectivo predicado.
%%– parafrente
parafrente(N) :-
    ang(G),
    X is cos((G*pi)/180)*N,
    Y is sin((G*pi)/180)*N,
    deslocar(X, Y).

%%– paratras
paratras(N) :-
    ang(G),
    X is cos((G*pi)/180)*N,
    Y is sin((G*pi)/180)*N*(-1),
    deslocar(X, Y).

%%– giradireita
giradireita(G) :-
    ang(H),
    Angle is H + G,
    new_angle(Angle).

%%– giraesquerda
giraesquerda(G) :-
    ang(H),
    Angle is H - G,
    new_angle(Angle).

%%– repita
repita(N, Command) :-
    between(1, N, _),
    comando(Command),
    false.

%%– usenada
usenada :-
    nb_setval(lapis, 0).

%%– uselapis
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

%%– tartaruga
tartaruga :-
    retractall(xy(_, _, _)),
    nb_setval(indexId, -1),
    uselapis,
    nb_getval(atualId, Id),
    new(Id, 500, 500),
    retractall(xylast(_, _)),
    asserta(xylast(500, 500)).


