CREATE TABLE transportadoras (
    id_transportadora   INTEGER PRIMARY KEY,
    nome_transportadora TEXT    NOT NULL,
    categoria           TEXT    NOT NULL
                                CHECK (categoria IN ('Própria', 'Terceirizada')) 
);

CREATE TABLE clientes (
    id_cliente   INTEGER PRIMARY KEY,
    nome_cliente TEXT    NOT NULL,
    cidade       TEXT    NOT NULL,
    setor        TEXT    NOT NULL
);

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