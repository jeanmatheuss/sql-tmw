-- SELECT  IdProduto,
--         count(*) 

-- FROM transacao_produto

-- GROUP BY IdProduto

SELECT IdCliente,
        sum(QtdePontos) as somaQtdPontos,
        count(IdTransacao) as QtdTransacao


FROM transacoes

WHERE DtCriacao >= '2025-07-01'
AND DtCriacao < '2025-08-01'

GROUP BY IdCliente
-- having filtra pós agrupamento
HAVING sum(QtdePontos) >= 4000 

ORDER BY somaQtdPontos DESC