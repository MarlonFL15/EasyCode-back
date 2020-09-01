import connection from '../common/bd/connection'

export default class Pergunta {
    static index(connection) {
        const query = `SELECT * FROM pergunta`;
        return new Promise((resolve, reject) => {
            connection.query(query, (err, result) => {
                if (err) reject(err);
                resolve(result);
            });
        });
    }

    static getQuizByAssunto(connection, assunto, idUsuario) {
        return new Promise((resolve, reject) => {

            const query = `SELECT * FROM pergunta where assunto = '${assunto}' order by rand() limit 2;`;
        
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
        });
    }



}