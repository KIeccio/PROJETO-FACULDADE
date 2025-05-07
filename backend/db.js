const sql = require('mssql');
require('dotenv').config();

const config = {
  server: process.env.DB_SERVER,
  database: process.env.DB_DATABASE,
  port: parseInt(process.env.DB_PORT),
  options: {
    encrypt: false,  // Desabilitar criptografia se não necessário
    trustServerCertificate: true
  }
};

// Se estiver usando autenticação do Windows
if (process.env.DB_TRUSTED_CONNECTION === 'true') {
  config.options.trustedConnection = true;
  config.authentication = {
    type: 'ntlm',
    options: {
      domain: '',  // Pode deixar vazio se for máquina local
      userName: '', // Não precisa passar se for sua conta do Windows
      password: ''  // Idem
    }
  };
} else {
  config.user = process.env.DB_USER;
  config.password = process.env.DB_PASSWORD;
}

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
