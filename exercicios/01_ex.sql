-- selecione todos os clientes com email cadastrados
SELECT *
FROM clientes
--WHERE FlEmail = '1'
--WHERE FlEmail != 0
WHERE FlEmail <> 0;

-- selecione todas as transações igual a 50
SELECT IdTransacao
FROM transacoes
WHERE QtdePontos = 50;

-- selecione todos os clientes com mais de 500 pts
SELECT IdCliente,QtdePontos FROM clientes
WHERE QtdePontos >= 500;

-- selecione produtos que contém churn no nome
SELECT * FROM produtos
-- WHERE DescProduto = 'Churn_10pp'
--     OR DescProduto = 'Churn_2pp'
--     OR DescProduto = 'Churn_5pp'

-- WHERE DescProduto IN ('Churn_10pp', 'Churn_2pp','Churn_5pp')

-- % é o coringa, seleciona o resto*
WHERE DescProduto LIKE 'Churn%'