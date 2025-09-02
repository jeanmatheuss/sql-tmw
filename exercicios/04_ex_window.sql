--Quantidade de usuários cadastrados (absoluto e acumulado) ao longo do tempo?
with tb_qtd_clientes as (
    SELECT  
            substr(DtCriacao,1,10) AS dtDia,
            count(DISTINCT IdCliente) as qtdClientesAbs
    FROM clientes
    GROUP BY dtDia
)

SELECT *,
        sum(qtdClientesAbs) OVER (ORDER BY dtDia) as qtdClientesAcum
FROM tb_qtd_clientes

