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

    static getCountEnvios(connection, id) {
        const query = `select (
            select count(*) 
            from form f2 
            where CAST(f2.datacriacao as date) <=  CAST(f1.datacriacao as date) and f2.idusuario=${id}
        ) as total, DATE_FORMAT(f1.datacriacao, "%m-%d-%Y") as data 
        from form f1
        where f1.idusuario=${id}
        group by cast(f1.datacriacao as date)
        order by cast(f1.datacriacao as date) asc limit 7;`
        console.log(query)
        return new Promise((resolve, reject) => {
            connection.query(query, (err, result) => {
                if (err) reject(err);
                resolve(result);
            });
        });
    }

    static getPontuacaoByUsuario(connection, id){
        const query = `select sum(correto) as certas, p.assunto, count(*) as total
        from pergunta p 
        inner join (
            select fp.* 
            from form_pergunta fp, pergunta p 
            where p.id=fp.idpergunta 
            group by fp.idpergunta
        ) fp on fp.idpergunta=p.id
        inner join form f on f.id=fp.idform
        where f.idusuario=${id}
        group by p.assunto;`
        return new Promise((resolve, reject) => {
            connection.query(query, (err, result) => {
                if (err) reject(err);
                const obj = {}
                result.forEach(element => {
                    obj[element.assunto] = element.certas / element.total * 100
                });
                resolve(obj);
            });
        });
    }

    static getQuizByAssunto(connection, assunto, idUsuario) {
        return new Promise((resolve, reject) => {

            const query = `SELECT * FROM pergunta where assunto = '${assunto}' order by rand();`;
        
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