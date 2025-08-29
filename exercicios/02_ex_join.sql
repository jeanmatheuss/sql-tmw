-- Qual categoria tem mais produtos vendidos?

-- SELECT count(t1.IdTransacao),
--         t2.DescCateogriaProduto

-- FROM transacao_produto as t1

-- LEFT JOIN produtos as t2
-- ON t1.IdProduto = t2.IdProduto

-- GROUP BY t2.DescCateogriaProduto
-- ORDER BY count(t1.IdTransacao) DESC;

-- Em 2024, quantas transações de Lovers tivemos?
-- SELECT count(DISTINCT t1.IdTransacao),
--         -- t1.IdCliente,
--         -- t2.IdProduto,
--         t3.DescCateogriaProduto

-- FROM transacoes as t1

-- LEFT JOIN transacao_produto as t2
-- ON t1.IdTransacao = t2.IdTransacao

-- LEFT JOIN produtos as t3
-- on t2.IdProduto = t3.IdProduto

-- WHERE t1.DtCriacao >= '2024-01-01'
-- AND t1.DtCriacao < '2025-01-01'
-- -- AND t3.DescCateogriaProduto = 'lovers'

-- GROUP BY t3.DescCateogriaProduto
-- HAVING count(DISTINCT t1.IdTransacao) < 1000

-- ORDER BY count(DISTINCT t1.IdTransacao) DESC;


-- Qual mês tivemos mais lista de presença assinada?
-- SELECT 
--         substr(t1.DtCriacao, 1, 7) as anoMes,
--         count(DISTINCT t1.IdTransacao) as qtdeTransacoes

-- FROM transacoes as t1

-- LEFT JOIN transacao_produto as t2
-- ON t1.IdTransacao = t2.IdTransacao

-- LEFT JOIN produtos as t3
-- ON t2.IdProduto = t3.IdProduto

-- WHERE t3.DescProduto = 'Lista de presença'

-- GROUP BY substr(t1.DtCriacao, 1, 7)
-- ORDER BY qtdeTransacoes DESC;

-- Qual o total de pontos trocados no Stream Elements em Junho de 2025?

SELECT sum(t2.VlProduto),
        t3.DescCateogriaProduto

FROM transacoes as t1

LEFT JOIN transacao_produto as t2
ON t1.IdTransacao = t2.IdTransacao

LEFT JOIN produtos as t3
ON t2.IdProduto = t3.IdProduto

WHERE t3.IdProduto IN ('14','17')
AND t2.VlProduto > 0
GROUP BY t3.IdProduto

