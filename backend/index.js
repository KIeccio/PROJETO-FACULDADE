require('dotenv').config();
const mssql = require('mssql');
const express = require('express');
const { sql, poolConnect } = require('./db');

const config = {
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  server: process.env.DB_SERVER,
  database: process.env.DB_DATABASE,
  port: parseInt(process.env.DB_PORT || '1433'),
  options: {
    encrypt: true, // Desativa criptografia
    trustServerCertificate: true // Evita erro com certificados locais
  }
};

const app = express();
app.use(express.json());

const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send('API da pizzaria funcionando!');
});

const cors = require('cors');
app.use(cors());

// LOGIN
app.post('/login', async (req, res) => {
  const { cpf, nome } = req.body;

  if (!cpf || !nome) {
      return res.status(400).json({ mensagem: 'CPF e Nome são obrigatórios.' });
  }

  try {
      const pool = await mssql.connect(config); // Conecta ao banco com as configurações
      const request = pool.request(); // Cria uma nova requisição

      // Corrigindo a duplicidade de parâmetros
      request.input('cpf_param', mssql.VarChar, cpf); // Usando um nome de parâmetro único
      request.input('nome_param', mssql.VarChar, nome); // Usando um nome de parâmetro único

      // Consultar se o usuário já existe
      const result = await request.query('SELECT * FROM usuarios WHERE cpf = @cpf_param AND nome = @nome_param');

      if (result.recordset.length > 0) {
          // Usuário já existe, retorna o usuário
          const usuario = result.recordset[0];
          return res.json({ id: usuario.id, nome: usuario.nome });
      }

      // Se o usuário não existir, cria um novo
      const insertQuery = `
          INSERT INTO usuarios (cpf, nome)
          VALUES (@cpf_param, @nome_param);
      `;

      await request.query(insertQuery); // Executa a inserção

      // Após inserir, buscar o ID do novo usuário
      const novoUsuario = await request.query('SELECT TOP 1 id, nome FROM usuarios WHERE cpf = @cpf_param');
      const usuarioCriado = novoUsuario.recordset[0];

      // Retorna o novo usuário criado
      return res.json({ id: usuarioCriado.id, nome: usuarioCriado.nome });
      
  } catch (err) {
      console.error('Erro na consulta:', err);
      res.status(500).json({ mensagem: 'Erro interno ao fazer login ou criar usuário.' });
  }
});

// PRODUTOS
app.get('/produtos', async (req, res) => {
  try {
    await poolConnect;
    const result = await (await sql.connect())
      .request()
      .query('SELECT * FROM produtos');
    res.status(200).json(result.recordset);
  } catch (err) {
    console.error('Erro ao buscar produtos:', err);
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
    await poolConnect;
    const request = (await sql.connect()).request();

    const pedido = await request
      .input('usuario_id', sql.Int, usuario_id)
      .query('INSERT INTO pedidos (usuario_id) OUTPUT INSERTED.id VALUES (@usuario_id)');

    const pedidoId = pedido.recordset[0].id;

    for (const item of itens) {
      await request
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

app.listen(PORT, () => {
  console.log(`Servidor rodando em http://localhost:${PORT}`);
});
