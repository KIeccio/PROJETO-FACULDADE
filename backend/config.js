// config.js
module.exports = {
    user: 'kleccio',        // Substitua com seu usuário do SQL Server
    password: 'Corinthians2012@',      // Substitua com sua senha do SQL Server
    server: 'localhost',        // Ou IP do servidor onde está o SQL Server
    database: 'pizzaria',  // Substitua com o nome do seu banco de dados
    options: {
      encrypt: true, // Defina como true se estiver utilizando criptografia (SSL)
      trustServerCertificate: true // Para ignorar o erro de certificado autoassinado
    }
  };
  