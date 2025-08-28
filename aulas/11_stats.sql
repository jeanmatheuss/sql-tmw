SELECT avg(QtdePontos) AS MediaPontos,
        1.* sum(QtdePontos) / count(QtdePontos) as mediaCarteiraRoots,
        min(QtdePontos) as minCarteira,
        max(QtdePontos) as maxCarteira,
        sum(FlTwitch) as QtdTwitch,
        sum(FlEmail) as QtdEmail
FROM clientes