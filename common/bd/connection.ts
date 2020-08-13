var mysql = require('mysql');

const connectionConfig = {
    host: 'localhost',
    port: '3306',
    user: 'root',
    password: 'root',
    database: 'easycode',
};

export default mysql.createConnection(connectionConfig);