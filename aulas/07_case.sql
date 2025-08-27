SELECT IdCliente,
        QtdePontos,
        CASE 
            WHEN QtdePontos <= 500 THEN 'Ponei'
            WHEN QtdePontos= 1000 THEN 'Ponei Premium'
            WHEN QtdePontos<= 5000 THEN 'Mago Aprendiz'
            WHEN QtdePontos<= 10000 THEN 'Mago Mestre'
            --WHEN QtdePontos > 10000 THEN 'Mago Supremo'
            ELSE 'Mago Supremo'
            END AS Classes

FROM clientes

ORDER BY QtdePontos DESC