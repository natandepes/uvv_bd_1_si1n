# Subdiretório PSet 1

## Problem Set 1
- Um ***problem set*** é uma atividade consiste em um conjunto de problemas e tarefas difíceis que o forçarão a estudar e realmente aprender a matéria. Resumidamente falando, o objetivo desse primeiro PSet é montar um banco de dados chamado UVV, baseado no modelo do Elmasri em seu livro Sistema de Banco de Dados, usando um SGBD que já estamos habituados, o MySQL, e um novo o PostgreSQL, e teremos que escrever um script SQL para cada um dos SGBDs, aloca-los no GitHub, e garantir que o script rode quando o professor for testar na máquina dele.

##  Resolvendo o Pset

- Foi proposto para que realizássemos o ***Pset1*** em uma Máquina Virutal disponibilizada e pré-configurada pelo professor Abrantes, que é um sistema Linux Oracle 64-bit, de início a Máquina Virtual não rodava no meu computador por nada, deu inúmeros erros, porém após assistir vários vídeos de estrangeiros com um inglês praticamente imcompreensível e ler vários forúns aleatórios de programação pela internet, eu finalmente fiz funcionar. Mas para meu azar ela estava funcionando muito mal no meu computador, era impossível realizar operações nela, lenta demais, acabou então que tive que instalar o PosgreSQL e o MySQL na minha máquina diretamente. 

- Eu decidi começar fazendo o script do MySQL, pois já tinha mais experiência com o funcionamente desse SGBD e eu tinha um pressentimento que seria mais fácil, eu estava certo, comecei usando SQL Power Architect para me dar uma ajuda na criação das tabelas e das chaves, tive um problema ou outro devido as imperfeições do projeto do Elmasri e das imperfeições do script gerado pelo Power Architect, e precisei pesquisar como se criavam chaves alternadas, mas no geral foi até bem rápido. 

- A implementação do modelo no PostgreSQL deu mais trabalho, me fez ter que pesquisar como funcionava praticamente todos os comandos que eu previamente usei no MySQl, até os mais simples como cirar um banco de dados e usá-los, e o Postgres possui uma característica que o MySQL não possui, os ***esquemas***, que é um local onde ficam armazenadas as tabelas, visões, tipos de dados, etc. Característica que tinha de ter o nome mencionado em praticamente todo comando e me fez  entender seu funcionamento. No final era mais simples do que eu pensava e eu só devo ter demorado pouco mais de 1/3 de tempo para escrever o script em relação ao MySQL. 

- Então veio meu maior problema, eu deixei os dois scripts 98% prontos, eu tinha criado tudo, desde o meu usuário até as constraints, só faltavam duas coisas, comentar, e conectar no banco de dados usando meu usuário. Comentar foi fácil, só foi um pouquinho demorado porque não é a coisa mais divertida a se fazer, na próxima vez já vou comentar logo quando for digitando o código, agora o problema foi a conexão com o meu usuário, eu pesquisei muitos comandos, passei horas no *stack overflow* e nada, tive que pedir ajuda pessoalmente ao professor.

- O professor me orientou e então consegui achar e utilizar os comandos de conexão, o problema foi que, ao conectar com meu usuário, ele pede obrigatoriamente senha, mesmo que eu esteja conectado como *root* e mesmo que eu crie um usuário sem senha (eu explico mais essa parte no início de cada script), e não é possível digitar a senha durante o script inteiro rodando, logo tive que quebrar ambos scripts em ***PARTE 1*** e ***PARTE 2***, para que então funcionassem. Por fim, não foi um trabalho fácil mas valeu muito a pena aprendendizagem, gosto de coisas assim, me divirto apesar dos impasses.



