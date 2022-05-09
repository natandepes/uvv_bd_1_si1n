-- -------------------------------------------------------------------------------------------------------------------------------------- --
-- A SQL se mantem praticamente universal para qualquer SGBD, porem, todas essas queries foram testadas e revisadas no PostgreSQL, se por --
-- acaso acontecer qualquer tipo de erro em relacao as queries, insisto para que tente executa-las pelo PostgreSQL. Obrigado.             --                                                     
-- -------------------------------------------------------------------------------------------------------------------------------------- --

-- --------- --
-- QUESTAO 1 --
-- --------- --

SELECT 
  numero_departamento AS departamento
, AVG(salario)        AS media_salarial
FROM funcionario
GROUP BY numero_departamento;




-- --------- --
-- QUESTAO 2 --
-- --------- --

SELECT 
  sexo
, AVG(salario) AS media_salarial
FROM funcionario
GROUP BY sexo;




-- --------- --
-- QUESTAO 3 --
-- --------- --

SELECT 
  nome_departamento                                                                     AS departamento
, CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome)                                 AS funcionario
, data_nascimento, DATE_PART('year', CURRENT_DATE) - DATE_PART('year', data_nascimento) AS idade
, salario
FROM funcionario        f
INNER JOIN departamento dp ON (f.numero_departamento = dp.numero_departamento)
ORDER BY departamento; -- Nao foi requerido mas ordenei assim para que ficasse mais organizado.




-- --------- --
-- QUESTAO 4 --
-- --------- --

 SELECT 
   CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome)                AS funcionario
 , DATE_PART('year', CURRENT_DATE) - DATE_PART('year', data_nascimento) AS idade
 , salario                                                              AS salario_atual
 
 , CASE  
        WHEN salario < 35000 THEN salario + salario * 20/100
        WHEN salario >= 35000 THEN salario + salario * 15/100
   END                                                                  AS salario_reajuste

FROM  funcionario;




-- --------- --
-- QUESTAO 5 --
-- --------- --

SELECT 
  nome_departamento AS departamento
  
  , CASE 
        WHEN dp.numero_departamento = 1 THEN 'Jorge'
        WHEN dp.numero_departamento = 4 THEN 'Jennifer'
        WHEN dp.numero_departamento = 5 THEN 'Fernando'
    END            AS gerente
 
, primeiro_nome    AS funcionario
, salario          AS salario_funcionario
FROM departamento      dp
INNER JOIN funcionario f ON (f.numero_departamento = dp.numero_departamento)
ORDER BY nome_departamento ASC, salario DESC;




-- --------- --
-- QUESTAO 6 --
-- --------- --

SELECT 
  CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome)                  AS funcionario
, numero_departamento                                                    AS departamento
, CONCAT(nome_dependente, ' ', ultimo_nome)                              AS dependente
, DATE_PART('year', CURRENT_DATE) - DATE_PART('year', d.data_nascimento) AS idade_dependente

, CASE 
       WHEN d.sexo = 'M' THEN 'Masculino'
       WHEN d.sexo = 'F' THEN 'Feminino'
  END                                                                    AS sexo_dependente
FROM funcionario      f
INNER JOIN dependente d ON (f.cpf = d.cpf_funcionario);




-- --------- --
-- QUESTAO 7 --
-- --------- --

SELECT DISTINCT 
 CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome) AS funcionario
, f. numero_departamento                               AS departamento
, salario
FROM funcionario           f
LEFT OUTER JOIN dependente d ON (f.cpf = d.cpf_funcionario)
WHERE cpf_funcionario IS NULL;




-- --------- --
-- QUESTAO 8 --
-- --------- --

SELECT 
  f.numero_departamento                                 AS departamento
, nome_projeto                                          AS projeto
, CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome) AS funcionario
, SUM(horas)                                            AS horas_por_projeto -- decidi realizar a somatoria para a tabela ficar mais legivel
FROM funcionario       f
INNER JOIN trabalha_em t ON (f.cpf = t.cpf_funcionario)
INNER JOIN projeto     p ON (p.numero_projeto = t.numero_projeto)
WHERE f.cpf = t.cpf_funcionario
GROUP BY departamento, projeto, funcionario 
ORDER BY funcionario;




-- --------- --
-- QUESTAO 9 --
-- --------- --

SELECT 
  nome_departamento AS departamento
, nome_projeto      AS projeto
, SUM(horas)        AS horas_somadas
FROM departamento      dp
INNER JOIN projeto     p ON (dp.numero_departamento = p.numero_departamento)
INNER JOIN trabalha_em t ON (p.numero_projeto = t.numero_projeto)
GROUP BY departamento, projeto 
ORDER BY departamento; -- novamente nao era obrigatorio organizar por ordem mas o fiz para mais facil leitura da tabela.




-- ---------------------------------------------------------------- --
-- A QUESTAO 10 ERA REPETIDA, TINHA O MESMO ENUNCIADO DA QUESTAO 1. --
-- ---------------------------------------------------------------- --




-- ---------- --
-- QUESTAO 11 --
-- ---------- --

SELECT DISTINCT 
  CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome) AS funcionario
, nome_projeto                                          AS projeto
, SUM(horas * 50)                                       AS valor_total
FROM funcionario       f
INNER JOIN projeto     p   ON (f.numero_departamento = p.numero_departamento)
INNER JOIN trabalha_em t   ON (p.numero_projeto = t.numero_projeto)
GROUP BY funcionario, projeto
ORDER BY funcionario;




-- ---------- --
-- QUESTAO 12 --
-- ---------- --

SELECT 
  nome_departamento AS departamento
, nome_projeto      AS projeto
, primeiro_nome     AS funcionario
FROM projeto            p
INNER JOIN departamento dp ON (p.numero_departamento = dp.numero_departamento)
INNER JOIN funcionario  f  ON (dp.numero_departamento = f.numero_departamento)
INNER JOIN trabalha_em  t  ON (p.numero_projeto = t.numero_projeto)
WHERE t.horas IS NULL OR t.horas = 0;



-- ---------- --
-- QUESTAO 13 --
-- ---------- --

SELECT 
  CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome)                AS pessoa
, sexo                                                                 AS sexo
, DATE_PART('year', CURRENT_DATE) - DATE_PART('year', data_nascimento) AS idade
FROM funcionario
UNION
SELECT CONCAT(nome_dependente, ' ', f.ultimo_nome)
, d.sexo
, DATE_PART('year', CURRENT_DATE) - DATE_PART('year', d.data_nascimento)
FROM dependente        d
INNER JOIN funcionario f ON (cpf_funcionario = cpf)
ORDER BY idade DESC;




-- ---------- --
-- QUESTAO 14 --
-- ---------- --

SELECT 
  nome_departamento AS departamento -- Optei colocar o nome do departamento para o relatorio ficar mais legivel.
, COUNT(cpf)        AS numero_de_funcionarios
FROM funcionario        f
INNER JOIN departamento dp ON (f.numero_departamento = dp.numero_departamento)
GROUP BY nome_departamento;



-- ---------- --
-- QUESTAO 15 --
-- ---------- --

SELECT 
  CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome) AS funcionario
, f.numero_departamento                                 AS departamento
, nome_projeto                                          AS projeto_alocado
FROM funcionario         f
 INNER JOIN departamento dp ON (f.numero_departamento = dp.numero_departamento)
  LEFT OUTER JOIN projeto p ON (dp.numero_departamento = p.numero_departamento) -- Por mais que todos os funcionarios neste esquema trabalhem em exemplos, foi pedido para incluir ate os funcionarios que nao trabalhassem, entao usei LEFT OUTER JOIN.
  ORDER BY funcionario; -- Nao foi requerido mas ordenei assim para que ficasse mais organizado.
