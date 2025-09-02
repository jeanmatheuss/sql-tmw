--  Qual o dia com maior engajamento de cada aluno que iniciou o curso no dia 01?
-- WITH alunos_dia01 as (
--     SELECT DISTINCT IdCliente
--     FROM transacoes
--     WHERE substr(DtCriacao, 1, 10) = '2025-08-25'
-- ),

-- tb_dia_cliente AS (
--     SELECT t1.IdCliente,
--             substr(t2.DtCriacao,1,10) as dtDia,
--             count(*) as qtdeInteracoes

--     FROM alunos_dia01 as t1

--     LEFT JOIN transacoes as t2
--     ON t1.IdCliente = t2.IdCliente
--     AND t2.DtCriacao >= '2025-08-25'
--     AND t2.DtCriacao < '2025-08-30'

--     GROUP BY t1.IdCliente, substr(t2.DtCriacao,1,10)

--     ORDER BY t1.IdCliente, dtDia
-- ),

-- max_inter as (
--     SELECT IdCliente,
--             max(qtdeInteracoes) as maxInter

--     FROM tb_dia_cliente

--     GROUP BY IdCliente
-- )

-- SELECT  t1.IdCliente,
--         max(t2.dtDia) as maxDia,
--         max(t1.maxInter)

-- FROM max_inter as t1

-- LEFT JOIN tb_dia_cliente as t2
-- ON t1.IdCliente = t2.IdCliente
-- AND t1.maxInter = t2.qtdeInteracoes

-- GROUP BY t1.IdCliente

-- jeito 1 de fazer 

-- ############ jeito 2 ##########33
WITH alunos_dia01 as (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao, 1, 10) = '2025-08-25'
),

tb_dia_cliente AS (
    SELECT t1.IdCliente,
            substr(t2.DtCriacao,1,10) as dtDia,
            count(*) as qtdeInteracoes

    FROM alunos_dia01 as t1

    LEFT JOIN transacoes as t2
    ON t1.IdCliente = t2.IdCliente
    AND t2.DtCriacao >= '2025-08-25'
    AND t2.DtCriacao < '2025-08-30'

    GROUP BY t1.IdCliente, substr(t2.DtCriacao,1,10)

    ORDER BY t1.IdCliente, dtDia
),

tb_rn AS (

    SELECT *,
            row_number() OVER (PARTITION BY IdCliente ORDER by qtdeInteracoes DESC, dtDia) as rn

    FROM tb_dia_cliente
)

SELECT * 
FROM tb_rn
WHERE rn = 1