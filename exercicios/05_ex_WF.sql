--Qual o dia da semana mais ativo de cada usuário?

-- com essa query pode se saber o dia mais ativo de cada usuário e
-- fazer campanha no dia que mais ele dá engajamento
WITH tb_cliente_semana as (
    SELECT IdCliente,
            strftime('%w',substr(DtCriacao,1,10)) as dtDiaSemana,
            count(DISTINCT IdTransacao) as qtdTransacao


    FROM transacoes

    GROUP BY IdCliente,dtDiaSemana
),
tb_rn AS (

    SELECT *,
            CASE 
                WHEN dtDiaSemana = 1 THEN 'SEGUNDA FEIRA'
                WHEN dtDiaSemana = 2 THEN 'TERCA FEIRA'
                WHEN dtDiaSemana = 3 THEN 'QUARTA FEIRA'
                WHEN dtDiaSemana = 4 THEN 'QUINTA FEIRA'
                WHEN dtDiaSemana = 5 THEN 'SEXTA FEIRA'
                WHEN dtDiaSemana = 6 THEN 'SABADO'
                ELSE 'DOMINGO'
                END AS diaSemana,

            row_number() OVER (PARTITION BY IdCliente ORDER BY qtdTransacao DESC) as rn

    FROM tb_cliente_semana
)
SELECT *
FROM tb_rn
WHERE rn = 1

