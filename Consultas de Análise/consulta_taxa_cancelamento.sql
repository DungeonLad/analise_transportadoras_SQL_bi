SELECT 
    t.nome_transportadora,
    COUNT(f.id_frete) AS total_fretes,
    COUNT(CASE WHEN f.status_entrega = 'Cancelado' THEN 1 END) AS total_cancelados,
    ROUND(
        COUNT(CASE WHEN f.status_entrega = 'Cancelado' THEN 1 END) * 1.0 / COUNT(f.id_frete),
        2
    ) AS taxa_cancelamento
  FROM fretes f
       JOIN transportadoras t 
         ON f.id_transportadora = t.id_transportadora
 GROUP BY t.nome_transportadora
 ORDER BY taxa_cancelamento DESC;