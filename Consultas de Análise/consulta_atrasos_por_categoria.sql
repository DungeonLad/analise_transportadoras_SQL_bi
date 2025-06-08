SELECT 
    t.categoria,
    COUNT(f.id_frete) AS total_entregas,
    SUM(CASE WHEN f.status_entrega = 'Atrasado' THEN 1 ELSE 0 END) AS entregas_atrasadas,
    ROUND(
        100.0 * SUM(CASE WHEN f.status_entrega = 'Atrasado' THEN 1 ELSE 0 END) / COUNT(f.id_frete),
        2
    ) AS percentual_atrasos
FROM fretes f
JOIN transportadoras t ON f.id_transportadora = t.id_transportadora
GROUP BY t.categoria;