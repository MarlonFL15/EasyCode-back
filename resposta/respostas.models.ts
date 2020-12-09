import connection from '../common/bd/connection'
import { resolve } from 'path';
import { Console } from 'console';
import Conquistas from '../Conquista/conquista.models'
export default class Resposta{

    static insert(connection, obj) {

        let query = `INSERT INTO respostaquestao
        (codigo, idQuestao, idUsuario,dataEnvio, correto, roleta) VALUES(
        '${obj.xml}', 
        ${obj.idQuestao}, 
        ${obj.idUsuario},
        NOW(),
        ${obj.correto},
        ${obj.roleta}
        )`;
        return new Promise((resolve, reject) => {
            connection.query(query, (err, result) => {
                if (err) {
                    console.log(err);
                    reject(err);
                }       
                query = `select * from respostaquestao where idQuestao=${obj.idQuestao} and  idusuario=${obj.idUsuario};`
                connection.query(query, (err, result) => {
                    if(result.length == 1){
                        query = `update usuario set pontuacao=pontuacao+${obj.pontuacao} where id= ${obj.idUsuario}`
                        connection.query(query, (err, result) => {
                            console.log(err)
                        })
                    }
                })
                resolve(result.insertId);

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
            
            let total = 0
            let acertos = 0
            Object.values(obj.respostas).map(e => {
                total += 1
                if(e.correto)
                    acertos+=1
            })
            const query = `insert into form(idUsuario, assunto, dataCriacao, percentual) values(${obj.idUsuario}, '${obj.assunto}', NOW(), ${obj.percentual})`;
           
            connection.query(query, (err, result) => {
                if (err) {
                    console.log(err);
                    reject(err);
                }
                let idForm = result.insertId
                resolve(result.insertId);
                let query = `update usuario set pontuacao=pontuacao+${acertos/total*100} where  id=${obj.idUsuario};`
                connection.query(query, (err, result) => {
                    
                })
              
            });
            

        })
    }

    static getTabelasVerdadeByUser(connection, id){
        const query = `
        select t.nome, t.nivel,  DATE_FORMAT(tu.dataresposta, "%Y-%m-%d %H:%i:%s" ) as datacriacao  from tabela_verdade t inner join tabela_verdade_usuario tu on t.id = tu.idquestao
        where tu.idusuario=${id} order by tu.dataresposta desc;
        `
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
    static getQuestoesByUser(connection, id){
        const query = `select q.assunto, r.id as id, 1 as tipo, r.correto, DATE_FORMAT(r.dataenvio, "%Y-%m-%d %H:%i:%s" ) as datacriacao, q.titulo
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
        const query = `select 2 as tipo, q.assunto, q.percentual, DATE_FORMAT(q.datacriacao, "%Y-%m-%d %H:%i:%s" ) as datacriacao  from form q
        where q.idusuario=${id};`
        // const query = `
        // select f.id as id, 2 as tipo, count(*) as questoes, sum(correto) as certas, DATE_FORMAT(f.datacriacao, "%Y-%m-%d %H:%i:%s" ) as datacriacao, f.assunto
        // from form_pergunta 
        // inner join form f on f.id=idform 
        // where f.idusuario=${id} group by idForm 
        // order by datacriacao desc;`
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
        const query = `select * from questao where id=${id}`;
        return new Promise((resolve, reject) => {
            connection.query(query, (err, result) => {
                if(err){
                    console.log(err)
                    reject(err)
                }
                resolve(result[0])
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

