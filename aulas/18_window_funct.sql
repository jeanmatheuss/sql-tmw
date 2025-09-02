WITH tb_sumario_dias as (

SELECT substr(DtCriacao, 1,10) as dtDia,
        count(DISTINCT IdTransacao) as qtdTransacao

FROM transacoes

WHERE DtCriacao >= '2025-08-25'
AND DtCriacao < '2025-08-30'

GROUP BY dtDia
)

SELECT *,
        sum(qtdTransacao) OVER (ORDER BY dtDia) as qtdeTransacaoAcum    

FROM tb_sumario_dias