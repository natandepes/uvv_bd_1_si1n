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
