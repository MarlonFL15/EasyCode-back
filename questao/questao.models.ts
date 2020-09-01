import connection from '../common/bd/connection'

export default class Questao {
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

    static getRandomByAssunto(connection, assunto){
        const query = `SELECT * FROM questao WHERE assunto='${assunto}' order by rand() limit 1;`;
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

    static getPontuacaoTotal(connection){
        const query = `select sum(pontos) as total, assunto from questao group by assunto;`;
        return new Promise((resolve, reject) => {
            connection.query(query, (err, results, fields) => {
                if (err) {
                    reject(err);
                    return;
                }
                const obj={}
                results.forEach(element => {
                    obj[element.assunto] = element.total
                });
                resolve(obj);
                //resolve(results);
            });
        }); 
    }

    static getPontuacaoByUsuario(connection, id){
        const query = `select sum(q.pontos) as pontuacao, q.assunto from questao q 
        INNER JOIN (
            select * from respostaquestao where correto=1 and idusuario=${id} group by idQuestao) 
        rq on rq.idQuestao = q.id 
        INNER JOIN Usuario u on rq.idUsuario = u.id where u.id=${id}
        group by q.assunto;`

        return new Promise((resolve, reject) => {
            connection.query(query, (err, results, fields) => {
                if (err) {
                    reject(err);
                    return;
                }
                const obj={}
                results.forEach(element => {
                    obj[element.assunto] = element.pontuacao
                });
                resolve(obj);
            });
        }); 
    }

    static getCountSubmissoes(connection, id){
        const query =  `
            select DATE_FORMAT(rq.dataenvio, "%m-%d-%Y") as data,(    
                select count(*) 
                from respostaquestao rq2 
                where CAST(rq2.dataenvio as date) <=  CAST(rq.dataenvio as date) and
                rq2.correto=1 and rq2.idusuario=${id}
            ) as total
            from respostaquestao rq 
            where rq.idusuario=${id}
            group by cast(rq.dataenvio as date)
            order by cast(rq.dataenvio as date) asc limit 7;`

            return new Promise((resolve, reject) => {
                connection.query(query, (err, results, fields) => {
                    if (err) {
                        reject(err);
                        return;
                    }
                    resolve(results)
                    
                });
            }); 

    }


}