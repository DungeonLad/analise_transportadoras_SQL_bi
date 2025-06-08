SELECT 
    t.nome_transportadora,
    COUNT(f.id_frete) AS total_fretes,
    SUM(CASE WHEN f.status_entrega = 'Atrasado' THEN 1 ELSE 0 END) AS fretes_atrasados,
    ROUND(
        CAST(SUM(CASE WHEN f.status_entrega = 'Atrasado' THEN 1 ELSE 0 END) AS FLOAT) 
        / COUNT(f.id_frete) * 100, 2
    ) AS percentual_atrasos
FROM fretes f
JOIN transportadoras t ON f.id_transportadora = t.id_transportadora
GROUP BY t.nome_transportadora
ORDER BY percentual_atrasos DESC;