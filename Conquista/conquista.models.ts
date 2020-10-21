import { resolve } from 'path';
import { isDate } from 'util';
import { Z_BEST_COMPRESSION } from 'zlib';

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
    static index(connection, id) {
        const query = `SELECT titulo, descricao, id FROM conquista where id=${id}`;
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
        let query = `insert into conquistaUsuario values(${obj.idUsuario}, ${obj.idConquista})`;
        return new Promise((resolve, reject) => {
            connection.query(query, (err, result) => {
                if (err) {
                    console.log(err);
                    reject(err);
                }
                let query = `select * from conquista where id=${obj.idConquista};`
                connection.query(query, (err, result) => {
                    console.log(query)
                    console.log(result)
                    const pontos = result[0].pontuacao
                    query = `update usuario set pontuacao=pontuacao+${pontos} where id=${obj.idUsuario};`
                    connection.query(query, (err, result) => {
                        console.log(err)
                    })
                })
                resolve(result);
            });
        });
    }
    static findByUser(connection, id) {
        const query=`select * from conquista c
        left join (select * from conquistausuario where idusuario=${id}) 
        uc on uc.idconquista=c.id;
        `
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

    static checkConquista(connection, idUsuario, idConquista) {

        const query=`select * from conquistausuario where idUsuario=${idUsuario} and idConquista=${idConquista}`
        console.log(query)
        return new Promise((resolve, reject) => {
            connection.query(query, (err, result) => {
                if (err) {
                    console.log(err);
                    reject(err);
                }
                resolve(result.length == 0 ? false:true);
            });
        });
    }

    static checkConquistasQuestoes(connection, idQuestao, idUser, idRespostaQuestao){
        const conquistas = []
        return new Promise((resolve, reject) => {
            let query=[
                `select * from respostaquestao where idquestao=1 and idusuario=${idUser};`,
                `select * from questao where id=${idQuestao};`,
                `select count(*) as total, q.assunto from respostaquestao rq inner join questao q on q.id=rq.idquestao where rq.idusuario=${idUser} group by q.assunto;`,
                `select count(*) as total from respostaquestao rq inner join questao q on rq.idquestao=q.id where rq.idusuario=${idUser} and rq.id!=${idRespostaQuestao} group by idQuestao;`,
                `select count(*) as total from respostaquestao rq inner join questao q on rq.idquestao=q.id where rq.idusuario=${idUser} group by idQuestao;`,
                `select count(*) from respostaquestao where roleta=1 and id != ${idRespostaQuestao} group by idQuestao;`,
                `select count(*) from respostaquestao where roleta=1 group by idQuestao;`
            ]
            
            connection.query(query.join(''), (err, results)=> {
                
                if(results[0].length == 1 && idQuestao==1){
                    conquistas.push(1)
                }
    
                const data=results[1][0]
                let zero=false
    
                results[2].forEach(element => {
                    if(element.assunto == data.assunto){
                    if(element.total-1 == 0)
                            zero=true
                    }
                });
                if(zero && results[2].length == 5){
                    conquistas.push(7)
                }
                if(results[3].length == 9 && results[4].length == 10){
                    conquistas.push(11)
                }
                if(results[5].length == 2 && results[6].length == 3){
                    conquistas.push(9)
                }
                resolve(conquistas)
            })
        })
        
    }

    static checkConquistasQuiz(connection, idform, idusuario) {
        const conquistas=[]
        let query = [
            `select * from form where idUsuario=${idusuario};`,
            `select * from form where percentual=100;`,
            `select * from form where percentual=100 and id!=${idform};`
        ]

        return new Promise((resolve, reject) =>{
            connection.query(query.join(''), (err, results) => {
                console.log(err)
                if(results[0].length == 1)
                    conquistas.push(2)
                if(results[0].length == 10)
                    conquistas.push(13)
                if(results[1].length == 1 && results[2].length == 0)
                    conquistas.push(6)
                resolve(conquistas)
            })
        })

    }

    static checkConquistasTabelaVerdade(connection, idsolucao, idusuario) {
        const conquistas=[]
        let query = [
            `select * from tabela_verdade_usuario where idUsuario=${idusuario};`,
            `select * from tabela_verdade_usuario tvu inner join tabela_verdade tv on tv.id=tvu.idquestao where idUsuario=${idusuario} and nivel='Muito Difícil' and tvu.id!=${idsolucao};`,
            `select * from tabela_verdade_usuario tvu inner join tabela_verdade tv on tv.id=tvu.idquestao where idUsuario=${idusuario} and nivel='Muito Difícil';`, 
            `select count(*) from tabela_verdade_usuario tvu inner join tabela_verdade tv on tv.id=tvu.idquestao where idUsuario=${idusuario} group by idQuestao;`,
            `select count(*) from tabela_verdade_usuario tvu inner join tabela_verdade tv on tv.id=tvu.idquestao where idUsuario=${idusuario} and tvu.id!=${idsolucao} group by idQuestao;`
        ]
        
        return new Promise((resolve, reject) =>{
            connection.query(query.join(''), (err, results) => {
                //console.log(results)
                /**Verificando a primeira conquista */
                console.log(results[0].length)
                if(results[0].length == 1)
                    conquistas.push(4)
                

                if(results[1].length == 0 && results[2].length == 1)
                    conquistas.push(14)

             
                if(results[3].length == 10 && results[4].length == 9)
                    conquistas.push(12)

                resolve(conquistas)
            })
        })

    }
    static deleteByUser(connection, id){
        const query = `delete from conquistausuario where idUsuario=${id}`
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