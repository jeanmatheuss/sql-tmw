--Dias desde a última transação

WITH tb_transacoes as (

    SELECT IdTransacao,
        IdCliente,
        QtdePontos,
        datetime(substr(DtCriacao,1,10)) as dtCriacao,
        julianday('{date}') - julianday(substr(DtCriacao,1,10)) as diffDate,
        CAST(strftime('%H', substr(DtCriacao,1,19)) AS INTEGER) AS dtHora

    FROM transacoes
    WHERE DtCriacao < '{date}'
),

--Idade na base

tb_cliente as (

    SELECT IdCliente,
            datetime(substr(DtCriacao,1,19)) as DtCriacao,
            julianday('{date}') - julianday(substr(DtCriacao,1,10)) as idadeBase

    FROM clientes

),
--Quantidade de transações históricas (vida, D7, D14, D28, D56);
--Dias desde a última transação
--Saldo de pontos atual;
--Pontos acumulados negativos (vida, D7, D14, D28, D56);

tb_sumario_transacoes as (

    SELECT IdCliente,
            count(IdTransacao) as qtdeTransacoesVida,
            count(CASE WHEN diffDate <= 7 THEN IdTransacao END) as qtdTransacoes7d,
            count(CASE WHEN diffDate <= 14 THEN IdTransacao END) as qtdTransacoes14d,
            count(CASE WHEN diffDate <= 28 THEN IdTransacao END) as qtdTransacoes28d,
            count(CASE WHEN diffDate <= 56 THEN IdTransacao END) as qtdTransacoes56d,
            
            MIN(diffDate) as diasUltimaTransacao,
            
            sum(QtdePontos) as saldoPontos,

            sum(CASE WHEN QtdePontos > 0 THEN QtdePontos ELSE 0 END) as qtdePontosPosVida,
            sum(CASE WHEN QtdePontos > 0  AND diffDate <= 7 THEN QtdePontos ELSE 0  END) as qtdPontosPos7,
            sum(CASE WHEN QtdePontos > 0  AND diffDate <= 14 THEN QtdePontos ELSE 0  END) as qtdPontosPos14,
            sum(CASE WHEN QtdePontos > 0  AND diffDate <= 28 THEN QtdePontos ELSE 0  END) as qtdPontosPos28,
            sum(CASE WHEN QtdePontos > 0  AND diffDate <= 56 THEN QtdePontos  ELSE 0 END) as qtdPontosPos56,

            sum(CASE WHEN QtdePontos < 0 THEN QtdePontos ELSE 0 END) as qtdePontosNegVida,
            sum(CASE WHEN QtdePontos < 0  AND diffDate <= 7 THEN QtdePontos ELSE 0  END) as qtdPontosNeg7,
            sum(CASE WHEN QtdePontos < 0  AND diffDate <= 14 THEN QtdePontos ELSE 0  END) as qtdPontosNeg14,
            sum(CASE WHEN QtdePontos < 0  AND diffDate <= 28 THEN QtdePontos ELSE 0  END) as qtdPontosNeg28,
            sum(CASE WHEN QtdePontos < 0  AND diffDate <= 56 THEN QtdePontos  ELSE 0 END) as qtdPontosNeg56


    FROM tb_transacoes
    GROUP BY IdCliente

),


--Dias da semana mais ativos (D28)
tb_transacao_produto as (
    SELECT t1.*,
            t3.DescCateogriaProduto,
            t3.DescProduto

    FROM tb_transacoes as t1

    LEFT JOIN transacao_produto as t2
    ON t1.IdTransacao = t2.IdTransacao

    LEFT JOIN produtos as t3
    ON t2.IdProduto = t3.IdProduto
),
tb_cliente_produto as (
    SELECT IdCliente,
            DescProduto,
            count(*) as qtdeVida,
            count(CASE WHEN diffDate <= 56 THEN IdTransacao END) AS  qtde56,
            count(CASE WHEN diffDate <= 28 THEN IdTransacao END) AS  qtde28,
            count(CASE WHEN diffDate <= 14 THEN IdTransacao END) AS  qtde14,
            count(CASE WHEN diffDate <= 7 THEN IdTransacao END)  AS qtde7

    FROM tb_transacao_produto

    GROUP BY IdCliente, DescProduto
),

tb_cliente_produto_rn as (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY IdCliente ORDER BY qtdeVida DESC) as rnVida,
        ROW_NUMBER() OVER (PARTITION BY IdCliente ORDER BY qtde7 DESC) as rn7,
        ROW_NUMBER() OVER (PARTITION BY IdCliente ORDER BY qtde14 DESC) as rn14,
        ROW_NUMBER() OVER (PARTITION BY IdCliente ORDER BY qtde28 DESC) as rn28,
        ROW_NUMBER() OVER (PARTITION BY IdCliente ORDER BY qtde56 DESC) as rn56
    FROM tb_cliente_produto
),

tb_cliente_dia as (
    SELECT IdCliente,
            strftime('%w', DtCriacao) as dtDia,
            count(*) as qtdTransacao

    FROM tb_transacoes
    WHERE diffDate <=28
    GROUP BY IdCliente
),

tb_cliente_dia_rn AS(

    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY IdCliente ORDER BY qtdTransacao DESC) as rnDia

    FROM tb_cliente_dia
),

tb_cliente_periodo AS (
    SELECT IdCliente,
    CASE
        WHEN dtHora BETWEEN 7 AND 12 THEN 'MANHÃ'
        WHEN dtHora BETWEEN 13 AND 18 THEN 'TARDE'
        WHEN dtHora BETWEEN 19 AND 23 THEN 'NOITE'
        ELSE 'MADRUGADA'
    END AS periodo,
    count(*) as qtdeTransacao
    
    FROM tb_transacoes
    WHERE diffDate <= 28

    GROUP BY 1,2 --seleciona duas primeiras colunas
    ),

tb_cliente_periodo_rn AS (
    
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY IdCliente ORDER BY qtdeTransacao DESC) AS rnPeriodo
    FROM tb_cliente_periodo
),

tb_join as (
    SELECT t1.*,
            t2.idadeBase,
            t3.DescProduto as ProdutoVida,
            t4.DescProduto AS produto56,
            t5.DescProduto AS produto28,
            t6.DescProduto AS produto14,
            t7.DescProduto AS produto7,
            COALESCE(t8.dtDia, -1) as dtDia, -- COALESCE = IF DADO ANTERIORO EXISTE, CONTINUA SE NÃO VALOR A SEGUIR
            COALESCE(t9.periodo, 'SEM INFORMACAO') AS periodoMaisTransacao28

    FROM tb_sumario_transacoes as t1

    LEFT JOIN tb_cliente as t2
    ON t1.IdCliente = t2.IdCliente

    LEFT JOIN tb_cliente_produto_rn as t3
    ON t1.IdCliente = t3.IdCliente
    AND t3.rnVida = 1

    LEFT JOIN tb_cliente_produto_rn as t4
    ON t1.IdCliente = t4.IdCliente
    AND t4.rn56 = 1
    
    LEFT JOIN tb_cliente_produto_rn as t5
    ON t1.IdCliente = t5.IdCliente
    AND t5.rn28 = 1
    
    LEFT JOIN tb_cliente_produto_rn as t6
    ON t1.IdCliente = t6.IdCliente
    AND t6.rn14 = 1

    LEFT JOIN tb_cliente_produto_rn as t7
    ON t1.IdCliente = t7.IdCliente
    AND t7.rn7 = 1

    LEFT JOIN tb_cliente_dia_rn as t8
    ON t1.IdCliente = t8.IdCliente
    AND t8.rnDia = 1

    LEFT JOIN tb_cliente_periodo_rn as t9
    ON t1.IdCliente =t9.IdCliente
    AND t9.rnPeriodo = 1

)

INSERT INTO feature_store_cliente

SELECT 
        '{date}' AS dtRef,
        *,
        1.* qtdTransacoes28d / qtdeTransacoesVida AS engajamento28Vida
FROM tb_join
