var mysql = require('mysql');

const connectionConfig = {
    host: 'localhost',
    port: '3306',
    user: 'root',
    password: 'mfl123',
    database: 'easycode',
};

export default mysql.createConnection(connectionConfig);