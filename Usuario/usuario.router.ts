import {Router} from '../common/router'
import * as restify from 'restify'
import connection from '../common/bd/connection'
import Usuario from './usuario.models'

class UsuarioRouter extends Router{
    applyRoutes(application: restify.Server){
        application.post('/login', (req,resp,next)=>{
            Usuario.login(connection,req.body).then(result=>{
                
                if(result == 0){
                    resp.json({result:false})
                }
                else
                    resp.json({result:result})
                
                return next()
            }).catch(e => {
                resp.json(e)
                return next()
            })
        }),
        application.post('/addUser', (req,resp,next)=>{
            // if(Usuario.login(connection, req.body))
            Usuario.add(connection,req.body).then(result=>{
                resp.json(result)
                return next()
            }).catch(e => {
                resp.json(e)
                return next()
            })
        }),
        application.get('/users', (req,resp,next)=>{
            Usuario.index(connection).then(result=>{
                resp.json(result)
                return next()
            }).catch(e => {
                resp.json(e)
                return next()
            })
        }),
        application.post('/getUserEmail', (req,resp,next)=>{
            Usuario.getUserByEmail(connection,req.body).then(result=>{
            
                if(result == 0){
                    resp.json({result:false})
                }
                else
                    resp.json({result:true})
                
                return next()
            }).catch(e => {
                resp.json(e)
                return next()
            })
        }),

        application.get('/getUserById/:id', (req, resp, next) => {
            Usuario.getUserById(connection, req.params.id).then(result => {
                resp.json(result)
                return next()
            }).catch(e => {
                resp.json(e)
                return next()
            })

        })
        application.post('/getUserGoogle', (req,resp,next)=>{
            Usuario.getUserByGoogle(connection,req.body).then(result =>{
                
                let list =  <Array<any>>result;
                let leng:number = list.length
                if(leng == 0){
                   
                    resp.json({result:false})
                }
                else{
                    
                    resp.json({result:result})
                }
                return next()
            }).catch(e => {
                resp.json(e)
                return next()
            })
        }),
        application.del('/deleteUser', (req,resp,next)=>{
            Usuario.delete(connection,req.body).then(result=>{
               
                if(result == 0){
                    resp.json({result:false})
                }
                else
                    resp.json({result:true})
                
                return next()
            }).catch(e => {
                resp.json(e)
                return next()
            })
        }),
        application.put('/updateUser', (req,resp,next)=>{
            Usuario.update(connection,req.body).then(result=>{
                
                if(result == 0){
                    resp.json({result:false})
                }
                else
                    resp.json({result:true})
                
                return next()
            }).catch(e => {
                resp.json(e)
                return next()
            })
        })
    }
}
export const usuarioRouter = new UsuarioRouter()