# Paradigma lógico (declarativo)

A programação lógica se basea em 3 princípios:
 * linguagem formal para representação de conhecimento
 * regras de inferência para manipulação de conhecimento
 * estratégia de busca para controle de inferências

# A linguagem PROLOG

<img src="sistema_prolog.png" />
 <p> - Interface: permite que o usuário entre com premissas codificadas em
uma linguagem lógica e faça consultas para extrair conclusões destas
premissas</p>
<p> - Motor de inferência: atualiza a base de conhecimento com
premissas fornecidas pelo usuário e faz inferências para extrair
informações implı́citas.</p>
<p> - Base de conhecimento: armazena fatos e regras, fornecidas pelo usuário.</p>
 Ex)

**FATOS**

`progenitor(boris, jane).`<br/>
`progenitor(boris, marcia).`<br/>
`progenitor(adelia, jane).`<br/>
`progenitor(jane, tiago).`<br/>
 

**REGRAS**

`avo(X,Z) :- progenitor(X,Y), progenitor(Y,Z).`<br/>

<img src="exemplo_sintaxe.png" />
