DROP USER natan; -- Deletando o user natan caso ja exista.
DROP DATABASE uvv; -- Deletando o banco de dados uvv caso ja exista.

CREATE USER natan IDENTIFIED BY 'maclmera';  -- Criando o usuario natan e colocando a senha de maclmera.

GRANT CREATE, ALTER, DROP, REFERENCES, DELETE, UPDATE, INDEX, INSERT, SELECT ON uvv.* TO natan; -- Garantindo para o meu usuario os privilegios de criar, deletar, referenciar, atualizar, inserir e projetar no em todo o banco de dados uvv.

-- Conectando ao MySQL como o user natan.
system mysql -u natan -pmaclmera

-- Criando o banco de dados uvv, onde eu implementarei o esquema do elmasri.

CREATE DATABASE uvv;

-- Escolhendo o banco de dados uvv para implementar os dados.

USE uvv;

-- Criando a tabela funcionario.

CREATE TABLE funcionario (
                cpf CHAR(11) NOT NULL,
                primeiro_nome VARCHAR(15) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(15) NOT NULL,
                data_nascimento DATE,
                endereco VARCHAR(50),
                sexo CHAR(1),
                salario DECIMAL(10,2),
                cpf_supervisor CHAR(11),
                numero_departamento INT NOT NULL,
                PRIMARY KEY (cpf)
);

-- Adicionando comentarios para cada campo e para a tabela funcionario.

ALTER TABLE funcionario COMMENT 'Tabela que armazena as informações dos funcionários.';

ALTER TABLE funcionario MODIFY COLUMN cpf CHAR(11) NOT NULL COMMENT 'CPF do funcionário. Será a PK da tabela.';

ALTER TABLE funcionario MODIFY COLUMN primeiro_nome VARCHAR(15) NOT NULL COMMENT 'Primeiro nome do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN nome_meio CHAR(1) COMMENT 'Inicial do nome do meio.';

ALTER TABLE funcionario MODIFY COLUMN ultimo_nome VARCHAR(15) NOT NULL COMMENT 'Sobrenome do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN data_nascimento DATE COMMENT 'Data de nascimento do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN endereco VARCHAR(50) COMMENT 'Endereço do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN sexo CHAR(1) COMMENT 'Sexo do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN salario DECIMAL(10, 2) COMMENT 'Salário do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN cpf_supervisor CHAR(11) COMMENT 'CPF do supervisor, será uma FK da própia tabela.';

ALTER TABLE funcionario MODIFY COLUMN numero_departamento INTEGER NOT NULL COMMENT 'Número do departamento do funcionário.';


-- Adicionando restricoes na tabela funcionario. (Constraints)

ALTER TABLE funcionario ADD CONSTRAINT CHECK (sexo="M" OR sexo="F"); -- constraint permitindo apenas que os sexos sejam indicados por M ou F

ALTER TABLE funcionario ADD CONSTRAINT CHECK (salario > -1); -- constraint impedindo de um funcionario ganhar salario negativo

ALTER TABLE funcionario ADD CONSTRAINT CHECK (numero_departamento > 0); -- constraint impedindo que seja adicionado um numero de departamento <=0

ALTER TABLE funcionario ADD CONSTRAINT CHECK (data_nascimento BETWEEN "1936-01-01" AND "2004-01-01");  -- constraint que limita a idade do funcionario de 89 anos ate 18, eu pretendia colocar 80 no maximo mas tem um funcionario com 85 anos


-- Criando a tabela departamento.

CREATE TABLE departamento (
                numero_departamento INT NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                cpf_gerente CHAR(11) NOT NULL,
                data_inicio_gerente DATE,
                PRIMARY KEY (numero_departamento)
);

-- Adicionando comentarios em cada campo e para a tabela departamento.

ALTER TABLE departamento COMMENT 'Tabela que armazena as informaçoẽs dos departamentos.';

ALTER TABLE departamento MODIFY COLUMN numero_departamento INTEGER NOT NULL COMMENT 'Número do departamento. É a PK desta tabela.';

ALTER TABLE departamento MODIFY COLUMN nome_departamento VARCHAR(15) NOT NULL COMMENT 'Nome do departamento. Deve ser único.';

ALTER TABLE departamento MODIFY COLUMN cpf_gerente CHAR(11) NOT NULL COMMENT 'CPF do gerente do departamento. Será uma FK.';

ALTER TABLE departamento MODIFY COLUMN data_inicio_gerente DATE COMMENT 'Data do início do gerente no departamento.';


-- Adicionando restricoes na tabela departamento. (Constraints)

ALTER TABLE departamento ADD CONSTRAINT CHECK (numero_departamento > 0);  -- constraint impedindo que seja adicionado um numero de departamento <=0

ALTER TABLE departamento ADD CONSTRAINT CHECK (data_inicio_gerente BETWEEN "1981-06-18" AND "2023-01-01"); -- constraint permitindo que so seja adicionada a data de inicio de um gerente desde o ultimo gerente, ate ano que vem

CREATE UNIQUE INDEX idx_nome_departamento -- criando a Alternate Key para a tabela departamento, indicando que o nome de cada departamento deve ser unico.
 ON departamento
 ( nome_departamento );


-- Criando a tabela localizacoes_departamento.

CREATE TABLE localizacoes_departamento (
                numero_departamento INT NOT NULL,
                local VARCHAR(15) NOT NULL,
                PRIMARY KEY (numero_departamento, local)
);

-- Adicionando comentario em cada campo e na tabela localizacoes_departamento.

ALTER TABLE localizacoes_departamento COMMENT 'Tabela que armazena as possíveis localizações dos departamentos.';

ALTER TABLE localizacoes_departamento MODIFY COLUMN numero_departamento INTEGER NOT NULL COMMENT 'Número do departamento. É PK e FK.';

ALTER TABLE localizacoes_departamento MODIFY COLUMN local VARCHAR(15) NOT NULL COMMENT 'Localização do departamento. Faz parte da PK desta tabela.';


-- Criando a tabela projeto.

CREATE TABLE projeto (
                numero_projeto INT NOT NULL,
                nome_projeto VARCHAR(15) NOT NULL,
                local_projeto VARCHAR(15),
                numero_departamento INT NOT NULL,
                PRIMARY KEY (numero_projeto)
);

-- Adicionando comentarios em cada campo e na tabela projeto.

ALTER TABLE projeto COMMENT 'Tabela que armazena as informações sobre os projetos dos departamentos.';

ALTER TABLE projeto MODIFY COLUMN numero_projeto INTEGER NOT NULL COMMENT 'Número do projeto. É a PK desta tabela.';

ALTER TABLE projeto MODIFY COLUMN nome_projeto VARCHAR(15) NOT NULL COMMENT 'Nome do projeto. Deve ser único.';

ALTER TABLE projeto MODIFY COLUMN local_projeto VARCHAR(15) COMMENT 'Localização do projeto.';

ALTER TABLE projeto MODIFY COLUMN numero_departamento INTEGER NOT NULL COMMENT 'Número do departamento. É uma FK para a tabela departamento.';

-- Adicionando restricoes na tabela projeto. (Constraints)

ALTER TABLE projeto ADD CONSTRAINT CHECK (numero_projeto > 0); -- constraint impedindo que seja adicionado um numero de projeto <=0

CREATE UNIQUE INDEX idx_nome_projeto -- criando a Alternate Key para a tabela projeto, indicando que o nome de cada projeto deve ser unico
 ON projeto
 ( nome_projeto );


-- Criando a tabela trabalha_em.

CREATE TABLE trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL,
                numero_projeto INT NOT NULL,
                horas DECIMAL(3,1),
                PRIMARY KEY (cpf_funcionario, numero_projeto)
);

-- Adicionando comentarios em cada campo e na tabela trabalha_em.

ALTER TABLE trabalha_em COMMENT 'Tabela para armazenar quais funcionários trabalham em quais projetos.';

ALTER TABLE trabalha_em MODIFY COLUMN cpf_funcionario CHAR(11) NOT NULL COMMENT 'CPF do funcionário. É PK e FK.';

ALTER TABLE trabalha_em MODIFY COLUMN numero_projeto INTEGER NOT NULL COMMENT 'Número do projeto. É PK e FK.';

ALTER TABLE trabalha_em MODIFY COLUMN horas DECIMAL(3, 1) COMMENT 'Horas trabalhadas pelo funcionário neste projeto.';

-- Adicionando restricoes. (Constraints)

ALTER TABLE trabalha_em ADD CONSTRAINT CHECK (horas > -1); -- Constraint impedindo que sejam adicionadas horas negativas.


-- Criando tabela dependente.

CREATE TABLE dependente (
                cpf_funcionario CHAR(11) NOT NULL,
                nome_dependente VARCHAR(15) NOT NULL,
                sexo CHAR(1),
                data_nascimento DATE,
                parentesco VARCHAR(15),
                PRIMARY KEY (nome_dependente, cpf_funcionario)
);

-- Adicionando comentarios em cada campo e na tabela dependente.

ALTER TABLE dependente COMMENT 'Tabela que armazena as informações dos dependentes dos funcionários.';

ALTER TABLE dependente MODIFY COLUMN cpf_funcionario CHAR(11) NOT NULL COMMENT 'CPF do funcionário. Será a PK da tabela.';

ALTER TABLE dependente MODIFY COLUMN nome_dependente VARCHAR(15) NOT NULL COMMENT 'Nome do dependente. Faz parte da PK desta tabela.';

ALTER TABLE dependente MODIFY COLUMN sexo CHAR(1) COMMENT 'Sexo do dependente.';

ALTER TABLE dependente MODIFY COLUMN data_nascimento DATE COMMENT 'Data de nascimento do dependente.';

ALTER TABLE dependente MODIFY COLUMN parentesco VARCHAR(15) COMMENT 'Descrição do parentesco do dependente com o funcionário.';

-- Adicionando restricoes. (Constraints)

ALTER TABLE dependente ADD CONSTRAINT CHECK (sexo="M" OR sexo="F");  -- Constraint permitindo apenas que os sexos sejam indicados por M ou F.

ALTER TABLE dependente ADD CONSTRAINT CHECK (data_nascimento BETWEEN "1923-01-01" AND "2004-01-01"); -- Constraint permitindo que os dependentes tenham nascido desde 1928 ate 2004, coloquei 1928 pois os pais de alguem podem ser dependentes, e 2004 pois nao faz sentido indicar dados de um menor de idade.


-- Inserindo as Foreign Keys em todas as tabelas.

ALTER TABLE funcionario ADD CONSTRAINT funcionario_funcionario_fk -- Adicionando a FK cpf_supervisor que referencia a PK cpf na mesma tabela (funcionario).
FOREIGN KEY (cpf_supervisor)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE dependente ADD CONSTRAINT funcionario_dependente_fk -- Adicionando a FK cpf_funcionario que referencia a PK cpf na tabela funcionario.
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk -- Adicionando a FK cpf_funcionario na tabela trabalha_em que referencia a PK cpf na tabela funcionario.
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE departamento ADD CONSTRAINT funcionario_departamento_fk -- Adicionando a FK cpf_gerente na tabela departamento que refrencia a PK cpf na tabela funcionario.
FOREIGN KEY (cpf_gerente)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE projeto ADD CONSTRAINT departamento_projeto_fk -- Adicionando a FK numero_departamento na tabela projetoo que referencia a PK numero_departamento na tabela departamento.
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk -- Adicionando a FK numero_departamento na tabela localizacoes_departamento que refencia a PK numero_departamento na tabela departamento.
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk -- Adicionando a FK numero_projeto na tabela trabalha_em que referecia o campo numero_projeto na tabela projeto.
FOREIGN KEY (numero_projeto)
REFERENCES projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION;


-- Inserindo o cpf, nome, nome do meio, ultimo nome, data de nasciemnto, endereco, sexo, salario, cpf do supervisor, e departamento, dos funcionarios.

INSERT INTO funcionario VALUES(
"88866555576", "Jorge", "E", "Brito", "1937-11-10", "Rua do Horto. 35. Sao Paulo. SP", "M", 55000, null, 1
);

INSERT INTO funcionario VALUES(
"98765432168", "Jennifer", "S", "Souza", "1941-06-20", "Av Arthur de Lima. 54. Santo Andre. SP", "F", 43000, "88866555576", 4
);

INSERT INTO funcionario VALUES(
"33344555587", "Fernando", "T", "Wong", "1955-12-08", "Rua da Lapa. 34. Sao Paulo. SP", "M", 40000, "88866555576", 5
);

INSERT INTO funcionario VALUES(
"99988777767", "Alice", "J", "Zelaya", "1968-01-19", "Rua Souza Lima. 35. Curitiba. PR", "F", 25000, "98765432168", 4
);

INSERT INTO funcionario VALUES(
"98798798733", "Andre", "V", "Pereira", "1969-03-29", "Rua Timbira 35. Sao Paulo. SP", "M", 25000, "98765432168", 4
);

INSERT INTO funcionario VALUES(
"12345678966", "Joao", "B", "Silva", "1965-01-09", "Rua das Flores. 751. Sao Paulo. SP", "M", 30000, "33344555587", 5
);

INSERT INTO funcionario VALUES(
"66688444476", "Ronaldo", "K", "Lima", "1962-09-15", "Rua Reboucas. 65. Piracicaba. SP", "M", 38000, "33344555587", 5
);

INSERT INTO funcionario VALUES(
"45345345376", "Joice", "A", "Leite", "1972-07-31", "Av Lucas Obes. 74. Sao Paulo. SP", "F", 25000, "33344555587", 5
);

-- Inserindo o numero, nome, cpf do gerente, e data de inicio do gerente, dos departamentos.

INSERT INTO departamento VALUES(
5, "Pesquisa", "33344555587", "1988-05-22"
);

INSERT INTO departamento VALUES(
4, "Administracao", "98765432168", "1995-01-01"
);

INSERT INTO departamento VALUES(
1, "Matriz", "88866555576", "1981-06-19"
);

-- Inserindo a numero, e localizacao, dos departamentos.

INSERT INTO localizacoes_departamento VALUES(
1, "Sao Paulo"
);

INSERT INTO localizacoes_departamento VALUES(
4, "Maua"
);

INSERT INTO localizacoes_departamento VALUES(
5, "Santo Andre"
);

INSERT INTO localizacoes_departamento VALUES(
5, "Itu"
);

INSERT INTO localizacoes_departamento VALUES(
5, "Sao Paulo"
);

-- Inserindo o numero, nome, localizacao, e numero do departamento, dos projetos.

INSERT INTO projeto VALUES(
1, "ProdutoX", "Santo Andre", 5
);

INSERT INTO projeto VALUES(
2, "ProdutoY", "Itu", 5
);

INSERT INTO projeto VALUES(
3, "ProdutoZ", "Sao Paulo", 5
);

INSERT INTO projeto VALUES(
10, "Informatizacao", "Maua", 4
);

INSERT INTO projeto VALUES(
20, "Reorganizacao", "Sao Paulo", 1
);

INSERT INTO projeto VALUES(
30, "Novosbeneficios", "Maua", 4
);

-- Inserindo o cpf do funcionario relacionado, nome, sexo, data de nascimento, e parentesco, dos dependentes.

INSERT INTO dependente VALUES(
"33344555587", "Alicia", "F", "1986-04-05", "Filha"
);

INSERT INTO dependente VALUES(
"33344555587", "Tiago", "M", "1983-10-25", "Filho"
);

INSERT INTO dependente VALUES(
"33344555587", "Janaina", "F", "1958-05-03", "Esposa"
);

INSERT INTO dependente VALUES(
"98765432168", "Antonio", "M", "1942-02-28", "Marido"
);

INSERT INTO dependente VALUES(
"12345678966", "Michael", "M", "1988-01-04", "Filho"
);

INSERT INTO dependente VALUES(
"12345678966", "Alicia", "F", "1988-12-30", "Filha"
);

INSERT INTO dependente VALUES(
"12345678966", "Elizabeth", "F", "1967-05-05", "Esposa"
);

-- Inserindo os cpfs, numero do projeto, e horas trabalhadas em cada projeto por cada respectivo funcionario.

INSERT INTO trabalha_em VALUES(
"12345678966", 1, 32.5
);

INSERT INTO trabalha_em VALUES(
"12345678966", 2, 7.5
);

INSERT INTO trabalha_em VALUES(
"66688444476", 3, 40.0
);

INSERT INTO trabalha_em VALUES(
"45345345376", 1, 20.0
);

INSERT INTO trabalha_em VALUES(
"45345345376", 2, 20.0
);

INSERT INTO trabalha_em VALUES(
"33344555587", 2, 10.0
);

INSERT INTO trabalha_em VALUES(
"33344555587", 3, 10.0
);

INSERT INTO trabalha_em VALUES(
"33344555587", 10, 10.0
);

INSERT INTO trabalha_em VALUES(
"33344555587", 20, 10.0
);

INSERT INTO trabalha_em VALUES(
"99988777767", 30, 30.0
);

INSERT INTO trabalha_em VALUES(
"99988777767", 10, 10.0
);

INSERT INTO trabalha_em VALUES(
"98798798733", 10, 35.0
);

INSERT INTO trabalha_em VALUES(
"98798798733", 30, 5.0
);

INSERT INTO trabalha_em VALUES(
"98765432168", 30, 20.0
);

INSERT INTO trabalha_em VALUES(
"98765432168", 20, 15.0
);

INSERT INTO trabalha_em VALUES(
"88866555576", 20, 00.0
);
