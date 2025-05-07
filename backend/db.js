const sql = require('mssql');
require('dotenv').config();

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

sql.connect(config)
    .then(pool => {
        // A conexão foi bem-sucedida, você pode executar consultas agora
        console.log('Conexão com o banco de dados bem-sucedida!');
        return pool.request().query('SELECT * FROM produtos');
    })
    .then(result => {
        console.log(result);
    })
    .catch(err => {
        console.error('Erro ao conectar com o banco de dados:', err);
    });
    
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
