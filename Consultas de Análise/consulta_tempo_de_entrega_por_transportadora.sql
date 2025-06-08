SELECT 
    t.nome_transportadora,
    ROUND(AVG(JULIANDAY(f.data_entrega) - JULIANDAY(f.data_saida)), 2) AS tempo_medio_entrega
FROM fretes f
JOIN transportadoras t ON f.id_transportadora = t.id_transportadora
WHERE f.status_entrega = 'Entregue'
  AND f.data_saida IS NOT NULL
  AND f.data_entrega IS NOT NULL
GROUP BY t.nome_transportadora
ORDER BY tempo_medio_entrega DESC;