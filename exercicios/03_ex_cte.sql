-- Quem iniciou o curso no primeiro dia, em média assistiu quantas aulas?
WITH tb_prim_dia AS (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) = '2025-08-25'
),

tb_dias_curso AS (
    SELECT DISTINCT
        IdCliente, 
        substr(DtCriacao,1,10) as presenteDia
    FROM transacoes
    WHERE DtCriacao >= '2025-08-25'
    AND DtCriacao < '2025-08-30'

    ORDER BY IdCliente,presenteDia
),

tb_clientes_dias AS (

    SELECT t1.IdCliente,
            count(DISTINCT t2.presenteDia) AS qtdeDias
    FROM tb_prim_dia as t1

    LEFT JOIN tb_dias_curso as t2
    ON t1.IdCliente = t2.IdCliente

    GROUP BY t1.IdCliente
)

SELECT avg(qtdeDias)
FROM tb_clientes_dias