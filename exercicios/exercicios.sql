-- Lista de transações com apenas 1 ponto;
SELECT IdTransacao, QtdePontos FROM transacoes
WHERE QtdePontos = 1
LIMIT 10;

-- listar todos os pedidos no fim de semana
SELECT IdTransacao,
        strftime('%w',datetime(substr(DtCriacao,1,19))) AS diaSemana
FROM transacoes
WHERE diaSemana IN ('0','6')
LIMIT 10;



-- Lista de clientes com 0 (zero) pontos;
SELECT IdCliente, QtdePontos FROM clientes
WHERE QtdePontos = 0
LIMIT 10;

-- Lista de clientes com 100 a 200 pontos (inclusive ambos);
SELECT IdCliente, QtdePontos FROM clientes
WHERE QtdePontos BETWEEN 100 AND 200;
-- WHERE QtdePontos >= 100 AND QtdePontos <= 200
--LIMIT 10;

-- Lista de produtos com nome que começa com “Venda de”;
SELECT DescProduto FROM produtos
WHERE DescProduto LIKE 'Venda de%';

-- Lista de produtos com nome que termina com “Lover”;
SELECT * FROM produtos
WHERE DescProduto LIKE '%Lover';

-- Lista de produtos que são “chapéu”;
SELECT DescProduto FROM produtos
WHERE DescProduto LIKE '%Chapéu%';

-- Lista de transações com o produto “Resgatar Ponei”;
SELECT * FROM produtos
WHERE DescProduto LIKE '%Resgatar Ponei%';

SELECT * FROM transacao_produto
WHERE IdProduto = 15;

-- Listar todas as transações adicionando uma coluna nova sinalizando “alto”, “médio” e “baixo” para o valor dos pontos [<10 ; <500; >=500]
SELECT *,
		CASE
			WHEN QtdePontos < 10 THEN 'Baixo'
			WHEN QtdePontos < 500 THEN 'Médio'
			ELSE 'Alto'
		END as Grupos


FROM transacoes
LIMIT 10;

-- Quantos clientes tem email cadastrado?
SELECT sum(FlEmail)

FROM clientes;

--Qual cliente juntou mais pontos positivos em 2025-05?
SELECT IdCliente,
		sum(QtdePontos) as TotalPts

FROM transacoes

WHERE DtCriacao >= '2025-05-01'
AND DtCriacao < '2025-06-01'
AND QtdePontos > 0

GROUP BY IdCliente

ORDER BY sum(QtdePontos) DESC
LIMIT 1;

-- Qual cliente fez mais transações no ano de 2024?

SELECT IdCliente,
		count(DISTINCT IdTransacao) as TotalTransacoes

FROM transacoes

WHERE DtCriacao >= '2024-01-01'
AND DtCriacao < '2025-01-01'


GROUP BY IdCliente

ORDER BY count(IdTransacao) DESC;

-- Quantos produtos são de rpg?

SELECT count(*)

FROM produtos

WHERE DescCateogriaProduto = 'rpg';

SELECT DescCateogriaProduto,
		count(*)

FROM produtos

GROUP BY DescCateogriaProduto;

-- Qual o valor médio de pontos positivos por dia?
SELECT sum(QtdePontos) as totalPts,
		count(DISTINCT substr(DtCriacao, 1, 10)) as qtdDiasUnicos,
		sum(QtdePontos) / count(DISTINCT substr(DtCriacao, 1, 10)) as avgPontosDia

FROM transacoes

WHERE QtdePontos > 0;

SELECT substr(DtCriacao, 1, 10) as dtDia,
		avg(QtdePontos) as avgPontosDia

FROM transacoes

WHERE QtdePontos > 0
-- primeira coluna do select = 1
GROUP BY 1 
ORDER BY 1

LIMIT 1;

-- Qual dia da semana quem mais pedidos em 2025?
SELECT	
		strftime('%w', substr(DtCriacao, 1, 10)) as diaSemana,
		count(DISTINCT IdTransacao) as QtdTransacoes
		

FROM transacoes

WHERE substr(DtCriacao, 1, 4) = '2025'

GROUP BY 1

-- Qual o produto mais transacionado?

SELECT IdProduto,
	--	count(*)
		sum(QtdeProduto) as qtdProdutosSum

FROM transacao_produto

GROUP BY IdProduto
ORDER BY count(*) DESC

LIMIT 1;

-- Qual o produto com mais pontos transacionados?

SELECT IdProduto,
		sum(VlProduto * QtdeProduto) AS totalPontos,
		sum(QtdeProduto) as qtdVendas

FROM transacao_produto

GROUP BY IdProduto
ORDER BY sum(VlProduto)  DESC
