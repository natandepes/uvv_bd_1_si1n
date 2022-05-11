DROP DATABASE IF EXISTS uvv; -- Inserindo um comando para deletar o banco de dados com o mesmo nome que eu irei criar, caso exista.
DROP USER IF EXISTS natan;   -- Inserindo um comando para deletar o usuario com o mesmo nome que eu irei criar, caso exista.

CREATE USER natan WITH  -- Criando meu user.
  LOGIN -- Direito a login
  NOSUPERUSER -- Sem poderes de superusuario.
  INHERIT -- Alguma interacao de criacao de tabelas que eu nao compreendi muito bem, mas decidi integrar no meu user.
  CREATEDB -- Direito a criar bancos de dados.
  CREATEROLE -- Direito a criar roles. 
  REPLICATION -- Direito a transferir dados entre bancos de dados.
  ENCRYPTED PASSWORD 'maclmera';

-- Criando o banco de dados uvv.

CREATE DATABASE uvv 
WITH OWNER = natan  -- Meu user tem como dono.
TEMPLATE = template0 
ENCODING = 'UTF8' 
LC_COLLATE = 'pt_BR.UTF-8' 
LC_CTYPE = 'pt_BR.UTF-8'
ALLOW_CONNECTIONS = true;

-- Colocando o path do meu usuario para o esquema elmasri.

ALTER USER natan
SET SEARCH_PATH TO elmasri, "$user", public;

-- Me conectando no banco de dados uvv, com meu usuario.

\c "dbname=uvv user=natan password=maclmera"

-- Criando o esquema elmasri, que ficara dentro do banco de dados uvv.

CREATE SCHEMA elmasri     -- Criando o esquema elmasri aonde ficarao alocadas minhas tabelas.
    AUTHORIZATION natan;  -- Autorizando meu user nesse esquema.

-- Criando a tabela funcionario.

CREATE TABLE elmasri.funcionario (
                cpf CHAR(11) NOT NULL,
                primeiro_nome VARCHAR(15) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(15) NOT NULL,
                data_nascimento DATE,
                endereco VARCHAR(50),
                sexo CHAR(1),
                salario NUMERIC(10,2),
                cpf_supervisor CHAR(11),
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT pk_funcionario PRIMARY KEY (cpf)
);

-- Adicionando comentarios para cada campo e para a tabela funcionario.

COMMENT ON TABLE elmasri.funcionario IS 'Tabela que armazena as informacoes dos funcionarios.';
COMMENT ON COLUMN elmasri.funcionario.cpf IS 'CPF do funcionario, PK da tabela.';
COMMENT ON COLUMN elmasri.funcionario.primeiro_nome IS 'Primeiro nome do funcionario.';
COMMENT ON COLUMN elmasri.funcionario.nome_meio IS 'Inicial do nome do meio.';
COMMENT ON COLUMN elmasri.funcionario.ultimo_nome IS 'Sobrenome do funcionario.';
COMMENT ON COLUMN elmasri.funcionario.data_nascimento IS 'Data de nascimento do funcionario.';
COMMENT ON COLUMN elmasri.funcionario.endereco IS 'Endereco do funcionario.';
COMMENT ON COLUMN elmasri.funcionario.sexo IS 'Sexo do funcionario.';
COMMENT ON COLUMN elmasri.funcionario.salario IS 'Salario do funcionario.';
COMMENT ON COLUMN elmasri.funcionario.cpf_supervisor IS 'CPF do supervisor, FK para a própria tabela (um auto-relacionamento).';
COMMENT ON COLUMN elmasri.funcionario.numero_departamento IS 'Numero do departamento do funcionario.';

-- Adicionando restricoes na tabela funcionario. (Constraints)

ALTER TABLE elmasri.funcionario ADD CONSTRAINT sex CHECK (sexo='M' OR sexo='F'); -- constraint permitindo apenas que os sexos sejam indicados por M ou F
ALTER TABLE elmasri.funcionario ADD CONSTRAINT salario_positivo CHECK (salario > -1); -- constraint impedindo de um funcionario ganhar salario negativo
ALTER TABLE elmasri.funcionario ADD CONSTRAINT num_dep CHECK (numero_departamento > 0); -- constraint impedindo que seja adicionado um numero de departamento <=0
ALTER TABLE elmasri.funcionario ADD CONSTRAINT data CHECK (data_nascimento BETWEEN '1933-01-01' AND '2004-01-01'); -- constraint que limita a idade do funcionario de 89 anos ate 18, eu pretendia colocar 80 no maximo mas tem um funcionario com 85 anos


-- Criando a tabela departamento.

CREATE TABLE elmasri.departamento (
                numero_departamento INTEGER NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                cpf_gerente CHAR(11) NOT NULL,
                data_inicio_gerente DATE,
                CONSTRAINT pk_departamento PRIMARY KEY (numero_departamento)
);

-- Adicionando comentarios em cada campo e para a tabela departamento.

COMMENT ON TABLE elmasri.departamento IS 'Tabela que armazena as informacoes dos departamentos.';
COMMENT ON COLUMN elmasri.departamento.numero_departamento IS 'Numero do departamento, PK desta tabela.';
COMMENT ON COLUMN elmasri.departamento.nome_departamento IS 'Nome do departamento. Deve ser unico.';
COMMENT ON COLUMN elmasri.departamento.cpf_gerente IS 'CPF do gerente do departamento, FK para a tabela funcionario.';
COMMENT ON COLUMN elmasri.departamento.data_inicio_gerente IS 'Data do inicio do gerente no departamento.';

-- Adicionando restricoes na tabela departamento. (Constraints)

ALTER TABLE departamento ADD CONSTRAINT num_dep2 CHECK (numero_departamento > 0);  -- constraint impedindo que seja adicionado um numero de departamento <=0
ALTER TABLE departamento ADD CONSTRAINT data_gerente CHECK (data_inicio_gerente BETWEEN '1981-06-18' AND '2023-01-01');  -- constraint permitindo que so seja adicionada a data de inicio de um gerente desde o ultimo gerente, ate ano que vem

CREATE UNIQUE INDEX idx_nome_departamento -- criando a Alternate Key para a tabela departamento, indicando que o nome de cada departamento deve ser unico.
 ON elmasri.departamento
 ( nome_departamento );


-- Criando a tabela localizacoes_departamento.

CREATE TABLE elmasri.localizacoes_departamento (
                numero_departamento INTEGER NOT NULL,
                local VARCHAR(15) NOT NULL,
                CONSTRAINT pk_localizacoes_departamento PRIMARY KEY (numero_departamento, local)
);

-- Adicionando comentario em cada campo e na tabela localizacoes_departamento.

COMMENT ON TABLE elmasri.localizacoes_departamento IS 'Tabela que armazena as possiveis localizacoes dos departamentos.';
COMMENT ON COLUMN elmasri.localizacoes_departamento.numero_departamento IS 'Numero do departamento. Faz parte da PK desta tabela, e tambem FK para a tabela departamento.';
COMMENT ON COLUMN elmasri.localizacoes_departamento.local IS 'Localizacao do departamento. Faz parte da PK desta tabela.';


-- Criando a tabela projeto.

CREATE TABLE elmasri.projeto (
                numero_projeto INTEGER NOT NULL,
                nome_projeto VARCHAR(15) NOT NULL,
                local_projeto VARCHAR(15),
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT pk_projeto PRIMARY KEY (numero_projeto)
);

-- Adicionando comentarios em cada campo e na tabela projeto.

COMMENT ON TABLE elmasri.projeto IS 'Tabela que armazena as informacoes sobre os projetos dos departamentos.';
COMMENT ON COLUMN elmasri.projeto.numero_projeto IS 'Numero do projeto, PK desta tabela.';
COMMENT ON COLUMN elmasri.projeto.nome_projeto IS 'Nome do projeto. Deve ser unico.';
COMMENT ON COLUMN elmasri.projeto.local_projeto IS 'Localizacao do projeto.';
COMMENT ON COLUMN elmasri.projeto.numero_departamento IS 'Numero do departamento. E uma FK para a tabela departamento.';

-- Adicionando restricoes na tabela projeto. (Constraints)

ALTER TABLE elmasri.projeto ADD CONSTRAINT num_proj CHECK (numero_projeto > 0); -- constraint impedindo que seja adicionado um numero de projeto <=0

CREATE UNIQUE INDEX idx_nome_projeto -- criando a Alternate Key para a tabela projeto, indicando que o nome de cada projeto deve ser unico
 ON elmasri.projeto
 ( nome_projeto );


-- Criando a tabela trabalha_em.

CREATE TABLE elmasri.trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL,
                numero_projeto INTEGER NOT NULL,
                horas NUMERIC(3,1),
                CONSTRAINT pk_trabalha_em PRIMARY KEY (cpf_funcionario, numero_projeto)
);

-- Adicionando comentarios em cada campo e na tabela trabalha_em.

COMMENT ON TABLE elmasri.trabalha_em IS 'Tabela para armazenar quais funcionários trabalham em quais projetos.';
COMMENT ON COLUMN elmasri.trabalha_em.cpf_funcionario IS 'CPF do funcionario. Faz parte da PK desta tabela, e tambem uma FK para a tabela funcionario.';
COMMENT ON COLUMN elmasri.trabalha_em.numero_projeto IS 'Número do projeto. Faz parte da PK desta tabela, e tambem uma FK para a tabela projeto.';
COMMENT ON COLUMN elmasri.trabalha_em.horas IS 'Horas trabalhadas pelo funcionario neste projeto.';

-- Adicionando restricoes. (Constraints)

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT hora_projeto CHECK (horas > -1); -- Constraint impedindo que sejam adicionadas horas negativas.


-- Criando tabela dependente.

CREATE TABLE elmasri.dependente (
                cpf_funcionario CHAR(11) NOT NULL,
                nome_dependente VARCHAR(15) NOT NULL,
                sexo CHAR(1),
                data_nascimento DATE,
                parentesco VARCHAR(15),
                CONSTRAINT pk_dependente PRIMARY KEY (cpf_funcionario, nome_dependente)
);

-- Adicionando comentarios em cada campo e na tabela dependente.

COMMENT ON TABLE elmasri.dependente IS 'Tabela que armazena as informacoes dos dependentes dos funcionarios.';
COMMENT ON COLUMN elmasri.dependente.cpf_funcionario IS 'CPF do funcionario. Faz parte da PK desta tabela, e tambem uma FK para a tabela funcionario.';
COMMENT ON COLUMN elmasri.dependente.nome_dependente IS 'Nome do dependente. Faz parte da PK desta tabela.';
COMMENT ON COLUMN elmasri.dependente.sexo IS 'Sexo do dependente.';
COMMENT ON COLUMN elmasri.dependente.data_nascimento IS 'Data de nascimento do dependente.';
COMMENT ON COLUMN elmasri.dependente.parentesco IS 'Descrição do parentesco do dependente com o funcionario.';

-- Adicionando restricoes. (Constraints)

ALTER TABLE elmasri.dependente ADD CONSTRAINT sex_dep CHECK (sexo='M' OR sexo='F'); -- Constraint permitindo apenas que os sexos sejam indicados por M ou F.
ALTER TABLE elmasri.dependente ADD CONSTRAINT data_dep CHECK (data_nascimento BETWEEN '1928-01-01' AND '2004-01-01'); -- Constraint permitindo que os dependentes tenham nascido desde 1928 ate 2004, coloquei 1928 pois os pais de alguem podem ser dependentes, e 2004 pois nao faz sentido indicar dados de um menor de idade.


-- Inserindo as Foreign Keys em todas as tabelas.

ALTER TABLE elmasri.funcionario ADD CONSTRAINT funcionario_funcionario_fk -- Adicionando a FK cpf_supervisor que referencia a PK cpf na mesma tabela (funcionario).
FOREIGN KEY (cpf_supervisor)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.dependente ADD CONSTRAINT funcionario_dependente_fk -- Adicionando a FK cpf_funcionario que referencia a PK cpf na tabela funcionario.
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk -- Adicionando a FK cpf_funcionario na tabela trabalha_em que referencia a PK cpf na tabela funcionario.
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.departamento ADD CONSTRAINT funcionario_departamento_fk -- Adicionando a FK cpf_gerente na tabela departamento que refrencia a PK cpf na tabela funcionario.
FOREIGN KEY (cpf_gerente)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.projeto ADD CONSTRAINT departamento_projeto_fk -- Adicionando a FK numero_departamento na tabela projetoo que referencia a PK numero_departamento na tabela departamento.
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk -- Adicionando a FK numero_departamento na tabela localizacoes_departamento que refencia a PK numero_departamento na tabela departamento
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk -- Adicionando a FK numero_projeto na tabela trabalha_em que referecia o campo numero_projeto na tabela projeto.
FOREIGN KEY (numero_projeto)
REFERENCES elmasri.projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


-- Inserindo o cpf, nome, nome do meio, ultimo nome, data de nasciemnto, endereco, sexo, salario, cpf do supervisor, e departamento, dos funcionarios.

INSERT INTO funcionario VALUES
('88866555576', 'Jorge', 'E', 'Brito', '1937-11-10', 'Rua do Horto. 35. Sao Paulo. SP', 'M', 55000, null, 1);

INSERT INTO funcionario VALUES
('98765432168', 'Jennifer', 'S', 'Souza', '1941-06-20', 'Av Arthur de Lima. 54. Santo Andre. SP', 'F', 43000, '88866555576', 4);

INSERT INTO funcionario VALUES
('33344555587', 'Fernando', 'T', 'Wong', '1955-12-08', 'Rua da Lapa. 34. Sao Paulo. SP', 'M', 40000, '88866555576', 5);

INSERT INTO funcionario VALUES
('99988777767', 'Alice', 'J', 'Zelaya', '1968-01-19', 'Rua Souza Lima. 35. Curitiba. PR', 'F', 25000, '98765432168', 4);

INSERT INTO funcionario VALUES
('98798798733', 'Andre', 'V', 'Pereira', '1969-03-29', 'Rua Timbira 35. Sao Paulo. SP', 'M', 25000, '98765432168', 4);

INSERT INTO funcionario VALUES
('12345678966', 'Joao', 'B', 'Silva', '1965-01-09', 'Rua das Flores. 751. Sao Paulo. SP', 'M', 30000, '33344555587', 5);

INSERT INTO funcionario VALUES
('66688444476', 'Ronaldo', 'K', 'Lima', '1962-09-15', 'Rua Reboucas. 65. Piracicaba. SP', 'M', 38000, '33344555587', 5);

INSERT INTO funcionario VALUES
('45345345376', 'Joice', 'A', 'Leite', '1972-07-31', 'Av Lucas Obes. 74. Sao Paulo. SP', 'F', 25000, '33344555587', 5);

-- Inserindo o numero, nome, cpf do gerente, e data de inicio do gerente, dos departamentos.

INSERT INTO departamento VALUES
(5, 'Pesquisa', '33344555587', '1988-05-22');

INSERT INTO departamento VALUES
(4, 'Administracao', '98765432168', '1995-01-01');

INSERT INTO departamento VALUES
(1, 'Matriz', '88866555576', '1981-06-19');

-- Inserindo a numero, e localizacao, dos departamentos.

INSERT INTO localizacoes_departamento VALUES
(1, 'Sao Paulo');

INSERT INTO localizacoes_departamento VALUES
(4, 'Maua');

INSERT INTO localizacoes_departamento VALUES
(5, 'Santo Andre');

INSERT INTO localizacoes_departamento VALUES
(5, 'Itu');

INSERT INTO localizacoes_departamento VALUES
(5, 'Sao Paulo');

-- Inserindo o numero, nome, localizacao, e numero do departamento, dos projetos.

INSERT INTO projeto VALUES
(1, 'ProdutoX', 'Santo Andre', 5);

INSERT INTO projeto VALUES
(2, 'ProdutoY', 'Itu', 5);

INSERT INTO projeto VALUES
(3, 'ProdutoZ', 'Sao Paulo', 5);

INSERT INTO projeto VALUES
(10, 'Informatizacao', 'Maua', 4);

INSERT INTO projeto VALUES
(20, 'Reorganizacao', 'Sao Paulo', 1);

INSERT INTO projeto VALUES
(30, 'Novosbeneficios', 'Maua', 4);

-- Inserindo o cpf do funcionario relacionado, nome, sexo, data de nascimento, e parentesco, dos dependentes.

INSERT INTO dependente VALUES
('33344555587', 'Alicia', 'F', '1986-04-05', 'Filha');

INSERT INTO dependente VALUES
('33344555587', 'Tiago', 'M', '1983-10-25', 'Filho');

INSERT INTO dependente VALUES
('33344555587', 'Janaina', 'F', '1958-05-03', 'Esposa');

INSERT INTO dependente VALUES
('98765432168', 'Antonio', 'M', '1942-02-28', 'Marido');

INSERT INTO dependente VALUES
('12345678966', 'Michael', 'M', '1988-01-04', 'Filho');

INSERT INTO dependente VALUES
('12345678966', 'Alicia', 'F', '1988-12-30', 'Filha');

INSERT INTO dependente VALUES
('12345678966', 'Elizabeth', 'F', '1967-05-05', 'Esposa');

-- Inserindo os cpfs, numero do projeto, e horas trabalhadas em cada projeto por cada respectivo funcionario.

INSERT INTO trabalha_em VALUES
('12345678966', 1, 32.5);

INSERT INTO trabalha_em VALUES
('12345678966', 2, 7.5);

INSERT INTO trabalha_em VALUES
('66688444476', 3, 40.0);

INSERT INTO trabalha_em VALUES
('45345345376', 1, 20.0);

INSERT INTO trabalha_em VALUES
('45345345376', 2, 20.0);

INSERT INTO trabalha_em VALUES
('33344555587', 2, 10.0);

INSERT INTO trabalha_em VALUES
('33344555587', 3, 10.0);

INSERT INTO trabalha_em VALUES
('33344555587', 10, 10.0);

INSERT INTO trabalha_em VALUES
('33344555587', 20, 10.0);

INSERT INTO trabalha_em VALUES
('99988777767', 30, 30.0);

INSERT INTO trabalha_em VALUES
('99988777767', 10, 10.0);

INSERT INTO trabalha_em VALUES
('98798798733', 10, 35.0);

INSERT INTO trabalha_em VALUES
('98798798733', 30, 5.0);

INSERT INTO trabalha_em VALUES
('98765432168', 30, 20.0);

INSERT INTO trabalha_em VALUES
('98765432168', 20, 15.0);

INSERT INTO trabalha_em VALUES
('88866555576', 20, 00.0);
