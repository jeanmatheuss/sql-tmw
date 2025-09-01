-- CTE: COMMOM TABLE EXPRESSION

WITH tb_clientes_primeiro_dia AS(

    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao,1,10) = '2025-08-25'
),

tb_clientes_ulitmo_dia AS (
    SELECT DISTINCT IdCliente
    FROM transacoes
    WHERE substr(DtCriacao,1,10) = '2025-08-29'
),

tb_join AS (
    SELECT t1.IdCliente as primeiroCliente,
            t2.IdCliente as ultimoCliente
    FROM tb_clientes_primeiro_dia as t1
    LEFT JOIN tb_clientes_ulitmo_dia as t2
    ON t1.IdCliente = t2.IdCliente
)

SELECT count(primeiroCliente),
        count(ultimoCliente),
        1. * count(ultimoCliente) / count(primeiroCliente)
from tb_join