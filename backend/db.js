const sql = require('mssql');
require('dotenv').config();

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

// Criar a conexão com o banco de dados
const pool = new sql.ConnectionPool(config);
const poolConnect = pool.connect();

// Fechar o pool quando o processo terminar
process.on('exit', () => {
  sql.close();
});

module.exports = {
  sql,
  pool: poolConnect,  // Usando o pool de conexão
  poolConnect
};
