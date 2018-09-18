# Paradigma lógico (declarativo)

A programação lógica se basea em 3 princípios:
 * linguagem formal para representação de conhecimento
 * regras de inferência para manipulação de conhecimento
 * estratégia de busca para controle de inferências

# A linguagem PROLOG

<img src="sistema_prolog.png" />
 * **Interface**: permite que o usuário entre com premissas codificadas em
uma linguagem lógica e faça consultas para extrair conclusões destas
premissas
 * **Motor de inferência**: atualiza a base de conhecimento com
premissas fornecidas pelo usuário e faz inferências para extrair
informações implı́citas
 * **Base de conhecimento**: armazena fatos e regras, fornecidas pelo usuário. 
 Ex)

**FATOS**

`progenitor(boris, jane).
progenitor(boris, marcia).
progenitor(adelia, jane).
progenitor(jane, tiago).`
 

**REGRAS**

`avo(X,Z) :- progenitor(X,Y), progenitor(Y,Z).`
