-- criar tabelas a partir de uma query (com esses dois comandos meio que atualiza a tabela)
DROP TABLE IF EXISTS relatorio_diario;

CREATE TABLE IF NOT EXISTS relatorio_diario AS

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
FROM tb_acumulada;
