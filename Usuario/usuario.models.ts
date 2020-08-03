import { isDate } from 'util';
import Conquista from '../Conquista/conquista.models'
export default class usuario {
    static index(connection) {
        const query = 'SELECT nome, email, senha FROM usuario;';
        return new Promise((resolve, reject) => {
            connection.query(query, (err, result) => {
                if (err) {
                    console.log(err);
                    reject(err);
                }
                console.log('mds do ceu')
                resolve(result);
            });
        });
    }
    static login(connection,usuario) {
        console.log(usuario)
        const query = `SELECT * FROM usuario WHERE email='${usuario.email}' and senha='${usuario.senha}';`;
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
    static add(connection,usuario) {
        let query='';
        let foto = usuario.foto == null ? null:`'${usuario.foto}'` 
        let pathFoto = usuario.pathFoto == null ? null:`'${usuario.pathFoto}'` 
        let senha = usuario.senha == null ? null:`'${usuario.senha}'` 
        
        query = `INSERT INTO usuario(email, senha, nome, foto, pathFoto, google) VALUES(
            '${usuario.email}', 
            ${senha}, 
            '${usuario.nome}', 
            ${foto} ,
            ${pathFoto}, 
            ${usuario.google})`;
        console.log(usuario)
        return new Promise((resolve, reject) => {
            connection.query(query, (err, result) => {
                if (err) {
                    console.log(err)
                    reject(err);
                }
                resolve(result);
            });
        });
    }
    static getUserByEmail(connection,usuario) {
        const query = `SELECT * FROM usuario WHERE email='${usuario.email}'`;
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

    static getUseByGoogle(connection, usuario) {
        const query = `SELECT * FROM usuario WHERE email='${usuario.email}' and senha=null`;
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

    static delete(connection, obj){
        return new Promise((resolve, reject) => {
            Conquista.deleteByUser(connection, obj.id).then(
                response => {
                    const query =`delete from usuario where id=${obj.id}`
        
                    connection.query(query, (err, result) => {
                        if(err){
                            console.log(err)
                            reject(err)
                        }
                        resolve(result)
                    })
        
                }
            )
        })

    }
    
    static update(connection, obj){
        let foto = obj.foto == null ? null:`'${obj.foto}'` 
        const query =`update usuario set nome='${obj.nome}', foto=${foto}, senha='${obj.senha}' where id=${obj.id}`
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