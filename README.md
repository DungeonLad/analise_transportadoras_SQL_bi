# Introdução e Resumo

  Quis fazer um projeto que tivesse conexão com a área de logística e transportes. Para esse projeto, quis algo que tivesse conexão direta com logística e transportes. Meu objetivo é pôr em prática meu SQL num projeto mais ou menos real, visto que até então só aprendi a teoria, fiz as práticas do livro Introdução a Linguagem SQL do Thomas Nield e do curso Coursera Google Data Analytics, e brinquei um pouco no SQLzoo. Outro objetivo é usar o Power Bi para criar visualizações de forma independente, já que, anteriormente, só o utilizei para exercícios de um curso.

## Stack do projeto

  SQLite para criação da base de dados e das tabelas, inserção das informações nas tabelas e consultas para análise;
  GitHub para armazenar o código e as queries.
  Power Bi para visualização.
  Power Query para transformação dos dados.
  Python para automação de um processo.

## Limitação dos Dados

Os dados, por serem gerados aleatoriamente, não refletem de forma adequada a realidade. Por exemplo: os diferentes dados entre as transportadoras refletem apenas aleatoriedade, e não diferenças na gestão, modelo de negócios, infraestrutura e etc. de cada uma delas.

Também por serem dados fictícios, não podemos fazer afirmações baseadas no contexto ao redor dos dados, coisa que normalmente seríamos capazes de fazer na vida real.


## Conclusões

O SQL foi suficiente para respondermos as perguntas que definimos na etapa 1. Descobrimos uma transportadora com um percentual de atrasos significantemente menor que as outras. Descobrimos que as transportadoras terceirizadas têm um desempenho maior do que a transportadora própria, mas que, de forma geral, todas apresentam um desempenho muito semelhante.

Com o Power Bi, criamos uma página com visualizações para fazer análises por transportadoras (o objetivo original), de modo que podemos responder não apenas as cinco perguntas originais, como também muitas outras. Também criamos uma página com visualizações que visam analisar a performance e o impacto por clientes, respondendo perguntas adicionais.

Usando o Python e o ChatGPT, criamos um código para automatizar a geração de dados para popular uma das três tabelas, economizando tempo e garantindo uma certa aleatoriedade segura. Rodamos o código duas vezes, gerando 400 linhas em cada vez, mas também poderíamos rodá-lo mais vezes ou alterá-lo para que gerasse ainda mais linhas a cada execução.

# Etapa 1 - Perguntar - Definir o Problema

Estamos trabalhando com dados fictícios (gerados por IA) de uma empresa que contrata várias transportadoras. Queremos avaliar o desempenho de cada uma em termos de custo, tempos de entrega e taxa de atraso.

Queremos responder as perguntas:

Qual a taxa de fretes atrasados por transportadora?

Qual transportadora tem o maior custo por entrega?

Qual o percentual de entregas atrasadas por categoria?

Qual o tempo médio de entrega por transportadora?

Quais as transportadoras com maior taxa de cancelamento?

# Etapa 2 - Preparar - Criação e organização dos dados

Vamos criar a base do nosso banco de dados e definir três tabelas. Embora o nome me pareça bem intuitivo, creio que o óbvio também precise ser documentado.

transportadoras

Contendo as informações sobre as transportadoras

clientes

Contendo as informações sobre os clientes que são atendidos pelas transportadoras.

fretes

Contendo as informações sobre os transportes realizados pelas transportadoras para os clientes.

Vamos agora definir a nossa

## Estrutura de tabelas

## 1. Fretes

id_frete

data_saida

data_entrega

valor_frete

id_transportadora

status_entrega (Entregue, Atrasado, Cancelado)

## 2. Transportadoras

id_transportadora

nome_transportadora

categoria (Terceirizada, Própria)

## 3. Clientes

id_cliente

nome_cliente

cidade

setor

Poderíamos fazer isso de forma relativamente simples no Microsoft Excel ou no Microsoft Access, para depois exportarmos e convertermos o arquivo para ser utilizado pelo SQLite, mas criaremos as tabelas e as popularemos usando um script SQL, com dados fictícios, mas verossímeis, gerados por inteligência artificial. Isso porque, mais uma vez, o objetivo é praticar, inclusive a DDL - Data Definition Language e a DML - Data Manipulation Language, que foram as partes básicas de SQL que menos pratiquei.

## 2.1. - Criação das Tabelas

Tendo definido anteriormente a estrutura das tabelas, criei-as da seguinte forma:

```sql
CREATE TABLE transportadoras (
    id_transportadora INTEGER PRIMARY KEY,
    nome_transportadora TEXT NOT NULL,
    categoria TEXT NOT NULL CHECK (categoria IN ('Própria', 'Terceirizada'))
);
```

```sql
CREATE TABLE fretes (
    id_frete INTEGER PRIMARY KEY,
    data_saida DATE,
    data_entrega DATE,
    valor_frete DECIMAL(10, 2),
    id_transportadora INT,
	status_entrega TEXT NOT NULL CHECK (status_entrega IN ('Em Andamento', 'Entregue', 'Atrasado', 'Cancelado'))
  	FOREIGN KEY (id_transportadora) REFERENCES transportadoras(id_transportadora),
);
    
```

```sql
CREATE TABLE fretes (
    id_frete          INTEGER         PRIMARY KEY,
    data_saida        DATE,
    data_entrega      DATE,
    valor_frete       DECIMAL (10, 2),
    id_transportadora INT,
    id_cliente        INT,
    status_entrega    TEXT            NOT NULL
                                      CHECK (status_entrega IN ('Em Andamento', 'Entregue', 'Atrasado', 'Cancelado')),
    FOREIGN KEY (id_transportadora) REFERENCES transportadoras (id_transportadora),
    FOREIGN KEY (id_cliente)        REFERENCES clientes (id_cliente)
);
```

## 2.2 - Criação dos dados

Estamos usando dados fictícios, criados por nós mesmos.

vamos começar inserindo dados sobre as transportadoras.

```sql
INSERT INTO transportadoras (nome_transportadora, categoria)
VALUES 
    ('TransLog Express', 'Terceirizada'),
    ('Setor de Transportes', 'Própria'),
    ('Rápido Sul', 'Terceirizada'),
    ('FreteFácil', 'Terceirizada'),
    ('ViaRápida Transportes', 'Terceirizada');
```

Vamos também inserir dados sobre os clientes:

```sql
INSERT INTO clientes (nome_cliente, cidade, setor)
VALUES
   ('Loja Sol', 'São Paulo', 'Varejo'),
    ('Mercado do Povo', 'Belo Horizonte', 'Alimentação'),
    ('ConstruMais', 'Curitiba', 'Construção'),
    ('InfoTech', 'Rio de Janeiro', 'Tecnologia'),
    ('Atacadão Mix', 'Porto Alegre', 'Atacado'),
    ('Farmácia Vida', 'Salvador', 'Saúde'),
    ('Auto Center Norte', 'Campinas', 'Automotivo'),
    ('EletroShop', 'Fortaleza', 'Eletrodomésticos'),
    ('SuperModa', 'Recife', 'Vestuário'),
    ('Padaria Central', 'São Luís', 'Alimentação'),
    ('PetAmigo', 'João Pessoa', 'Pet Shop'),
    ('Constrular', 'Manaus', 'Construção'),
    ('Mega Utilidades', 'Belém', 'Varejo'),
    ('TecnoZone', 'Brasília', 'Tecnologia'),
    ('Bebê & Cia', 'Goiânia', 'Infantil'),
    ('Casa Verde', 'Curitiba', 'Decoração'),
    ('Esporte Total', 'Porto Alegre', 'Esportes'),
    ('Doceria Sabor', 'Florianópolis', 'Alimentação'),
    ('Mundo das Ferramentas', 'Campo Grande', 'Ferragens'),
    ('Top Jeans', 'Maceió', 'Vestuário'),
    ('Sorveteria Frio Bom', 'Natal', 'Alimentação'),
    ('Smart Eletrônicos', 'Aracaju', 'Tecnologia'),
    ('MoveLar', 'Cuiabá', 'Móveis'),
    ('AgroCenter', 'Ribeirão Preto', 'Agropecuária'),
    ('Estúdio Print', 'São Paulo', 'Gráfica'),
    ('Flor & Jardim', 'Bauru', 'Jardinagem'),
    ('Loja do Povo', 'Niterói', 'Varejo'),
    ('Moda e Estilo', 'Santos', 'Vestuário'),
    ('Importados Mix', 'Londrina', 'Atacado'),
    ('Auto Parts Brasil', 'Uberlândia', 'Automotivo');
```

Agora, para gerar os fretes, queria um volume grande, pelo menos 400. O ChatGPT sugeriu que eu executasse um script python para isso, e ele mesmo me deu o script. Não entendo quase nada de Python, mas pedi para que o ChatGPT me explicasse também o que cada parte do código faz, de modo que fui capaz de fazer algumas correções e alterações. O resultado final foi esse:

```python
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

# Etapa 3 - Processar - Validação e Limpeza de Dados

Vamos verificar se está tudo certo com nossos dados da tabela fretes. Não farei isso com a tabela clientes ou transportadoras porque estou certo que está tudo certo com ele.

Vamos começar verificando valores nulos:

## 3.1 - Verificar valores nulos

```sql
SELECT * FROM fretes 
WHERE data_saida is NULL
	OR data_entrega is NULL
    OR valor_frete is NULL
    OR id_transportadora is NULL
    or id_cliente is NULL
    or status_entrega is NULL
	
```

Não temos nenhum valor nulo.

Um possível erro que passou pela minha cabeça é a possibilidade de termos valores invertidos, onde a data de entrega é anterior à data de saída. Vamos verificar se isso aconteceu também.

## 3.2. Verificar valores onde data_entrega < data_saída

```sql
SELECT * FROM fretes
	WHERE data_entrega < data_saida
```

Não temos nenhuma ocorrência em que o frete foi concluído antes de ser iniciado, felizmente.

Vamos fazer também o oposto, para garantir que esteja tudo certo, invertendo o sinal de menor que para maior que e limitando a 100, para não termos muita coisa nos resultados

```sql
SELECT * FROM fretes
	WHERE data_entrega > data_saida
     LIMIT 100;
```

Vamos verificar valores absurdos de frete. Quero saber se tivemos fretes abaixo de $100,00 ou fretes acima de $5.000,00. Esses outliers não poderiam ser estudados de forma assertiva (já que estamos lidados com dados aleatórios, sem contexto), e por isso, caso existam, serão removidos.

## 3.3. Verificar fretes com valores abaixo de 100 ou acima de 5000

```sql
SELECT * FROM fretes
WHERE valor_frete < 100 OR valor_frete > 5000;
```

Mais uma vez, os dados estão limpos.

Para a verificação de se haviam fretes associados a transportadoras ou clientes inexistentes, usei a própria ferramenta de visualização de dados do sqlite, da seguinte forma:

Na tabela frete, classifiquei o id_transportadora da maior para a menor, de modo que, se houvesse um valor superior a 5 (e, portanto, uma referência a uma transportadora inexistente), eu conseguiria visualizá-lo.

![image_1749311531135_0](https://github.com/user-attachments/assets/0d7de121-c2eb-4427-8ac3-9ea01e932bea)

Como se pode ver, não tínhamos.

Fiz o mesmo na tabela cliente. Dessa vez, um valor id_cliente superior à 30 significaria um cliente inexistente:

![image_1749311578265_0](https://github.com/user-attachments/assets/0714bced-76ba-45de-9604-6065a27e457c)

Mais uma vez, não temos problemas de clientes inexistentes.

Estou satisfeito com a integridade dos dados.

Vamos passar para a fase de análise, onde responderemos as perguntas que definimos na Etapa 1.

# Etapa 4 - Analisar - Responder

Qual a taxa de fretes em atraso por cada transportadora?

Para responder essa pergunta, executamos a consulta:

```sql
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
```

E obtivemos como resultado:

![image_1749313312672_0](https://github.com/user-attachments/assets/d6fe86dc-8733-45da-b9bb-a0519d06e027)


Vimos que nossa transportadora própria, "Setor de Transportes," é a que mais tem atrasos. Algo comicamente inesperado e levemente negativo. A transportadora que menos se atrasa é a TransLog Express - sua taxa de atraso é quase 1/3 da taxa do Setor de Transportes e Via Rápida, e quase 1/2 da taxa da Rápido Sul e Frete Fácil. Uma decisão que poderíamos tomar a partir disso seria priorizar a TransLog Express, especialmente em entregas críticas, que não podem "passar do prazo".

Qual transportadora tem o maior custo por entrega?

Para responder essa pergunta, executamos a consulta:

```sql
SELECT 
    t.nome_transportadora,
    COUNT(f.id_frete) AS total_fretes,
    SUM(f.valor_frete) AS total_valor_fretes,
    ROUND(AVG(f.valor_frete), 2) AS custo_medio_por_entrega
FROM fretes f
JOIN transportadoras t ON f.id_transportadora = t.id_transportadora
GROUP BY t.nome_transportadora
ORDER BY custo_medio_por_entrega DESC;
```

E tivemos como resposta que:

![image_1749313714232_0](https://github.com/user-attachments/assets/121322cc-5ce1-47ed-9acc-1eee0c3f8d64)

Vemos que o custo médio por entrega varia muito pouco, menos de $100 de diferença entre a média mais alta e a média mais baixa. Ainda assim, a FreteFácil (que era também a 2ª com o menor percentual de atrasos) se saiu como a transportadora mais barata, de modo que podemos dizer que ela é uma ótima opção custo-benefício.

Qual o percentual de entregas atrasadas por categoria?

Para sabermos disso, vamos executar o código:

```sql
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
```

E tivemos como resposta que:

![image_1749313975213_0](https://github.com/user-attachments/assets/61e85eb6-ba21-4f5d-a687-1726871e4ab2)

De modo que podemos concluir que, de modo geral, as transportadoras terceirizadas são preferíveis às transportadoras próprias.

O setor de transportes, naturalmente, tem outras responsabilidades que não as de transportes fretados, e com base nos dados acima, podemos nos perguntar se realmente é interessante para a empresa que o setor de transportes realize fretes. Caso terceirizássemos todos os fretes, poderíamos reduzir o percentual de atrasos nas entregas e também poderíamos fazer com que o setor de transportes dedicasse mais tempo e energia a outros processos nos quais teria maior impacto.

Qual o tempo de entrega média por transportadora?

Vamos executar esse código:

```sql
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
```

E obtemos como resultado:

![image_1749314498288_0](https://github.com/user-attachments/assets/b5d63822-cac9-43f8-82c3-73baf0f43ee4)

Vemos que a diferença entre a mais ágil (Rápido Sul) e a mais lenta (Setor de Transportes) é de menos de 24 horas. Não é, em casos não críticos, uma diferença muito significativa, especialmente levando em consideração que a maioria dos transportes realizados não são atrasos. Entretanto, em casos de extrema urgência, a Rápido Sul seria a melhor opção.

Vamos agora à nossa última pergunta:

Quais as taxas de cancelamento de qual transportadora?

Vamos usar o código abaixo para conseguirmos nossa resposta:

```sql
SELECT 
    t.nome_transportadora,
    COUNT(CASE WHEN f.status_entrega = 'Cancelado' THEN 1 END) * 1.0 / COUNT(*) AS taxa_cancelamento
FROM fretes f
JOIN transportadoras t ON f.id_transportadora = t.id_transportadora
GROUP BY t.nome_transportadora
ORDER BY taxa_cancelamento DESC;
```

E obtemos como resposta

![image_1749316596047_0](https://github.com/user-attachments/assets/bd6a819f-95e6-424d-a83f-d86c7530b148)

Vemos que não há uma variação muito grande: entre a que mais cancela e a que menos cancela, temos uma diferença de 5%. Entretanto, entre a que mais cancela e a segunda que mais cancela, temos uma diferença de 3%. Desse modo, apesar da frete fácil ter o menor custo médio e uma taxa de atrasos baixo, talvez seja bom estudar o porquê dela ter uma taxa de cancelamento mais elevada, ainda que seja em apenas 5% do resto, para que possamos ter noção de próximos passos para a melhoria.

# Etapa 5 - Visualizar

Agora vamos visualizar os dados utilizando o Power Bi

Uma descoberta desagradável: não podemos abrir nativamente os arquivos .db com o Power Bi, e teremos que fazer um workaround com um driver ODBC para a SQLite. Créditos para esses usuários do forum power Bi:

https://community.powerbi.com/t5/Power-Query/connecting-a-SQLite-database/td-p/224205

Utilizando o método acima, conseguimos carregar o banco de dados. Conferindo a exibição de modelo, vemos que o Power Bi criou corretamente os relacionamentos:

![image_1749317776014_0](https://github.com/user-attachments/assets/799ee8e0-78f1-4ca1-ba0e-6b043674dbfa)


Mas vimos que valor_frete, que era para estar como um número décimal, não está (ele deveria estar com o mesmo símbolo de Sigma que está ao lado do id_frete). Vamos usar o Power Query para fazer isso, o que é bem simples:

A primeira alteração que faremos é a substituição dos pontos por vírgulas:

![image_1749334733645_0](https://github.com/user-attachments/assets/5ce29a30-d0ce-431e-8ff1-18feb2d71728)

A segunda é a transformação do tipo dos dados, de texto para números com casas decimais:

![image_1749334778387_0](https://github.com/user-attachments/assets/0522df18-3306-4727-8fdf-a3c42fa9b5a5)


Uma alteração que fiz também foi a criação de uma nova coluna na tabela fretes, tempo_entrega_dias, que, como o nome já diz, calcula o tempo de entrega em dias. Para isso, usamos a Linguagem DAX:

```dax
tempo_entrega_dias = DATEDIFF(fretes[data_saida], fretes[data_entrega], DAY)
```

Vamos precisar também de outras medidas criadas na Linguagem DAX para fazermos os nossos cálculos: a % de entregas atrasadas e a % de entregas canceladas.

```dax
porcentagem_atrasada = 
DIVIDE(
    CALCULATE(COUNTROWS(fretes), fretes[status_entrega] = "Atrasado"),
    COUNTROWS(fretes)
)
```

```dax
porcentagem_cancelada = 
DIVIDE(
    CALCULATE(COUNTROWS(fretes), fretes[status_entrega] = "Cancelado"),
    COUNTROWS(fretes)
)
```

A primeira página do dashboard contém, como o nome diz, a análise de desempenho logístico por transportadora.

![Uploading image_1749407589641_0.png…]()


Podemos, com ela, responder as cinco perguntas que definimos no começo do projeto, e além disso, fazer uma análise de desempenho não só por transportadora, como também por mês. As caixas seletoras abaixo servem como filtros adicionais.

Já a segunda página contém uma análise do desempenho logístico por clientes e setor.

![Uploading image_1749407676974_0.png…]()

Podemos, com ela, responder múltiplas perguntas sobre clientes e diferentes setores da economia.
