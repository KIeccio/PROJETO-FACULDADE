const sql = require('mssql');
require('dotenv').config();

const config = {
  server: process.env.DB_SERVER,
  database: process.env.DB_DATABASE,
  port: parseInt(process.env.DB_PORT) || 1433,  // Define porta padrão caso não esteja no .env
  options: {
    encrypt: true,
    trustServerCertificate: true  // Aceita certificado autoassinado
  },
  authentication: {
    type: 'ntlm', // Autenticação do Windows
    options: {
      userName: '',  // Em branco usa conta atual do Windows
      password: '',
      domain: ''     // Em branco assume domínio atual
    }
  }
};

const pool = new sql.ConnectionPool(config);
const poolConnect = pool.connect();

process.on('exit', () => {
  sql.close();
});

module.exports = {
  sql,
  pool: poolConnect,
  poolConnect
};
