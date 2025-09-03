-- inserir dados que estão abaixo no SELECT no INSERT
DELETE FROM relatorio_diario;

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

INSERT INTO relatorio_diario  

SELECT *
FROM tb_acumulada;

SELECT *
FROM relatorio_diario;