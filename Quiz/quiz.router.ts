import {Router} from '../common/router'
import * as restify from 'restify'
import connection from '../common/bd/connection'
import Pergunta from './quiz.models'
import { NodeBaseExport } from 'readable-stream'

class PerguntaRouter extends Router{
    applyRoutes(application: restify.Server){
        
        application.get('/quiz', (req,resp,next)=>{

            Pergunta.getQuizByAssunto(connection, req.query.assunto, req.query.idUsuario).then(response =>{
                resp.json(response)
                return next()
            })
        })
        
    }
}

export const perguntasRouter = new PerguntaRouter()