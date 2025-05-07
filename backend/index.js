// backend/index.js - Backend com SQL Server

const express = require('express');
const sql = require('mssql');
const cors = require('cors');
require('dotenv').config();

const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json());

// Teste de conexão ao banco de dados
app.get('/test', (req, res) => {
    sql.connect(config)
      .then(() => {
        res.json({ message: 'Conexão com o banco de dados bem-sucedida!' });
      })
      .catch((err) => {
        res.status(500).json({ message: 'Erro ao conectar ao banco de dados', error: err.message });
      });
  });
  
// Configuração do SQL Server com suporte a autenticação por usuário/senha ou Windows
const config = {
    server: process.env.DB_SERVER || 'localhost',
    database: process.env.DB_DATABASE || 'pizzaria',
    ...(process.env.DB_USER && process.env.DB_PASSWORD
        ? {
              user: process.env.DB_USER,
              password: process.env.DB_PASSWORD
          }
        : {
              options: {
                  trustedConnection: true
              }
          }),
    options: {
        ...((process.env.DB_USER && process.env.DB_PASSWORD) ? {} : { trustedConnection: true }),
        trustServerCertificate: true
    }
};

// LOGIN
app.post('/login', async (req, res) => {
    const { cpf, nome } = req.body;

    try {
        await sql.connect(config);

        const result = await sql.query`SELECT * FROM usuarios WHERE cpf = ${cpf}`;
        let usuario;

        if (result.recordset.length > 0) {
            usuario = result.recordset[0];
        } else {
            const insert = await sql.query`INSERT INTO usuarios (cpf, nome) OUTPUT INSERTED.* VALUES (${cpf}, ${nome})`;
            usuario = insert.recordset[0];
        }

        res.status(200).json(usuario);
    } catch (err) {
        console.error(err);
        res.status(500).json({ mensagem: 'Erro no login' });
    }
});

// PRODUTOS
app.get('/produtos', async (req, res) => {
    try {
        await sql.connect(config);
        const result = await sql.query`SELECT * FROM produtos`;
        res.status(200).json(result.recordset);
    } catch (err) {
        console.error(err);
        res.status(500).json({ mensagem: 'Erro ao buscar produtos' });
    }
});

// CRIAR PEDIDO
app.post('/pedidos', async (req, res) => {
    const { usuario_id, itens } = req.body;

    if (!usuario_id || !Array.isArray(itens) || itens.length === 0) {
        return res.status(400).json({ mensagem: 'Dados inválidos' });
    }

    try {
        await sql.connect(config);
        const pedido = await sql.query`INSERT INTO pedidos (usuario_id) OUTPUT INSERTED.id VALUES (${usuario_id})`;
        const pedidoId = pedido.recordset[0].id;

        for (const item of itens) {
            await sql.query`INSERT INTO pedido_itens (pedido_id, produto_id, quantidade) VALUES (${pedidoId}, ${item.produto_id}, ${item.quantidade})`;
        }

        res.status(201).json({ mensagem: 'Pedido criado com sucesso', pedidoId });
    } catch (err) {
        console.error(err);
        res.status(500).json({ mensagem: 'Erro ao criar pedido' });
    }
});

app.listen(PORT, () => {
    console.log(`Servidor rodando em http://localhost:${PORT}`);
});