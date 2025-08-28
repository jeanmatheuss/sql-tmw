SELECT 
    count(*) as QtdTransacoes,
    count(DISTINCT IdCliente) AS QtdTransacoesClientes 

FROM transacoes

WHERE DtCriacao >= '2025-07-01'
AND DtCriacao < '2025-08-01'

order BY DtCriacao DESC