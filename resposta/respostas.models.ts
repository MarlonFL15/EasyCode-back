import connection from '../common/bd/connection'
import { resolve } from 'path';
export default class Resposta{

    static insert(connection, req) {

        const query = `INSERT INTO resposta
        (resp, idPergunta, idUsuario,dateResposta) VALUES('${req.resp}', 
        ${req.idPergunta}, 
        ${req.idUsuario},
        '${new Date().toISOString().split('T')[0]}'
        )`;
        return new Promise((resolve, reject) => {
            connection.query(query, (err, result) => {
                if (err) {
                    console.log(err);
                    reject(err);
                }
                resolve(result);
            });
        });
    }

    static index(connection) {
        const query = `select * from resposta`;
        return new Promise((resolve, reject) => {
            connection.query(query, (err, result) => {
                if (err) {
                    console.log(err);
                    reject(err);
                }
                resolve(result);
            });
        });
    }

    static getGabarito(id){
        const query = `select * from exemploQuestao where idQuestao=${id}`;
        return new Promise((resolve, reject) => {
            connection.query(query, (err, result) => {
                if(err){
                    console.log(err)
                    reject(err)
                }
                resolve(result)
            })
        })
    }
}

