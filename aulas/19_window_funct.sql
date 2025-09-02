WITH tb_cliente_dia as (
    SELECT IdCliente,
            substr(DtCriacao, 1,10) as dtDia,
            count(DISTINCT IdTransacao) as qtdTransacao

    FROM transacoes

    WHERE DtCriacao >= '2025-08-25'
    AND DtCriacao < '2025-08-30'

    GROUP BY IdCliente, dtDia

),

tb_lag as (

    SELECT *,
        sum(qtdTransacao) OVER (PARTITION BY IdCliente ORDER BY dtDia) as acum,
        lag(qtdTransacao) OVER (PARTITION BY IdCliente ORDER BY dtDia) as lag

    FROM tb_cliente_dia
)

SELECT *,
        1.*qtdTRansacao / lag

FROM tb_lag