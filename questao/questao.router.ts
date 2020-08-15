import {Router} from '../common/router'
import * as restify from './node_modules/restify'
import connection from '../common/bd/connection'
import Pergunta from './questao.models'
import { NodeBaseExport } from 'readable-stream'

class PerguntaRouter extends Router{
    applyRoutes(application: restify.Server){
        
        application.get('/perguntas', (req,resp,next)=>{
            Pergunta.index(connection).then(result=>{
                resp.json(result)
                return next()
            })
        }),
        application.get('/pergunta/:id', (req,resp,next)=>{
            Pergunta.indexById(connection, req.params.id).then(result=>{
                resp.json(result)
                return next()
            })
        }),
        application.get('/getRoleta', (req, resp, next) => {
            console.log(req.query)
            Pergunta.getRandomByAssunto(connection, req.query.assunto).then(result => {
                resp.json(result)
                return next()
            })
            
        })
        
    }
}

export const perguntasRouter = new PerguntaRouter()