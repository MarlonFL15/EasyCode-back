import { isDate } from 'util';

export default class usuario {
    static index(connection) {
        const query = 'SELECT * FROM usuario;';
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
        const query = `INSERT INTO usuario(email, senha, nome) VALUES('${usuario.email}', '${usuario.senha}', '${usuario.nome}')`;
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
    static getUserByEmail(connection,usuario) {
        console.log(usuario)
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
    

}