const sql = require('mssql');
require('dotenv').config();

const config = {
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  server: process.env.DB_SERVER,
  database: process.env.DB_DATABASE,
  port: parseInt(process.env.DB_PORT || '1433'),
  options: {
    encrypt: false, // Desativa criptografia
    trustServerCertificate: true // Evita erro com certificados locais
  }
};

const pool = new sql.ConnectionPool(config);
const poolConnect = pool.connect();

process.on('exit', () => {
  sql.close();
});

module.exports = {
  sql,
  pool,
  poolConnect
};
