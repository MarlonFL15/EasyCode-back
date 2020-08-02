import {Router} from '../common/router'
import * as restify from 'restify'
import connection from '../common/bd/connection'
import Usuario from './usuario.models'

class UsuarioRouter extends Router{
    applyRoutes(application: restify.Server){
        application.post('/login', (req,resp,next)=>{
            Usuario.login(connection,req.body).then(result=>{
                console.log(typeof(result))
                if(result == 0){
                    resp.json({result:false})
                }
                else
                    resp.json({result:true})
                
                return next()
            })
        }),
        application.post('/addUser', (req,resp,next)=>{
            // if(Usuario.login(connection, req.body))
            Usuario.add(connection,req.body).then(result=>{
                resp.json(result)
                return next()
            })
        }),
        application.get('/users', (req,resp,next)=>{
            Usuario.index(connection).then(result=>{
                resp.json(result)
                return next()
            })
        }),
        application.post('/getUserEmail', (req,resp,next)=>{
            Usuario.getUserByEmail(connection,req.body).then(result=>{
                console.log(typeof(result))
                if(result == 0){
                    resp.json({result:false})
                }
                else
                    resp.json({result:true})
                
                return next()
            })
        }),
        application.post('/getUserGoogle', (req,resp,next)=>{
            Usuario.getUseByGoogle(connection,req.body).then(result=>{
                console.log(typeof(result))
                if(result == 0){
                    resp.json({result:false})
                }
                else
                    resp.json({result:true})
                
                return next()
            })
        })
    }
}
export const usuarioRouter = new UsuarioRouter()