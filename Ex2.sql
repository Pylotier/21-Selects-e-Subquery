USE Locadora_DVD
GO

-- 1) Fazer uma consulta que retorne ID, Ano, nome do Filme (Caso o nome do filme tenha
-- mais de 10 caracteres, para caber no campo da tela, mostrar os 10 primeiros
-- caracteres, seguidos de reticências ...) dos filmes cujos DVDs foram fabricados depois
-- de 01/01/2020
SELECT f.id, f.ano, 
CASE
 WHEN LEN(f.nome) > 10 THEN SUBSTRING(f.nome, 1, 10) + '...'
END AS Nome FROM Filme AS f INNER JOIN DVD
ON f.ID = DVD.FilmeID
WHERE DVD.Data_fabricacao > '01/01/2020'

-- 2) Fazer uma consulta que retorne num, data_fabricacao, qtd_meses_desde_fabricacao
-- (Quantos meses desde que o dvd foi fabricado até hoje) do filme Interestelar
SELECT f.ID, DVD.Data_fabricacao, DATEDIFF(MONTH, DVD.Data_fabricacao, GETDATE()) AS qtd_meses_desde_fabricacao
FROM Filme AS f INNER JOIN DVD
ON f.ID = DVD.FilmeID
WHERE f.Nome = 'Interestelar'

-- 3) Fazer uma consulta que retorne num_dvd, data_locacao, data_devolucao,
-- dias_alugado(Total de dias que o dvd ficou alugado) e valor das locações da cliente que
-- tem, no nome, o termo Rosa 
SELECT DVD.Num, DVD.Data_fabricacao, loc.data_locacao, loc.data_devolucao, DATEDIFF(DAY, loc.data_locacao, loc.data_devolucao) AS dias_alugado, loc.Valor FROM Locacao AS loc
INNER JOIN DVD
ON DVD.Num = loc.DVDNum
INNER JOIN Cliente AS cli
ON cli.Num_cadastro = loc.ClienteNum_cadastro
WHERE cli.Nome LIKE '%Rosa%'

-- 4) Nome, endereço_completo (logradouro e número concatenados), cep (formato
-- XXXXX-XXX) dos clientes que alugaram DVD de num 10002.
SELECT cli.Nome, cli.Logradouro + ' ' + CAST(cli.Num AS VARCHAR(5)) AS Endereco, 
SUBSTRING(cli.CEP, 1, 5) + '-' + SUBSTRING(cli.CEP, 6, LEN(cli.CEP)) AS CEP
FROM Cliente AS cli
