% colore um mapa usando no máximo quatro cores
% cores disponı́veis (FATOS):
cor(azul) .
cor(verde) .
cor(amarelo) .
cor(vermelho) .

% restriçoes para a soluçao(INFERENCIAS):
coloraçao(A,B,C,D,E) :- cor(A), cor(B), cor(C), cor(D), cor(E),
A\=B, A\=C, A\=D, B\=C, B\=E, C\=D, C\=E, D\=E.

%TESTES
? - coloraçao(A,B,C,D,E).
