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
			WHEN QtdePontos <= 10 THEN 'Baixo'
			WHEN QtdePontos < 500 THEN 'Médio'
			ELSE 'Alto'
		END as Grupos


FROM transacoes;
