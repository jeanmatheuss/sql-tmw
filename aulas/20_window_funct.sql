-- de quanto em quanto tempo as pessoas voltam
WITH cliente_dia as (

    SELECT 
            DISTINCT
            IdCliente,
            substr(DtCriacao,1,10) as dtDia

    FROM transacoes

    WHERE substr(DtCriacao,1,4) = '2025'

    order BY IdCliente, dtDia
),

tb_lag as (

    SELECT *,
            lag(dtDia) OVER (PARTITION BY IdCliente ORDER BY dtDia) as lagDia
    FROM cliente_dia
),

tb_diff_dt as (

    SELECT *,
            julianday(dtDia) - julianday(lagDia) as dtDiff

    FROM tb_lag
),

avg_cliente as (

    SELECT IdCliente,
            avg(dtDiff) as avgDia
    FROM tb_diff_dt
    GROUP BY IdCliente
)

SELECT avg(avgDia) FROM avg_cliente