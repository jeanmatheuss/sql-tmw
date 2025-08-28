SELECT 
        sum(QtdePontos),
        
        sum(CASE 
            WHEN QtdePontos > 0 THEN QtdePontos 
            END) AS qtddePontosPositivos,
        sum(CASE
            WHEN QtdePontos < 0 THEN QtdePontos
            ELSE 0
            END) as qtddePontoNegativos,
        count(CASE
            WHEN QtdePontos < 0 THEN QtdePontos
            END) as QtdPontosNegativos

FROM transacoes

WHERE DtCriacao >= '2025-07-01'
AND DtCriacao < '2025-08-01'
