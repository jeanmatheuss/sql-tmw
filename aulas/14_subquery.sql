-- lista de transações com produto Ponei
SELECT *

FROM transacao_produto as t1

WHERE t1.IdProduto IN(
    SELECT IdProduto
    FROM produtos
    WHERE DescProduto = 'Resgatar Ponei'
)