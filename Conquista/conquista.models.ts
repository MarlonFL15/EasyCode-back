import { isDate } from 'util';

export default class conquista {
    
    static findAll(connection) {
        const query = `SELECT titulo, descricao, id FROM conquista`;
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
    static insertConquistaUser(connection, obj) {
        const query = `insert into conquistaUsuario values(${obj.idUsuario}, ${obj.idConquista})`;
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
    static findByUser(connection, id) {
        const query = `select c.titulo, c.id from conquista c, conquistaUsuario cu where idUsuario=${id} and cu.idConquista=c.id`;
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

}