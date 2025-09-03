-- Saldo de pontos acumulado de cada usuário
WITH tb_cliente_dia as (

    SELECT IdCliente,
            substr(DtCriacao,1,10) as dtDia,
            sum(QtdePontos) as totalPts,
            sum(CASE WHEN QtdePontos > 0 THEN QtdePontos ELSE 0 END) as pontosPos

    FROM transacoes

    GROUP BY IdCliente, dtDia
)

SELECT *,
        sum(totalPts) OVER (PARTITION BY IdCliente ORDER BY dtDia) as saldoPts,
        sum(pontosPos) OVER (PARTITION BY IdCliente ORDER BY dtDia) as saldoPts

FROM tb_cliente_dia