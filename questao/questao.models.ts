import connection from '../common/bd/connection'

export default class Pergunta {
    static index(connection) {
        const query = `SELECT * FROM questao`;
        return new Promise((resolve, reject) => {
            connection.query(query, (err, result) => {
                if (err) reject(err);
                resolve(result);
            });
        });
    }
    static indexById(connection, id) {
        const query = `SELECT * FROM questao WHERE id = ${id};`;
        return new Promise((resolve, reject) => {
            connection.query(query, (err, result) => {
                if (err) reject(err);
                else{
                    const questao = result[0]
                    const query = `SELECT * FROM exemploQuestao WHERE idQuestao = ${id};`;
                    connection.query(query, (err, result) => {
                        questao.exemplos = result

                        resolve(questao)
                    })
                }
                
            });
        });
    }
    static show(connection, id) {
        const query = `SELECT * FROM questao WHERE id = ${id};`;
        return new Promise((resolve, reject) => {
            connection.query(query, (err, results, fields) => {
                if (err) {
                    reject(err);
                    return;
                }
                resolve(results);
            });
        });
    }
}