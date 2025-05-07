require('dotenv').config();
const express = require('express');
const sql = require('mssql');
const app = express();
app.use(express.json());

// Configuração de conexão com o banco de dados usando autenticação do Windows
const config = {
  server: process.env.DB_SERVER,
  database: process.env.DB_DATABASE,
  options: {
    encrypt: false,  // Desabilitar criptografia se não necessário
    trustServerCertificate: true // Desabilitar verificação de certificado SSL
  },
  // Usando autenticação do Windows
  options: {
    trustedConnection: true,  // Autenticação do Windows
  }
};

// Conectar ao banco de dados uma vez e reutilizar a conexão
let poolPromise = sql.connect(config);

// Rota de login
app.post('/login', async (req, res) => {
  const { cpf, nome } = req.body;

  try {
    const pool = await poolPromise;
    const result = await pool.request()
      .input('cpf', sql.VarChar(11), cpf)
      .query('SELECT * FROM usuarios WHERE cpf = @cpf');
    
    let usuario;

    if (result.recordset.length > 0) {
      usuario = result.recordset[0];
    } else {
      const insert = await pool.request()
        .input('cpf', sql.VarChar(11), cpf)
        .input('nome', sql.VarChar(50), nome)
        .query('INSERT INTO usuarios (cpf, nome) OUTPUT INSERTED.* VALUES (@cpf, @nome)');
      usuario = insert.recordset[0];
    }

    res.status(200).json(usuario);
  } catch (err) {
    console.error('Erro ao fazer login:', err);
    res.status(500).json({ mensagem: 'Erro no login' });
  }
});

// Rota de produtos
app.get('/produtos', async (req, res) => {
  try {
    const pool = await poolPromise;
    const result = await pool.request().query('SELECT * FROM produtos');
    res.status(200).json(result.recordset);
  } catch (err) {
    console.error('Erro ao buscar produtos:', err);
    res.status(500).json({ mensagem: 'Erro ao buscar produtos' });
  }
});

// Rota para criar pedido
app.post('/pedidos', async (req, res) => {
  const { usuario_id, itens } = req.body;

  if (!usuario_id || !Array.isArray(itens) || itens.length === 0) {
    return res.status(400).json({ mensagem: 'Dados inválidos' });
  }

  try {
    const pool = await poolPromise;

    // Inserir o pedido
    const pedido = await pool.request()
      .input('usuario_id', sql.Int, usuario_id)
      .query('INSERT INTO pedidos (usuario_id) OUTPUT INSERTED.id VALUES (@usuario_id)');
    
    const pedidoId = pedido.recordset[0].id;

    // Inserir os itens do pedido
    for (const item of itens) {
      await pool.request()
        .input('pedido_id', sql.Int, pedidoId)
        .input('produto_id', sql.Int, item.produto_id)
        .input('quantidade', sql.Int, item.quantidade)
        .query('INSERT INTO pedido_itens (pedido_id, produto_id, quantidade) VALUES (@pedido_id, @produto_id, @quantidade)');
    }

    res.status(201).json({ mensagem: 'Pedido criado com sucesso', pedidoId });
  } catch (err) {
    console.error('Erro ao criar pedido:', err);
    res.status(500).json({ mensagem: 'Erro ao criar pedido' });
  }
});

// Configuração do servidor
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor rodando em http://localhost:${PORT}`);
});
