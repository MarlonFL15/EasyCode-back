import connection from '../common/bd/connection'
import { resolve } from 'path';
export default class Resposta{

    static insert(connection, obj) {

        const query = `INSERT INTO respostaquestao
        (codigo, idQuestao, idUsuario,dataEnvio, correto) VALUES(
        "${obj.code}", 
        ${obj.idQuestao}, 
        ${obj.idUsuario},
        NOW(),
        ${obj.correto}
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

    static getByUser(connection, id){
        const query = `select * from respostaQuestao where idUsuario=${id}`;
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

