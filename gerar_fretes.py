import sqlite3
import random
from datetime import datetime, timedelta
from faker import Faker

# Conectar ao banco
conn = sqlite3.connect('fretes.db')
cursor = conn.cursor()

fake = Faker('pt_BR')

# IDs existentes
ids_clientes = list(range(1, 31))  # 30 clientes
ids_transportadoras = list(range(1, 6))  # ajuste conforme o número real que você tiver

status_opcoes = ['Em Andamento', 'Entregue', 'Atrasado', 'Cancelado']

for _ in range(400):
    data_saida = fake.date_between(start_date='-90d', end_date='today')
    
    atraso_chance = random.choices([True, False], weights=[0.2, 0.8])[0]
    if atraso_chance:
        data_entrega = data_saida + timedelta(days=random.randint(5, 15))
        status = random.choice(['Atrasado', 'Entregue'])
    else:
        data_entrega = data_saida + timedelta(days=random.randint(1, 5))
        status = random.choice(['Entregue', 'Cancelado', 'Em Andamento'])

    valor_frete = round(random.uniform(150, 2000), 2)
    id_transportadora = random.choice(ids_transportadoras)
    id_cliente = random.choice(ids_clientes)

    cursor.execute("""
        INSERT INTO fretes (data_saida, data_entrega, valor_frete, id_transportadora, id_cliente, status_entrega)
        VALUES (?, ?, ?, ?, ?, ?)
    """, (
        data_saida,
        data_entrega,
        valor_frete,
        id_transportadora,
        id_cliente,
        status
    ))

conn.commit()
conn.close()
print("Dados de fretes gerados com sucesso!")
