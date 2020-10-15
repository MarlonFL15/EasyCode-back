import {Router} from '../common/router'
import * as restify from 'restify'
import connection from '../common/bd/connection'
import Conquista from './conquista.models'
import { resolve } from 'path'

class ConquistaRouter extends Router{
    applyRoutes(application: restify.Server){
        application.get('/conquistas', (req,resp,next)=>{
            Conquista.findAll(connection).then(result=>{
                resp.json(result)
                return next()
            }).catch(e => {
                resp.json(e)
                return next()
            })
        }),
        application.post('/insertConquista', (req,resp,next)=>{
            Conquista.insertConquistaUser(connection, req.body).then(result=>{
                resp.json(result)
                return next()
            }).catch(e => {
                resp.json(e)
                return next()
            })
        }),
        application.get('/getConquistas/:id', (req,resp,next)=>{
            Conquista.findByUser(connection, req.params.id).then(result=>{
                resp.json(result)
                return next()
            }).catch(e => {
                resp.json(e)
                return next()
            })
        })
    }
}
export const conquistaRouter = new ConquistaRouter()