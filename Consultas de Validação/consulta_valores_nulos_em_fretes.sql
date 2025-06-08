SELECT * FROM fretes 
WHERE data_saida is NULL
	OR data_entrega is NULL
    OR valor_frete is NULL
    OR id_transportadora is NULL
    or id_cliente is NULL
    or status_entrega is NULL