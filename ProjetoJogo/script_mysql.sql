-- ------------------------------------------------------------------------------------------ --
-- SCRIPT FEITO PARA SER EXECUTADO NO MYSQL                                                   --
-- Gostariamos de ter colocado constraints que impediriam o usuário de colocar uma data de    --
-- início de um jogo ou partida menor que a do sistema, mas para isso é necessário o uso de   
-- "Triggers", algo que ainda não sabemos.                                                    --
-- ------------------------------------------------------------------------------------------ --

/* Criando o banco de dados jogo */
CREATE DATABASE jogo;


/* Selecionando o banco de dados como ativo */
USE jogo;


/* CRIANDO AS TABELAS E INSERINDO OS COMENTÁRIOS */

/* Criando a tabela "imagem_fundo" */
CREATE TABLE imagem_fundo (
                codigo SMALLINT NOT NULL,
                imagem BINARY NOT NULL,
                PRIMARY KEY (codigo)
);

/* Inserindo comentários na tabela "imagem_fundo" */
ALTER TABLE imagem_fundo COMMENT 'Tabela que armazena as imagens de fundo.';

ALTER TABLE imagem_fundo MODIFY COLUMN codigo SMALLINT COMMENT 'Codigo da imagem de fundo. PK da tabela.';

ALTER TABLE imagem_fundo MODIFY COLUMN imagem BINARY COMMENT 'Imagem do plano de fundo.';


/* Criando a tabela "cores" */
CREATE TABLE cores (
                codigo SMALLINT NOT NULL,
                cor VARCHAR(20) NOT NULL,
                PRIMARY KEY (codigo)
);

/* Inserindo comentários na tabela "cores" */
ALTER TABLE cores COMMENT 'Tabela que armazena as cores.';

ALTER TABLE cores MODIFY COLUMN codigo SMALLINT COMMENT 'Codigo da cor. PK da tabela.';

ALTER TABLE cores MODIFY COLUMN cor VARCHAR(20) COMMENT 'Nome da cor.';


/* Criando a tabela "configuracoes" */
CREATE TABLE configuracoes (
                codigo SMALLINT NOT NULL,
                volume SMALLINT NOT NULL,
                brilho SMALLINT NOT NULL,
                PRIMARY KEY (codigo)
);

/* Inserindo comentários na tabela "configuracoes" */
ALTER TABLE configuracoes COMMENT 'Tabela que armazena as configuracoes.';

ALTER TABLE configuracoes MODIFY COLUMN codigo SMALLINT COMMENT 'Codigo da configuracao. PK da tabela.';


/* Criando a tabela "imagem_fundo_configuracoes" */
CREATE TABLE imagem_fundo_configuracoes (
                codigo_imagem_fundo SMALLINT NOT NULL,
                codigo_configuracoes SMALLINT,
                PRIMARY KEY (codigo_imagem_fundo)
);

/* Inserindo comentários na tabela "imagem_fundo_configuracoes" */
ALTER TABLE imagem_fundo_configuracoes COMMENT 'Tabela criada pelo relacionamento N:N entre configuracoes e imagem_fundo.';

ALTER TABLE imagem_fundo_configuracoes MODIFY COLUMN codigo_imagem_fundo SMALLINT COMMENT 'Codigo da imagem de fundo. PK da tabela.';

ALTER TABLE imagem_fundo_configuracoes MODIFY COLUMN codigo_configuracoes SMALLINT COMMENT 'Codigo da configuracao.';


/* Criando a tabela "cores_configuracoes" */
CREATE TABLE cores_configuracoes (
                codigo_configuracoes SMALLINT NOT NULL,
                codigo_cores SMALLINT NOT NULL,
                PRIMARY KEY (codigo_configuracoes, codigo_cores)
);

/* Inserindo comentários na tabela "cores_configuracoes" */
ALTER TABLE cores_configuracoes COMMENT 'Tabela criada pelo relacionamento N:N entre configuracoes e cores.';

ALTER TABLE cores_configuracoes MODIFY COLUMN codigo_configuracoes SMALLINT COMMENT 'Codigo da configuracao.';

ALTER TABLE cores_configuracoes MODIFY COLUMN codigo_cores SMALLINT COMMENT 'Codigo da cor.';


/* Criando a tabela "jogos" */
CREATE TABLE jogos (
                codigo SMALLINT NOT NULL,
                nome VARCHAR(80) NOT NULL,
                objetivo VARCHAR(200) NOT NULL,
                numero_de_niveis SMALLINT NOT NULL,
                data_criacao DATE NOT NULL,
                PRIMARY KEY (codigo)
);

/* Inserindo comentários na tabela "jogos" */
ALTER TABLE jogos COMMENT 'Tabela que armazena dados dos jogos.';

ALTER TABLE jogos MODIFY COLUMN codigo SMALLINT COMMENT 'Codigo do jogo.';

ALTER TABLE jogos MODIFY COLUMN nome VARCHAR(80) COMMENT 'Nome do jogo.';

ALTER TABLE jogos MODIFY COLUMN objetivo VARCHAR(200) COMMENT 'Objetivo do jogo.';

ALTER TABLE jogos MODIFY COLUMN numero_de_niveis SMALLINT COMMENT 'Numero de niveis desse jogo.';

ALTER TABLE jogos MODIFY COLUMN data_criacao DATE COMMENT 'Data de criacao do jogo.';


/* Criando a tabela "personalizacoes" */
CREATE TABLE personalizacoes (
                codigo_configuracoes SMALLINT NOT NULL,
                codigo_jogos SMALLINT,
                data_configuracao DATE NOT NULL,
                PRIMARY KEY (codigo_configuracoes)
);

/* Inserindo comentários na tabela "personalizacoes" */
ALTER TABLE personalizacoes COMMENT 'Tabela criada pelo relacionamento N:N entre jogos e configuracoes';

ALTER TABLE personalizacoes MODIFY COLUMN codigo_configuracoes SMALLINT COMMENT 'Codigo da configuracao. PK da tabela.';

ALTER TABLE personalizacoes MODIFY COLUMN codigo_jogos SMALLINT COMMENT 'Codigo do jogo.';

ALTER TABLE personalizacoes MODIFY COLUMN data_configuracao DATE COMMENT 'Data da configuracao.';


/* Criando a tabela "objetos" */
CREATE TABLE objetos (
                codigo SMALLINT NOT NULL,
                nome VARCHAR(80) NOT NULL,
                descricao VARCHAR(200) NOT NULL,
                PRIMARY KEY (codigo)
);

/* Inserindo comentários na tabela "objetos" */
ALTER TABLE objetos COMMENT 'Tabela que armazena dados de objetos.';

ALTER TABLE objetos MODIFY COLUMN codigo SMALLINT COMMENT 'Codigo do objeto.';

ALTER TABLE objetos MODIFY COLUMN nome VARCHAR(80) COMMENT 'Nome do objeto.';

ALTER TABLE objetos MODIFY COLUMN descricao VARCHAR(200) COMMENT 'Descricao do objeto.';


/* Criando a tabela "trilhas_sonoras" */
CREATE TABLE trilhas_sonoras (
                codigo SMALLINT NOT NULL,
                nome VARCHAR(80) NOT NULL,
                valencia VARCHAR(8) NOT NULL,
                PRIMARY KEY (codigo)
);

/* Inserindo comentários na tabela "trilhas_sonoras" */
ALTER TABLE trilhas_sonoras COMMENT 'Tabela que armazenam as trilhas sonoras.';

ALTER TABLE trilhas_sonoras MODIFY COLUMN codigo SMALLINT COMMENT 'Codigo da trilha sonora.';

ALTER TABLE trilhas_sonoras MODIFY COLUMN nome VARCHAR(80) COMMENT 'Nome da trilha sonora.';

ALTER TABLE trilhas_sonoras MODIFY COLUMN valencia VARCHAR(8) COMMENT 'Valencia da da trilha sonora.';


/* Criando a tabela "missoes" */
CREATE TABLE missoes (
                codigo SMALLINT NOT NULL,
                nome VARCHAR(80) NOT NULL,
                descricao VARCHAR(200) NOT NULL,
                tempo_maximo TIME,
                pontuacao INT NOT NULL,
                PRIMARY KEY (codigo)
);

/* Inserindo comentários na tabela "missoes" */
ALTER TABLE missoes COMMENT 'Tabela que armazena os dados das missoes.';

ALTER TABLE missoes MODIFY COLUMN codigo SMALLINT COMMENT 'Codigo das missoes.';

ALTER TABLE missoes MODIFY COLUMN nome VARCHAR(80) COMMENT 'Nome da missao.';

ALTER TABLE missoes MODIFY COLUMN descricao VARCHAR(200) COMMENT 'Descricao da missao.';

ALTER TABLE missoes MODIFY COLUMN tempo_maximo TIME COMMENT 'Tempo maximo de duracao da missao.';

ALTER TABLE missoes MODIFY COLUMN pontuacao INTEGER COMMENT 'Pontuacao da missao.';


/* Criando a tabela "jogadores" */
CREATE TABLE jogadores (
                codigo SMALLINT NOT NULL,
                nome VARCHAR(80) NOT NULL,
                apelido VARCHAR(20),
                imagem BINARY,
                data_de_registro DATE NOT NULL,
                localizacao VARCHAR(200),
                PRIMARY KEY (codigo)
);

/* Inserindo comentários na tabela "jogadores" */
ALTER TABLE jogadores COMMENT 'Tabela que armazenam os dados dos jogadores.';

ALTER TABLE jogadores MODIFY COLUMN codigo SMALLINT COMMENT 'Codigo dos jogadores. PK da tabela.';

ALTER TABLE jogadores MODIFY COLUMN nome VARCHAR(80) COMMENT 'Nome do jogador.';

ALTER TABLE jogadores MODIFY COLUMN apelido VARCHAR(20) COMMENT 'Apelido do jogador.';

ALTER TABLE jogadores MODIFY COLUMN imagem BINARY COMMENT 'Imagem do jogador.';

ALTER TABLE jogadores MODIFY COLUMN data_de_registro DATE COMMENT 'Data de registro do jogador.';

ALTER TABLE jogadores MODIFY COLUMN localizacao VARCHAR(200) COMMENT 'Localizacao do jogador.';


/* Criando a tabela "personagens" */
CREATE TABLE personagens (
                codigo SMALLINT NOT NULL,
                nome VARCHAR(80) NOT NULL,
                imagem BINARY,
                PRIMARY KEY (codigo)
);

/* Inserindo comentários na tabela "personagens" */
ALTER TABLE personagens COMMENT 'Tabela que armazena os dados dos personagens.';

ALTER TABLE personagens MODIFY COLUMN codigo SMALLINT COMMENT 'Codigo do personagem.';

ALTER TABLE personagens MODIFY COLUMN nome VARCHAR(80) COMMENT 'Nome do personagem.';

ALTER TABLE personagens MODIFY COLUMN imagem BINARY COMMENT 'Imagem do personagem.';


/* Criando a tabela "cenarios" */
CREATE TABLE cenarios (
                codigo SMALLINT NOT NULL,
                nome VARCHAR(80) NOT NULL,
                tema VARCHAR(200) NOT NULL,
                PRIMARY KEY (codigo)
);

/* Inserindo comentários na tabela "cenarios" */
ALTER TABLE cenarios COMMENT 'Tabela que armazena os dados dos cenarios.';

ALTER TABLE cenarios MODIFY COLUMN codigo SMALLINT COMMENT 'Codigo do cenario.';

ALTER TABLE cenarios MODIFY COLUMN nome VARCHAR(80) COMMENT 'Nome do cenario.';

ALTER TABLE cenarios MODIFY COLUMN tema VARCHAR(200) COMMENT 'Tema do cenario.';


/* Criando a tabela "niveis" */
CREATE TABLE niveis (
                codigo SMALLINT NOT NULL,
                codigo_jogos SMALLINT NOT NULL,
                nome VARCHAR(80) NOT NULL,
                descricao VARCHAR(200) NOT NULL,
                PRIMARY KEY (codigo, codigo_jogos)
);

/* Inserindo comentários na tabela "niveis" */
ALTER TABLE niveis COMMENT 'Tabela que armazena os níveis.';

ALTER TABLE niveis MODIFY COLUMN codigo SMALLINT COMMENT 'Codigo do nivel. PK da tabela.';

ALTER TABLE niveis MODIFY COLUMN codigo_jogos SMALLINT COMMENT 'Codigo do jogo.';

ALTER TABLE niveis MODIFY COLUMN nome VARCHAR(80) COMMENT 'Nome do nivel.';

ALTER TABLE niveis MODIFY COLUMN descricao VARCHAR(200) COMMENT 'Descricao do nivel.';


/* Criando a tabela "composicoes" */
CREATE TABLE composicoes (
                codigo_niveis SMALLINT NOT NULL,
                codigo_jogos SMALLINT NOT NULL,
                codigo_objetos SMALLINT NOT NULL,
                posicao_inicial VARCHAR(200) NOT NULL,
                pontos INT NOT NULL,
                PRIMARY KEY (codigo_niveis, codigo_jogos, codigo_objetos)
);

/* Inserindo comentários na tabela "composicoes" */
ALTER TABLE composicoes COMMENT 'Tabela criada pelo relacionamento N:N entre objetos e niveis.';

ALTER TABLE composicoes MODIFY COLUMN codigo_niveis SMALLINT COMMENT 'Codigo do nivel. Faz parte da PK da tabela.';

ALTER TABLE composicoes MODIFY COLUMN codigo_jogos SMALLINT COMMENT 'Codigo do jogo.';

ALTER TABLE composicoes MODIFY COLUMN codigo_objetos SMALLINT COMMENT 'Codigo do objeto. Faz parte da PK da tabela.';

ALTER TABLE composicoes MODIFY COLUMN posicao_inicial VARCHAR(200) COMMENT 'Posicao inicial da composicao.';

ALTER TABLE composicoes MODIFY COLUMN pontos INTEGER COMMENT 'Pontos da composicao.';


/* Criando a tabela "trilhas_sonoras_niveis" */
CREATE TABLE trilhas_sonoras_niveis (
                codigo_niveis SMALLINT NOT NULL,
                codigo_jogos SMALLINT NOT NULL,
                codigo_trilhas_sonoras SMALLINT NOT NULL,
                PRIMARY KEY (codigo_niveis, codigo_jogos, codigo_trilhas_sonoras)
);

/* Inserindo comentários na tabela "trilhas_sonoras_niveis" */
ALTER TABLE trilhas_sonoras_niveis COMMENT 'Tabela criada pela relacao N:N entre trilhas sonoras e niveis.';

ALTER TABLE trilhas_sonoras_niveis MODIFY COLUMN codigo_niveis SMALLINT COMMENT 'Codigo do nivel. Faz parte da PK da tabela.';

ALTER TABLE trilhas_sonoras_niveis MODIFY COLUMN codigo_jogos SMALLINT COMMENT 'Codigo do jogo.';

ALTER TABLE trilhas_sonoras_niveis MODIFY COLUMN codigo_trilhas_sonoras SMALLINT COMMENT 'Codigo da trilha sonora. Faz parte da PK da tabela.';


/* Criando a tabela "missoes_niveis" */
CREATE TABLE missoes_niveis (
                codigo_missoes SMALLINT NOT NULL,
                codigo_niveis SMALLINT,
                codigo_jogos SMALLINT NOT NULL,
                PRIMARY KEY (codigo_missoes)
);

/* Inserindo comentários na tabela "missoes_niveis" */
ALTER TABLE missoes_niveis COMMENT 'Tabela criada pela relacao N:N entre missoes e niveis.';

ALTER TABLE missoes_niveis MODIFY COLUMN codigo_missoes SMALLINT COMMENT 'Codigo das missoes. PK da tabela.';

ALTER TABLE missoes_niveis MODIFY COLUMN codigo_niveis SMALLINT COMMENT 'Codigo do nivel.';

ALTER TABLE missoes_niveis MODIFY COLUMN codigo_jogos SMALLINT COMMENT 'Codigo do jogo.';


/* Criando a tabela "partidas" */
CREATE TABLE partidas (
                codigo_niveis SMALLINT NOT NULL,
                codigo_jogos SMALLINT NOT NULL,
                codigo_jogadores SMALLINT NOT NULL,
                data_inicio DATE NOT NULL,
                data_fim DATE NOT NULL,
                hora_inicio TIME NOT NULL,
                hora_fim TIME NOT NULL,
                pontuacao SMALLINT NOT NULL,
                PRIMARY KEY (codigo_niveis, codigo_jogos)
);

/* Inserindo comentários na tabela "partidas" */
ALTER TABLE partidas COMMENT 'Tabela criada pelo relacionamento N:N entre jogadores e niveis. Partidas jogadas por jogadores.';

ALTER TABLE partidas MODIFY COLUMN codigo_niveis SMALLINT COMMENT 'Codigo do nivel. PK da tabela.';

ALTER TABLE partidas MODIFY COLUMN codigo_jogos SMALLINT COMMENT 'Codigo do jogo.';

ALTER TABLE partidas MODIFY COLUMN codigo_jogadores SMALLINT COMMENT 'Codigo dos jogadores.';

ALTER TABLE partidas MODIFY COLUMN data_inicio DATE COMMENT 'Data do inicio da partida.';

ALTER TABLE partidas MODIFY COLUMN data_fim DATE COMMENT 'Data do fim da missao.';

ALTER TABLE partidas MODIFY COLUMN hora_inicio TIME COMMENT 'Hora de inicio da partida.';

ALTER TABLE partidas MODIFY COLUMN hora_fim TIME COMMENT 'Hora do fim da partida.';

ALTER TABLE partidas MODIFY COLUMN pontuacao SMALLINT COMMENT 'Pontuacao da partida.';


/* Criando a tabela "personagens_niveis" */
CREATE TABLE personagens_niveis (
                codigo_niveis SMALLINT NOT NULL,
                codigo_jogos SMALLINT NOT NULL,
                codigo_personagens SMALLINT,
                PRIMARY KEY (codigo_niveis, codigo_jogos)
);

/* Inserindo comentários na tabela "personagens_niveis" */
ALTER TABLE personagens_niveis COMMENT 'Tabela criada pelo relacionamento N:N entre personagens e niveis.';

ALTER TABLE personagens_niveis MODIFY COLUMN codigo_niveis SMALLINT COMMENT 'Codigo do nivel.';

ALTER TABLE personagens_niveis MODIFY COLUMN codigo_jogos SMALLINT COMMENT 'Codigo do jogo.';

ALTER TABLE personagens_niveis MODIFY COLUMN codigo_personagens SMALLINT COMMENT 'Codigo do personagem.';


/* Criando a tabela "cenarios_niveis" */
CREATE TABLE cenarios_niveis (
                codigo_niveis SMALLINT NOT NULL,
                codigo_jogos SMALLINT NOT NULL,
                codigo_cenarios SMALLINT,
                PRIMARY KEY (codigo_niveis, codigo_jogos)
);

/* Inserindo comentários na tabela "cenarios_niveis" */
ALTER TABLE cenarios_niveis COMMENT 'Tabela criada pelo relacionamento N:N entre cenarios e niveis.';

ALTER TABLE cenarios_niveis MODIFY COLUMN codigo_niveis SMALLINT COMMENT 'Codigo do nivel.';

ALTER TABLE cenarios_niveis MODIFY COLUMN codigo_jogos SMALLINT COMMENT 'Codigo do jogo.';

ALTER TABLE cenarios_niveis MODIFY COLUMN codigo_cenarios SMALLINT COMMENT 'Codigo do cenario.';


/* ADICIONANDO FOREIGN KEYS NAS TABELAS */

/* Adicionando Foreign Key na tabela "imagem_fundo_configuracoes" */
ALTER TABLE imagem_fundo_configuracoes ADD CONSTRAINT imagem_fundo_imagem_fundo_configuracoes_fk
FOREIGN KEY (codigo_imagem_fundo)
REFERENCES imagem_fundo (codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* Adicionando Foreign Key na tabela "cores_configuracoes" */
ALTER TABLE cores_configuracoes ADD CONSTRAINT cores_cores_configuracoes_fk
FOREIGN KEY (codigo_cores)
REFERENCES cores (codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* Adicionando Foreign Key na tabela "cores_configuracoes" */
ALTER TABLE cores_configuracoes ADD CONSTRAINT configuracoes_cores_configuracoes_fk
FOREIGN KEY (codigo_configuracoes)
REFERENCES configuracoes (codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* Adicionando Foreign Key na tabela "imagem_fundo_configuracoes" */
ALTER TABLE imagem_fundo_configuracoes ADD CONSTRAINT configuracoes_imagem_fundo_configuracoes_fk
FOREIGN KEY (codigo_configuracoes)
REFERENCES configuracoes (codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* Adicionando Foreign Key na tabela "personalizacoes" */
ALTER TABLE personalizacoes ADD CONSTRAINT configuracoes_personalizacoes_fk
FOREIGN KEY (codigo_configuracoes)
REFERENCES configuracoes (codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* Adicionando Foreign Key na tabela "personalizacoes" */
ALTER TABLE personalizacoes ADD CONSTRAINT jogos_personalizacoes_fk
FOREIGN KEY (codigo_jogos)
REFERENCES jogos (codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* Adicionando Foreign Key na tabela "niveis" */
ALTER TABLE niveis ADD CONSTRAINT jogos_niveis_fk
FOREIGN KEY (codigo_jogos)
REFERENCES jogos (codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* Adicionando Foreign Key na tabela "composicoes" */
ALTER TABLE composicoes ADD CONSTRAINT objetos_composicoes_fk
FOREIGN KEY (codigo_objetos)
REFERENCES objetos (codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* Adicionando Foreign Key na tabela "trilhas_sonoras_niveis" */
ALTER TABLE trilhas_sonoras_niveis ADD CONSTRAINT trilhas_sonoras_trilhas_sonoras_niveis_fk
FOREIGN KEY (codigo_trilhas_sonoras)
REFERENCES trilhas_sonoras (codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* Adicionando Foreign Key na tabela "missoes_niveis" */
ALTER TABLE missoes_niveis ADD CONSTRAINT missoes_missoes_niveis_fk
FOREIGN KEY (codigo_missoes)
REFERENCES missoes (codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* Adicionando Foreign Key na tabela "partidas" */
ALTER TABLE partidas ADD CONSTRAINT jogadores_partidas_fk
FOREIGN KEY (codigo_jogadores)
REFERENCES jogadores (codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* Adicionando Foreign Key na tabela "personagens_niveis" */
ALTER TABLE personagens_niveis ADD CONSTRAINT personagens_personagens_niveis_fk
FOREIGN KEY (codigo_personagens)
REFERENCES personagens (codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* Adicionando Foreign Key na tabela "cenarios_niveis" */
ALTER TABLE cenarios_niveis ADD CONSTRAINT cenarios_cenarios_niveis_fk
FOREIGN KEY (codigo_cenarios)
REFERENCES cenarios (codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* Adicionando Foreign Key na tabela "cenarios_niveis" */
ALTER TABLE cenarios_niveis ADD CONSTRAINT niveis_cenarios_niveis_fk
FOREIGN KEY (codigo_niveis, codigo_jogos)
REFERENCES niveis (codigo, codigo_jogos)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* Adicionando Foreign Key na tabela "personagens_niveis" */
ALTER TABLE personagens_niveis ADD CONSTRAINT niveis_personagens_niveis_fk
FOREIGN KEY (codigo_niveis, codigo_jogos)
REFERENCES niveis (codigo, codigo_jogos)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* Adicionando Foreign Key na tabela "partidas" */
ALTER TABLE partidas ADD CONSTRAINT niveis_partidas_fk
FOREIGN KEY (codigo_niveis, codigo_jogos)
REFERENCES niveis (codigo, codigo_jogos)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* Adicionando Foreign Key na tabela "missoes_niveis" */
ALTER TABLE missoes_niveis ADD CONSTRAINT niveis_missoes_niveis_fk
FOREIGN KEY (codigo_niveis, codigo_jogos)
REFERENCES niveis (codigo, codigo_jogos)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* Adicionando Foreign Key na tabela "trilhas_sonoras_niveis" */
ALTER TABLE trilhas_sonoras_niveis ADD CONSTRAINT niveis_trilhas_sonoras_niveis_fk
FOREIGN KEY (codigo_niveis, codigo_jogos)
REFERENCES niveis (codigo, codigo_jogos)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* Adicionando Foreign Key na tabela "composicoes" */
ALTER TABLE composicoes ADD CONSTRAINT niveis_composicoes_fk
FOREIGN KEY (codigo_niveis, codigo_jogos)
REFERENCES niveis (codigo, codigo_jogos)
ON DELETE NO ACTION
ON UPDATE NO ACTION;


/* ADICIONANDO CONSTRAINTS EXTRAS */

ALTER TABLE configuracoes
ADD CONSTRAINT CHECK (brilho BETWEEN 0 AND 100);

ALTER TABLE trilhas_sonoras
ADD CONSTRAINT CHECK (valencia in ("positiva", "negativa", "neutra"));