import connection from '../common/bd/connection'
import { resolve } from 'path';
export default class Resposta{

    static insert(connection, obj) {

        const query = `INSERT INTO respostaquestao
        (codigo, idQuestao, idUsuario,dataEnvio, correto) VALUES(
        '${obj.xml}', 
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

    static sendQuiz(connection, obj){
        return new Promise((resolve, reject) => {
            const query = `insert into form(idUsuario, assunto, dataCriacao) values(${obj.idUsuario}, '${obj.assunto}', NOW())`;
           
            connection.query(query, (err, result) => {
                if (err) {
                    console.log(err);
                    reject(err);
                }
                let idForm = result.insertId

                obj.respostas.forEach(element => {
                    let query = `insert into form_pergunta(idPergunta, idForm, respostausuario, correto) values
                    (${element.id}, ${idForm}, '${element.respostaUsuario}', ${element.correto})`
                    
                    connection.query(query, (err, result) => {
                        if (err) {
                            console.log(err);
                            reject(err);
                        }
                        resolve(result);
                    });
                });

              
            });
            

        })
    }
    static getQuestoesByUser(connection, id){
        const query = `select r.id as id, 1 as tipo, r.correto, DATE_FORMAT(r.dataenvio, "%Y-%m-%d %H:%i:%s" ) as datacriacao, q.titulo
        from respostaquestao r
        inner join questao q on q.id=r.idquestao
        where idusuario=${id} order by r.dataenvio desc;`;
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
    static getQuizByUser(connection, id){
        const query = `select f.id as id, 2 as tipo, count(*) as questoes, sum(correto) as certas, DATE_FORMAT(f.datacriacao, "%Y-%m-%d %H:%i:%s" ) as datacriacao, f.assunto
        from form_pergunta 
        inner join form f on f.id=idform 
        where f.idusuario=${id} group by idForm 
        order by datacriacao desc;`
        //const query = `select * from respostaQuestao where idUsuario=${id}`;
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
    static getCodigoById(connection, id){
        const query = `select * from respostaquestao where id=${id}`;
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

    static getRespostasByQuiz(connection, id){
        return new Promise((resolve, reject) => {

            const query = `select p.*, correto from pergunta p inner join form_pergunta fp on p.id=fp.idPergunta where fp.idform=${id};`;
        
            connection.query(query, (err, result) => {
                if (err){
                    console.log(err)
                    reject(err);
                } 
                else{

                    result.forEach((element,index) => {

                        const query = `SELECT alternativa FROM alternativa where idPergunta = ${element.id} order by rand()`
                        connection.query(query, (err, result2) =>{
                            
                            result[index].alternativas = result2
                            if(index == result.length -1){
                                
                                resolve(result);
                            }
                        })

                    }); 
                   
                }
            });
        })

    }
    
}

