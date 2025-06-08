SELECT 
    t.nome_transportadora,
    COUNT(f.id_frete) AS total_fretes,
    SUM(f.valor_frete) AS total_valor_fretes,
    ROUND(AVG(f.valor_frete), 2) AS custo_medio_por_entrega
FROM fretes f
JOIN transportadoras t ON f.id_transportadora = t.id_transportadora
GROUP BY t.nome_transportadora
ORDER BY custo_medio_por_entrega DESC;