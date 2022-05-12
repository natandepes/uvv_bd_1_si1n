-- -------------------------------------------------------------------------------------------------------------------------------------- --
-- A SQL se mantem praticamente universal para qualquer SGBD, porem, todas essas queries foram testadas e revisadas no PostgreSQL, se por --
-- acaso acontecer qualquer tipo de erro em relacao as queries, insisto para que tente executa-las pelo PostgreSQL. Obrigado.             --                                                     
-- -------------------------------------------------------------------------------------------------------------------------------------- --

-- ----------------------------------------------------------------------------- --
-- QUESTÃO 01: prepare um relatório que mostre a média salarial dos funcionários --
-- de cada departamento.                                                         --
-- ----------------------------------------------------------------------------- --
 

SELECT 
  numero_departamento AS departamento
, AVG(salario)        AS media_salarial
FROM funcionario
GROUP BY numero_departamento;




-- ----------------------------------------------------------------------------- --
-- QUESTÃO 02: prepare um relatório que mostre a média salarial dos homens e das --
-- mulheres.                                                                     --
-- ----------------------------------------------------------------------------- --

SELECT 
  sexo
, AVG(salario) AS media_salarial
FROM funcionario
GROUP BY sexo;




-- ------------------------------------------------------------------------------- --
-- QUESTÃO 03: prepare um relatório que liste o nome dos departamentos e, para     --
-- cada departamento, inclua as seguintes informações de seus funcionários: o nome --
-- completo, a data de nascimento, a idade em anos completos e o salário.          --
-- ------------------------------------------------------------------------------- --

SELECT 
  nome_departamento                                                                     AS departamento
, CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome)                                 AS funcionario
, data_nascimento, DATE_PART('year', CURRENT_DATE) - DATE_PART('year', data_nascimento) AS idade
, salario
FROM funcionario        f
INNER JOIN departamento dp ON (f.numero_departamento = dp.numero_departamento)
ORDER BY departamento; -- Nao foi requerido mas ordenei assim para que ficasse mais organizado.




-- ------------------------------------------------------------------------------------------------------------------------------------ --
-- QUESTÃO 04: prepare um relatório que mostre o nome completo dos funcionários, a idade em anos completos, o salário atual e o salário --
-- com um reajuste que obedece ao seguinte critério: se o salário atual do funcionário é inferior a 35.000 o                            --                                 
-- reajuste deve ser de 20%, e se o salário atual do funcionário for igual ou superior a 35.000 o reajuste deve ser de 15%.             --                                                                                                                                                       
-- ------------------------------------------------------------------------------------------------------------------------------------ --

 SELECT 
   CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome)                AS funcionario
 , DATE_PART('year', CURRENT_DATE) - DATE_PART('year', data_nascimento) AS idade
 , salario                                                              AS salario_atual
 
 , CASE  
        WHEN salario < 35000 THEN salario + salario * 20/100
        WHEN salario >= 35000 THEN salario + salario * 15/100
   END                                                                  AS salario_reajuste

FROM  funcionario;




-- ------------------------------------------------------------------------------------ --
-- QUESTÃO 05: prepare um relatório que liste, para cada departamento, o nome           --
-- do gerente e o nome dos funcionários. Ordene esse relatório por nome do departamento --
-- (em ordem crescente) e por salário dos funcionários (em ordem decrescente).          --
-- ------------------------------------------------------------------------------------ --

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




-- --------------------------------------------------------------------------------- --
-- QUESTÃO 06: prepare um relatório que mostre o nome completo dos funcionários      --
-- que têm dependentes, o departamento onde eles trabalham e, para cada funcionário, --
-- também liste o nome completo dos dependentes, a idade em anos de cada             --
-- dependente e o sexo (o sexo NÃO DEVE aparecer como M ou F, deve aparecer          --
-- como “Masculino” ou “Feminino”).                                                  --
-- --------------------------------------------------------------------------------- --

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




-- -------------------------------------------------------------------------- --
-- QUESTÃO 07: prepare um relatório que mostre, para cada funcionário que NÃO --
-- TEM dependente, seu nome completo, departamento e salário.                 --
-- -------------------------------------------------------------------------- --

SELECT DISTINCT 
 CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome) AS funcionario
, f. numero_departamento                               AS departamento
, salario
FROM funcionario           f
LEFT OUTER JOIN dependente d ON (f.cpf = d.cpf_funcionario)
WHERE cpf_funcionario IS NULL;




-- -------------------------------------------------------------------------------- --
-- QUESTÃO 08: prepare um relatório que mostre, para cada departamento, os projetos -- 
-- desse departamento e o nome completo dos funcionários que estão alocados         --
-- em cada projeto. Além disso inclua o número de horas trabalhadas por             --
-- cada funcionário, em cada projeto.                                               --
-- -------------------------------------------------------------------------------- --

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




-- ----------------------------------------------------------------------------------- --
-- QUESTÃO 09: prepare um relatório que mostre a soma total das horas de cada          --
-- projeto em cada departamento. Obs.: o relatório deve exibir o nome do departamento, --
-- o nome do projeto e a soma total das horas.                                         --
-- ----------------------------------------------------------------------------------- --

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




-- ------------------------------------------------------------------------------- --
-- QUESTÃO 11: considerando que o valor pago por hora trabalhada em um projeto     --
-- é de 50 reais, prepare um relatório que mostre o nome completo do funcionário,  --
-- o nome do projeto e o valor total que o funcionário receberá referente às horas --
-- trabalhadas naquele projeto.                                                    --
-- ------------------------------------------------------------------------------- --

SELECT DISTINCT 
  CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome) AS funcionario
, nome_projeto                                          AS projeto
, SUM(horas * 50)                                       AS valor_total
FROM funcionario       f
INNER JOIN projeto     p   ON (f.numero_departamento = p.numero_departamento)
INNER JOIN trabalha_em t   ON (p.numero_projeto = t.numero_projeto)
GROUP BY funcionario, projeto
ORDER BY funcionario;




-- ------------------------------------------------------------------------------------- --
-- QUESTÃO 12: seu chefe está verificando as horas trabalhadas pelos funcionários        --
-- nos projetos e percebeu que alguns funcionários, mesmo estando alocadas à algum       --
-- projeto, não registraram nenhuma hora trabalhada. Sua tarefa é preparar um relatório  -- 
-- que liste o nome do departamento, o nome do projeto e o nome dos funcionários         --
-- que, mesmo estando alocados a algum projeto, não registraram nenhuma hora trabalhada. --
-- ------------------------------------------------------------------------------------- --

SELECT 
  nome_departamento AS departamento
, nome_projeto      AS projeto
, primeiro_nome     AS funcionario
FROM projeto            p
INNER JOIN departamento dp ON (p.numero_departamento = dp.numero_departamento)
INNER JOIN funcionario  f  ON (dp.numero_departamento = f.numero_departamento)
INNER JOIN trabalha_em  t  ON (p.numero_projeto = t.numero_projeto)
WHERE t.horas IS NULL OR t.horas = 0;



-- ------------------------------------------------------------------------------------ --
-- QUESTÃO 13: durante o natal deste ano a empresa irá presentear todos os funcionários --
-- e todos os dependentes (sim, a empresa vai dar um presente para cada                 --
-- funcionário e um presente para cada dependente de cada funcionário) e pediu para     --
-- que você preparasse um relatório que listasse o nome completo das pessoas a serem    --
-- presenteadas (funcionários e dependentes), o sexo e a idade em anos completos        --
-- (para poder comprar um presente adequado). Esse relatório deve estar ordenado        -- 
-- pela idade em anos completos, de forma decrescente.                                  --
-- ------------------------------------------------------------------------------------ --

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




-- -------------------------------------------------------------------------------------- --
-- QUESTÃO 14: prepare um relatório que exiba quantos funcionários cada departamento tem. --
-- -------------------------------------------------------------------------------------- --

SELECT 
  nome_departamento AS departamento -- Optei colocar o nome do departamento para o relatorio ficar mais legivel.
, COUNT(cpf)        AS numero_de_funcionarios
FROM funcionario        f
INNER JOIN departamento dp ON (f.numero_departamento = dp.numero_departamento)
GROUP BY nome_departamento;



-- ----------------------------------------------------------------------------- --
-- QUESTÃO 15: como um funcionário pode estar alocado em mais de um projeto,     --
-- prepare um relatório que exiba o nome completo do funcionário, o departamento --
-- desse funcionário e o nome dos projetos em que cada funcionário está alocado. --
-- Atenção: se houver algum funcionário que não está alocado em nenhum projeto,  --
-- o nome completo e o departamento também devem aparecer no relatório.          --
-- ----------------------------------------------------------------------------- --

SELECT 
  CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome) AS funcionario
, f.numero_departamento                                 AS departamento
, nome_projeto                                          AS projeto_alocado
FROM funcionario         f
 INNER JOIN departamento dp ON (f.numero_departamento = dp.numero_departamento)
  LEFT OUTER JOIN projeto p ON (dp.numero_departamento = p.numero_departamento) -- Por mais que todos os funcionarios neste esquema trabalhem em exemplos, foi pedido para incluir ate os funcionarios que nao trabalhassem, entao usei LEFT OUTER JOIN.
  ORDER BY funcionario; -- Nao foi requerido mas ordenei assim para que ficasse mais organizado.
