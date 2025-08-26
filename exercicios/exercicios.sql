-- Lista de transações com apenas 1 ponto;
SELECT IdTransacao FROM transacoes
WHERE QtdePontos = 1
LIMIT 10;

-- listar todos os pedidos no fim de semana

-- Lista de clientes com 0 (zero) pontos;
SELECT IdCliente FROM clientes
WHERE QtdePontos = 0
LIMIT 10;

-- Lista de clientes com 100 a 200 pontos (inclusive ambos);
SELECT IdCliente, QtdePontos FROM clientes
WHERE QtdePontos BETWEEN 100 AND 200
LIMIT 10;

-- Lista de produtos com nome que começa com “Venda de”;
SELECT DescProduto FROM produtos
WHERE DescProduto LIKE 'Venda de%';

-- Lista de produtos com nome que termina com “Lover”;
SELECT DescProduto FROM produtos
WHERE DescProduto LIKE '%Lover';

-- Lista de produtos que são “chapéu”;
SELECT DescProduto FROM produtos
WHERE DescProduto LIKE '%Chapéu%';

-- Lista de transações com o produto “Resgatar Ponei”;
SELECT * FROM produtos
WHERE DescProduto LIKE '%Resgatar Ponei%';

SELECT IdTransacaoProduto FROM transacao_produto
WHERE IdProduto = 15;