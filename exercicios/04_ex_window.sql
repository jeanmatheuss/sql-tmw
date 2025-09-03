--Quantidade de usuários cadastrados (absoluto e acumulado) ao longo do tempo?
WITH tb_qtd_clientes as (
    SELECT  
            substr(DtCriacao,1,10) AS dtDia,
            count(DISTINCT IdCliente) as qtdClientesAbs
    FROM clientes
    GROUP BY dtDia
),
tb_cliente_acum AS (
        SELECT *,
                sum(qtdClientesAbs) OVER (ORDER BY dtDia) as qtdClientesAcum
        FROM tb_qtd_clientes
)

SELECT * 
FROM tb_cliente_acum
WHERE qtdClientesAcum > 3000
ORDER BY qtdClientesAcum
LIMIT 1;

-- Quantidade de transações Acumuladas ao longo do tempo?

WITH tb_diario AS (

        SELECT substr(DtCriacao,1,10) as dtDia,
                count(DISTINCT IdTransacao) as qtdTransacao

        FROM transacoes 

        GROUP BY dtDia
        ORDER BY qtdTransacao
),

tb_acumulada as (

        SELECT *,
                sum(qtdTransacao) OVER (ORDER by dtDia) as qtdTransacaoAcum

        FROM tb_diario
)

SELECT *
FROM tb_acumulada

WHERE qtdTransacaoAcum > 100000
ORDER BY qtdTransacaoAcum
LIMIT 1;