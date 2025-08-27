-- criação de coluna nova e transformando coluna para datetime
SELECT IdCliente ,
        -- QtdePontos,
        -- QtdePontos + 10 AS QtdPontosPlus10,
        DtCriacao,

        substr(DtCriacao,1,19) as DtSubString,

        datetime(substr(DtCriacao,1,19)) AS DtCriacaoNova,
      
        strftime('%w',datetime(substr(DtCriacao,1,19))) AS diaSemana


FROM clientes