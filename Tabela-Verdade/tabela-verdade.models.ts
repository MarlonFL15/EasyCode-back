import { isDate } from 'util';

export default class conquista {
    
    static findAll(connection, idUsuario) {
        const query = `
        SELECT t.id, t.nome, t.nivel, t.descricao, t.url, idUsuario from tabela_verdade t
        left join (select * from tabela_verdade_usuario where idUsuario=${idUsuario}) tu on tu.idquestao=t.id
        group by t.id;`;

        
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

    static index(connection, id){
        const query = `SELECT * from tabela_verdade where id=${id}`;
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
    
    static insert(connection, obj){
        const query = `insert into tabela_verdade_usuario(idUsuario, idQuestao, dataresposta)
        values(${obj.idUsuario}, ${obj.idQuestao}, NOW())`;
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