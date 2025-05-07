IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'pizzaria')
BEGIN
    CREATE DATABASE pizzaria;
END
GO

USE pizzaria;
GO

-- Tabela de usuários
CREATE TABLE usuarios (
    id INT IDENTITY(1,1) PRIMARY KEY,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    nome VARCHAR(50) NOT NULL
);

-- Tabela de categorias
CREATE TABLE categorias (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(30) NOT NULL
);

-- Tabela de produtos
CREATE TABLE produtos (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    imagem VARCHAR(255),
    categoria_id INT NOT NULL,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

-- Tabela de pedidos
CREATE TABLE pedidos (
    id INT IDENTITY(1,1) PRIMARY KEY,
    usuario_id INT NOT NULL,
    data_pedido DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- Tabela de itens de pedido
CREATE TABLE pedido_itens (
    id INT IDENTITY(1,1) PRIMARY KEY,
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT DEFAULT 1,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

-- Inserir categorias
INSERT INTO categorias (nome) VALUES 
('Pizzas'), 
('Esfihas'), 
('Refrigerantes');

-- Inserir produtos
INSERT INTO produtos (nome, imagem, categoria_id) VALUES
('Calabresa', '/Imagens/Pizzas/Calabresa.png', 1),
('Brócolis c/ Bacon', '/Imagens/Pizzas/Brocolis Com Bacon.png', 1),
('Quatro Queijos', '/Imagens/Pizzas/4 Queijos.png', 1),
('Frango c/ Catupiry', '/Imagens/Pizzas/Frango Com Catupiry.jpeg', 1),
('Portuguesa', '/Imagens/Pizzas/Portuguesa.png', 1),

('Carne', '/Imagens/Esfihas/Carne.png', 2),
('Queijo', '/Imagens/Esfihas/QUEIJO.jpeg', 2),
('Calabresa', '/Imagens/Esfihas/Calabresa.png', 2),

('Coca-Cola', '/Imagens/Refrigerantes/COCA.png', 3),
('Fanta', '/Imagens/Refrigerantes/FANTA.jpg', 3),
('Guaraná', '/Imagens/Refrigerantes/GUARANA.png', 3),
('Pepsi', '/Imagens/Refrigerantes/PEPSI.jpeg', 3);

-- Inserir um usuário fictício
INSERT INTO usuarios (cpf, nome) VALUES ('12345678901', 'João da Silva');

-- Inserir um pedido desse usuário
INSERT INTO pedidos (usuario_id) VALUES (1);

-- Inserir itens ao pedido
INSERT INTO pedido_itens (pedido_id, produto_id, quantidade) VALUES 
(1, 1, 2),  -- 2 Calabresa
(1, 10, 1); -- 1 Fanta
