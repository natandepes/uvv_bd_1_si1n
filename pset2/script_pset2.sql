-- Questao 1

SELECT AVG(salario) AS media_salario_departamento_1
FROM funcionario
WHERE numero_departamento = 1;

SELECT AVG(salario) AS media_salario_departamento_4
FROM funcionario
WHERE numero_departamento = 4;

SELECT AVG(salario) AS media_salario_departamento_5
FROM funcionario
WHERE numero_departamento = 5;




-- Questao 2

SELECT AVG(salario) AS media_salarial_homens
FROM funcionario
WHERE sexo = 'M';

SELECT AVG(salario) AS media_salarial_mulheres
FROM funcionario
WHERE sexo = 'F';




-- Questao 3

SELECT nome_departamento, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, DATE_PART('year', CURRENT_DATE) - DATE_PART('year', data_nascimento) AS idade, salario
FROM funcionario f
INNER JOIN departamento dp ON (f.numero_departamento = dp.numero_departamento);




-- Questao 4

 SELECT primeiro_nome, nome_meio, ultimo_nome, DATE_PART('year', CURRENT_DATE) - DATE_PART('year', data_nascimento) AS idade, salario,
CASE  WHEN salario < 35000 THEN salario + salario * 20/100
      WHEN salario >= 35000 THEN salario + salario * 15/100
END AS salario_reajuste
FROM  funcionario;




-- Questao 5 (NAO ACABADA)!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

SELECT nome_departamento,
CASE WHEN dp.cpf_gerente = cpf THEN primeiro_nome
END AS nome_gerente,
primeiro_nome AS nome_funcionario, salario
FROM departamento dp
INNER JOIN funcionario f ON (f.numero_departamento = dp.numero_departamento);




-- Questao 6

SELECT primeiro_nome, nome_meio, ultimo_nome, numero_departamento, nome_dependente, DATE_PART('year', CURRENT_DATE) - DATE_PART('year', d.data_nascimento) AS idade_dependente,
CASE WHEN d.sexo = 'M' THEN 'Masculino'
     WHEN d.sexo = 'F' THEN 'Feminino'
END AS sexo_dependente
FROM funcionario f
INNER JOIN dependente d ON (f.cpf = d.cpf_funcionario);




-- Questao 7

SELECT DISTINCT primeiro_nome, nome_meio, ultimo_nome, f.numero_departamento, salario
FROM funcionario f, dependente
WHERE NOT cpf = cpf_funcionario;




-- Questao 8


SELECT DISTINCT f.numero_departamento, nome_projeto, primeiro_nome, nome_meio, ultimo_nome, SUM(horas) AS horas_por_projeto -- decidi realizar a somatoria para a tabela ficar mais legivel
FROM funcionario f
INNER JOIN projeto p ON (f.numero_departamento = p.numero_departamento)
INNER JOIN trabalha_em t ON (cpf = t.cpf_funcionario)
GROUP BY f.numero_departamento, nome_projeto, primeiro_nome, nome_meio, ultimo_nome -- o SUM obriga o uso da clausula GROUP BY ou de uma subquery
ORDER BY primeiro_nome; -- sem ordem o relatorio ficava muito confuso, entao por mais que nao fosse requerido na questao decidi colocar.




-- Questao 9

SELECT nome_departamento, nome_projeto, SUM(horas) AS soma_horas
FROM departamento dp
INNER JOIN projeto p ON (dp.numero_departamento = p.numero_departamento)
INNER JOIN trabalha_em t ON (p.numero_projeto = t.numero_projeto)
GROUP BY nome_departamento, nome_projeto 
ORDER BY nome_departamento; -- novamento nao era obrigatorio organizar por ordem mas o fiz para mais facil leitura da tabela.




-- ---------------------------------------------------------------- --
-- A QUESTAO 10 ERA REPETIDA, TINHA O MESMO ENUNCIADO DA QUESTAO 1. --
-- ---------------------------------------------------------------- --




-- Questao 11

SELECT DISTINCT primeiro_nome, nome_meio, ultimo_nome, nome_projeto, SUM(horas * 50) AS valor_total
FROM funcionario f
INNER JOIN projeto p ON (f.numero_departamento = p.numero_departamento)
INNER JOIN trabalha_em t ON (p.numero_projeto = t.numero_projeto)
GROUP BY primeiro_nome, nome_meio, ultimo_nome, nome_projeto
ORDER BY primeiro_nome;




-- Questao 12

SELECT nome_departamento, nome_projeto, primeiro_nome AS nome_funcionario
FROM projeto p
INNER JOIN departamento d ON (p.numero_departamento = d.numero_departamento)
INNER JOIN funcionario f ON (p.numero_departamento = f.numero_departamento)
INNER JOIN trabalha_em t ON (p.numero_projeto = t.numero_projeto)
WHERE t.horas = 0;
