-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------- -- 
-- Fui orientado que a SQL se mantem universal para qualquer SGBD, porem em caso de algum problema, todas essas queries foram testadas e revisadas no PostgreSQL, se por --
-- acaso acontecer qualquer tipo de erro em relacao as queries, insisto para que tente executa-las pelo PostgreSQL. Obrigado.                                            --                                                     --
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------- --


-- Questao 1

SELECT numero_departamento AS departamento
, AVG(salario)             AS media_salarial
FROM funcionario
GROUP BY numero_departamento;




-- Questao 2

SELECT sexo
, AVG(salario) AS media_salarial
FROM funcionario
GROUP BY sexo;




-- Questao 3

SELECT nome_departamento
, CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome)                                 AS nome_completo_funcionario
, data_nascimento, DATE_PART('year', CURRENT_DATE) - DATE_PART('year', data_nascimento) AS idade
, salario
FROM funcionario        f
INNER JOIN departamento dp ON (f.numero_departamento = dp.numero_departamento)
ORDER BY nome_departamento; -- Nao foi requerido mas ordenei assim para que ficasse mais organizado.




-- Questao 4

 SELECT CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome)           AS nome_completo_funcionario
 , DATE_PART('year', CURRENT_DATE) - DATE_PART('year', data_nascimento) AS idade
 , salario                                                              AS salario_atual
 ,  CASE  WHEN salario < 35000 THEN salario + salario * 20/100
          WHEN salario >= 35000 THEN salario + salario * 15/100
END                                                                     AS salario_reajuste
FROM  funcionario;




-- Questao 5 (NAO ACABADA)!!!!!!!!!!!!! (GAMBIARRADA)

SELECT nome_departamento,
CASE WHEN dp.numero_departamento = 1 THEN 'Jorge'
     WHEN dp.numero_departamento = 4 THEN 'Jennifer'
     WHEN dp.numero_departamento = 5 Then 'Fernando'
END                                        AS nome_gerente
, primeiro_nome                            AS nome_funcionario
, salario                                  AS salario_funcionario
FROM departamento      dp
INNER JOIN funcionario f ON (f.numero_departamento = dp.numero_departamento)
ORDER BY nome_departamento ASC, salario_funcionario DESC;




-- Questao 6

SELECT CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome)             AS nome_completo_funcionario
, numero_departamento                                                    AS departamento
, nome_dependente
, DATE_PART('year', CURRENT_DATE) - DATE_PART('year', d.data_nascimento) AS idade_dependente
, CASE WHEN d.sexo = 'M' THEN 'Masculino'
       WHEN d.sexo = 'F' THEN 'Feminino'
END                                                                      AS sexo_dependente
FROM funcionario      f
INNER JOIN dependente d ON (f.cpf = d.cpf_funcionario);




-- Questao 7

SELECT DISTINCT CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome) AS nome_completo_funcionario
, f.numero_departamento                                               AS departamento
, salario
FROM funcionario f, dependente
WHERE NOT cpf = cpf_funcionario;




-- Questao 8

SELECT DISTINCT f.numero_departamento                   AS departamento
, nome_projeto
, CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome) AS nome_completo_funcionario
, SUM(horas)                                            AS horas_por_projeto -- decidi realizar a somatoria para a tabela ficar mais legivel
FROM funcionario       f
INNER JOIN projeto     p ON (f.numero_departamento = p.numero_departamento)
INNER JOIN trabalha_em t ON (cpf = t.cpf_funcionario)
GROUP BY f.numero_departamento, nome_projeto, nome_completo_funcionario, ultimo_nome -- o SUM obriga o uso da clausula GROUP BY ou de uma subquery.
ORDER BY nome_completo_funcionario; -- sem ordem o relatorio ficava muito confuso, entao por mais que nao fosse requerido na questao decidi colocar.




-- Questao 9

SELECT nome_departamento, nome_projeto, SUM(horas) AS soma_horas
FROM departamento      dp
INNER JOIN projeto     p ON (dp.numero_departamento = p.numero_departamento)
INNER JOIN trabalha_em t ON (p.numero_projeto = t.numero_projeto)
GROUP BY nome_departamento, nome_projeto 
ORDER BY nome_departamento; -- novamente nao era obrigatorio organizar por ordem mas o fiz para mais facil leitura da tabela.




-- ---------------------------------------------------------------- --
-- A QUESTAO 10 ERA REPETIDA, TINHA O MESMO ENUNCIADO DA QUESTAO 1. --
-- ---------------------------------------------------------------- --




-- Questao 11

SELECT DISTINCT CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome) AS nome_completo_funcionario
, nome_projeto
, SUM(horas * 50)                                                     AS valor_total
FROM funcionario       f
INNER JOIN projeto     p   ON (f.numero_departamento = p.numero_departamento)
INNER JOIN trabalha_em t   ON (p.numero_projeto = t.numero_projeto)
GROUP BY nome_completo_funcionario, nome_projeto
ORDER BY nome_completo_funcionario;




-- Questao 12

SELECT nome_departamento, nome_projeto, primeiro_nome AS nome_funcionario
FROM projeto            p
INNER JOIN departamento dp ON (p.numero_departamento = dp.numero_departamento)
INNER JOIN funcionario  f  ON (p.numero_departamento = f.numero_departamento)
INNER JOIN trabalha_em  t  ON (p.numero_projeto = t.numero_projeto)
WHERE t.horas = 0;



-- Questao 13

SELECT CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome)                                  AS nome_completo_pessoa
, sexo 
, DATE_PART('year', CURRENT_DATE) - DATE_PART('year', data_nascimento)                        AS idade
FROM funcionario
UNION
SELECT (nome_dependente)
, sexo 
, DATE_PART('year', CURRENT_DATE) - DATE_PART('year', data_nascimento)                        AS idade
FROM dependente
ORDER BY idade DESC;




-- Questao 14

SELECT numero_departamento AS departamento
, COUNT(cpf)               AS numero_de_funcionarios
FROM funcionario
GROUP BY departamento;




-- Questao 15

SELECT CONCAT(primeiro_nome,' ', nome_meio,' ', ultimo_nome)   AS nome_completo_funcionario
, f.numero_departamento                                        AS departamento
, nome_projeto                                                 AS nome_projeto_alocado
FROM funcionario        f
LEFT OUTER JOIN projeto p ON (f.numero_departamento = p.numero_departamento) -- Por mais que todos os funcionarios neste esquema trabalhem em exemplos, foi pedido para incluir ate os funcionarios que nao trabalhassem, entao usei LEFT OUTER JOIN.
ORDER BY nome_completo_funcionario; -- Nao foi requerido mas ordenei assim para que ficasse mais organizado.
