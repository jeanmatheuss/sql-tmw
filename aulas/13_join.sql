SELECT t1.*, 
        t2.DescProduto

FROM transacao_produto as t1

LEFT JOIN produtos as t2
ON t1.IdProduto = t2.IdProduto

LIMIT 10