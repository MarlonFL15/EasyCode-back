/*var sql = require('mssql')

const connectionConfig = {
    server: 'localhost',
    user: 'sa',
    password: 'cthm@flex2019',
    database: 'formaudi',
};

sql.connect(connectionConfig);

export default function runQuery(query) {
    // sql.connect() will return the existing global pool if it exists or create a new one if it doesn't
    return sql.connect().then((pool) => {
      return pool.query(query)
    })
  }
*/