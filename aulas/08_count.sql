SELECT  count(*) as QTDdeClientes

FROM clientes;

-- Distinct count
SELECT count(DISTINCT IdCliente) as QtdClientesDistintos
FROM clientes;