var mysql = require('mysql');

const connectionConfig = {
    host: 'localhost',
    port: '3306',
    user: 'root',
    password: '',
    database: 'easycode',
    multipleStatements: true
};

export default mysql.createConnection(connectionConfig);