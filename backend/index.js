require('dotenv').config();
const express = require('express');
const mssql = require('mssql');
const path = require('path');
const cors = require('cors');

const app = express();
app.use(express.json());
app.use(cors());

// Corrigido: Servindo imagens corretamente
app.use('/imagens', express.static(path.join(__dirname, 'Imagens')));

const config = {
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  server: process.env.DB_SERVER,
  database: process.env.DB_DATABASE,
  port: parseInt(process.env.DB_PORT || '1433'),
  options: {
    encrypt: true,
    trustServerCertificate: true,
  },
};

const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send('API da pizzaria funcionando!');
});

// LOGIN
app.post('/login', async (req, res) => {
  const { cpf, nome } = req.body;

  if (!cpf || !nome) {
    return res.status(400).json({ mensagem: 'CPF e Nome são obrigatórios.' });
  }

  try {
    const pool = await mssql.connect(config);
    const request = pool.request();
    request.input('cpf_param', mssql.VarChar, cpf);
    request.input('nome_param', mssql.VarChar, nome);

    const result = await request.query('SELECT * FROM usuarios WHERE cpf = @cpf_param AND nome = @nome_param');

    if (result.recordset.length > 0) {
      const usuario = result.recordset[0];
      return res.json({ id: usuario.id, nome: usuario.nome });
    }

    await request.query(`INSERT INTO usuarios (cpf, nome) VALUES (@cpf_param, @nome_param);`);
    const novoUsuario = await request.query('SELECT TOP 1 id, nome FROM usuarios WHERE cpf = @cpf_param');
    const usuarioCriado = novoUsuario.recordset[0];

    return res.json({ id: usuarioCriado.id, nome: usuarioCriado.nome });
  } catch (err) {
    console.error('Erro na consulta:', err);
    res.status(500).json({ mensagem: 'Erro interno ao fazer login ou criar usuário.' });
  }
});

// PRODUTOS
app.get('/produtos', async (req, res) => {
  try {
    const pool = await mssql.connect(config);
    const result = await pool.request().query('SELECT * FROM produtos');

    // Corrige caminho da imagem para usar "/imagens" com nome formatado
    const produtosCorrigidos = result.recordset.map(produto => {
      const imagemCorrigida = produto.imagem.replace(/ /g, '-'); // Troca espaços por hífens
      return { ...produto, imagem: imagemCorrigida };
    });

    res.status(200).json(produtosCorrigidos);
  } catch (err) {
    console.error('Erro ao buscar produtos:', err);
    res.status(500).json({ mensagem: 'Erro ao buscar produtos' });
  }
});

// PEDIDOS
app.post('/pedidos', async (req, res) => {
  const { usuario_id, itens } = req.body;

  if (!usuario_id || !Array.isArray(itens) || itens.length === 0) {
    return res.status(400).json({ mensagem: 'Dados inválidos' });
  }

  try {
    const pool = await mssql.connect(config);
    const request = pool.request();
    const pedido = await request.input('usuario_id', mssql.Int, usuario_id)
      .query('INSERT INTO pedidos (usuario_id) OUTPUT INSERTED.id VALUES (@usuario_id)');

    const pedidoId = pedido.recordset[0].id;

    for (const item of itens) {
      await request
        .input('pedido_id', mssql.Int, pedidoId)
        .input('produto_id', mssql.Int, item.produto_id)
        .input('quantidade', mssql.Int, item.quantidade)
        .query('INSERT INTO pedido_itens (pedido_id, produto_id, quantidade) VALUES (@pedido_id, @produto_id, @quantidade)');
    }

    res.status(201).json({ mensagem: 'Pedido criado com sucesso', pedidoId });
  } catch (err) {
    console.error('Erro ao criar pedido:', err);
    res.status(500).json({ mensagem: 'Erro ao criar pedido' });
  }
});

app.listen(PORT, () => {
  console.log(`Servidor rodando em http://localhost:${PORT}`);
});
