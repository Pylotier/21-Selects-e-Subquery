USE Projeto
SELECT * FROM Projects
-- - Fazer uma consulta que retorne id, nome, email, username e caso a senha seja diferente de
-- 123mudar, mostrar ******** (8 asteriscos), caso contrário, mostrar a própria senha.
SELECT u.Name, u.Email, u.Username,
CASE
 WHEN u.Password = '123mudar' THEN '********'
ELSE u.Password
 END AS senha FROM Users AS u

-- Considerando que o projeto 10001 durou 15 dias, fazer uma consulta que mostre o nome do
-- projeto, descrição, data, data_final do projeto realizado por usuário de e-mail
-- aparecido@empresa.com
SELECT proj.Name, proj.Description, proj.Date, DATEADD(DAY, 15, proj.Date) AS  Date_Final FROM Users_has_Projects AS upro
INNER JOIN Users AS u
ON u.ID = upro.users_id
INNER JOIN Projects AS proj
ON proj.ID = upro.projects_id
WHERE u.email = 'aparecido@empresa.com' AND proj.ID = '10001'

-- Fazer uma consulta que retorne o nome e o email dos usuários que estão envolvidos no
-- projeto de nome Auditoria
SELECT u.name, u.email FROM Users AS u
INNER JOIN Users_has_Projects AS upro
ON u.ID = upro.users_id
INNER JOIN Projects AS proj
ON proj.ID = upro.projects_id
WHERE proj.Name = 'Auditoria'

-- - Considerando que o custo diário do projeto, cujo nome tem o termo Manutenção, é de 79.85
-- e ele deve finalizar 16/09/2014, consultar, nome, descrição, data, data_final e custo_total do
-- projeto
SELECT proj.name AS Nome, proj.Description AS Descricao, proj.date AS DATA, 
DATEADD(DAY, DATEDIFF(DAY, proj.date, '16/09/2014'), proj.date) AS Data_Final, DATEDIFF(DAY, proj.date, '16/09/2014')*79.85 AS Custo_Final
FROM Projects AS proj