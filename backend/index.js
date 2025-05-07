const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const { sql, pool, poolConnect } = require('./db');

const app = express();
app.use(cors());
app.use(bodyParser.json());

const PORT = 3000;

// Login
app.post('/login', async (req, res) => {
  const { cpf, nome } = req.body;

  if (!cpf || !nome) return res.status(400).json({ error: 'CPF e nome são obrigatórios' });

  try {
    await poolConnect;
    const result = await pool.request()
      .input('cpf', sql.VarChar, cpf)
      .query('SELECT * FROM usuarios WHERE cpf = @cpf');

    if (result.recordset.length > 0) {
      res.json({ mensagem: 'Login bem-sucedido', usuario: result.recordset[0] });
    } else {
      const insert = await pool.request()
        .input('cpf', sql.VarChar, cpf)
        .input('nome', sql.VarChar, nome)
        .query('INSERT INTO usuarios (cpf, nome) OUTPUT INSERTED.id VALUES (@cpf, @nome)');

      res.json({
        mensagem: 'Usuário criado com sucesso',
        usuario: { id: insert.recordset[0].id, cpf, nome }
      });
    }
  } catch (err) {
    res.status(500).json({ error: 'Erro no login', detalhes: err.message });
  }
});

// Buscar produtos
app.get('/produtos', async (req, res) => {
  try {
    await poolConnect;
    const result = await pool.request().query(`
      SELECT p.*, c.nome AS categoria
      FROM produtos p
      JOIN categorias c ON p.categoria_id = c.id
    `);
    res.json(result.recordset);
  } catch (err) {
    res.status(500).json({ error: 'Erro ao buscar produtos', detalhes: err.message });
  }
});

// Criar pedido
app.post('/pedido', async (req, res) => {
  const { usuario_id, itens } = req.body;

  if (!usuario_id || !Array.isArray(itens)) {
    return res.status(400).json({ error: 'Dados inválidos para o pedido' });
  }

  try {
    await poolConnect;
    const pedido = await pool.request()
      .input('usuario_id', sql.Int, usuario_id)
      .query('INSERT INTO pedidos (usuario_id) OUTPUT INSERTED.id VALUES (@usuario_id)');

    const pedidoId = pedido.recordset[0].id;

    for (const item of itens) {
      await pool.request()
        .input('pedido_id', sql.Int, pedidoId)
        .input('produto_id', sql.Int, item.produto_id)
        .input('quantidade', sql.Int, item.quantidade || 1)
        .query('INSERT INTO pedido_itens (pedido_id, produto_id, quantidade) VALUES (@pedido_id, @produto_id, @quantidade)');
    }

    res.json({ mensagem: 'Pedido criado com sucesso', pedido_id: pedidoId });
  } catch (err) {
    res.status(500).json({ error: 'Erro ao criar pedido', detalhes: err.message });
  }
});

app.listen(PORT, () => {
  console.log(`Servidor rodando em http://localhost:${PORT}`);
});
