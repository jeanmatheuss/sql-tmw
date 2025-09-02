-- Quem iniciou o curso no primeiro dia, em média assistiu quantas aulas?
-- WITH tb_prim_dia AS (
--     SELECT DISTINCT IdCliente
--     FROM transacoes
--     WHERE substr(DtCriacao, 1, 10) = '2025-08-25'
-- ),

-- tb_dias_curso AS (
--     SELECT DISTINCT
--         IdCliente, 
--         substr(DtCriacao,1,10) as presenteDia
--     FROM transacoes
--     WHERE DtCriacao >= '2025-08-25'
--     AND DtCriacao < '2025-08-30'

--     ORDER BY IdCliente,presenteDia
-- ),

-- tb_clientes_dias AS (

--     SELECT t1.IdCliente,
--             count(DISTINCT t2.presenteDia) AS qtdeDias
--     FROM tb_prim_dia as t1

--     LEFT JOIN tb_dias_curso as t2
--     ON t1.IdCliente = t2.IdCliente

--     GROUP BY t1.IdCliente
-- )

-- SELECT avg(qtdeDias)
-- FROM tb_clientes_dias

-- Como foi a curva de Churn do Curso de SQL?
-- SELECT IdCliente,
--         substr(DtCriacao,1,10) AS dtDia,
--         count(DISTINCT IdCliente) as qtdeClientes

-- FROM transacoes

-- WHERE DtCriacao >= '2025-08-25'
-- AND DtCriacao < '2025-08-30'

-- GROUP BY dtDia


-- ############################


-- WITH tb_clientes_d1 as(
-- SELECT DISTINCT IdCliente

-- FROM transacoes 

-- WHERE DtCriacao >= '2025-08-25'
-- AND DtCriacao < '2025-08-26'
-- ),

-- tb_join as (

-- SELECT 
--         substr(t2.DtCriacao,1,10) as dtDia,
--         count(DISTINCT t1.IdCliente) as qtdeClientes,
--         1.* count(DISTINCT t1.IdCliente) / (SELECT count(*) FROM tb_clientes_d1) as pctRetencao,
--         1 - 1.* count(DISTINCT t1.IdCliente) / (SELECT count(*) FROM tb_clientes_d1) as pctChurn

-- FROM tb_clientes_d1 as t1

-- LEFT JOIN transacoes as t2
-- ON t1.IdCliente = t2.IdCliente

-- WHERE t2.DtCriacao >= '2025-08-25'
-- AND t2.DtCriacao < '2025-08-30'

-- GROUP by dtDia
-- )

-- SELECT * FROM tb_join;

-- Dentre os clientes de janeiro/2025, quantos assistiram o curso de SQL?

WITH tb_clientes_jan AS (
        SELECT DISTINCT IdCliente

        FROM transacoes

        WHERE DtCriacao >= '2025-01-01'
        AND DtCriacao < '2025-02-01'
),

tb_clientes_curso as (
        SELECT DISTINCT IdCliente
        FROM transacoes
        WHERE DtCriacao >= '2025-08-25'
        AND DtCriacao < '2025-08-30'

)

SELECT 
        count(t1.IdCliente) AS clientesJaneiro,
        count(t2.IdCliente) as clientesCurso
FROM tb_clientes_jan as t1

LEFT JOIN tb_clientes_curso as t2
ON t1.IdCliente = t2.IdCliente
--cria um filtro/critério no join
-- AND t2.DtCriacao >= '2025-08-25'
-- AND DtCriacao < '2025-08-30'
