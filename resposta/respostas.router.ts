import {Router} from '../common/router'
import * as restify from 'restify'
import connection from '../common/bd/connection'
import Resposta from './respostas.models'
import Runner from '../Runner/runner'

class RespostaRouter extends Router{
    applyRoutes(application: restify.Server){
        application.post('/addResposta', (req,resp,next)=>{
            Resposta.insert(connection, req.body).then(result=>{
                resp.json(result)
                return next()
            })
        }),        
        application.get('/getRespostasByUser/:id', (req,resp,next)=>{
            Resposta.getByUser(connection, req.params.id).then(result=>{
                resp.json(result)
                return next()
            })
        }),
        application.post('/submit', (req,resp,next)=>{
            console.log(req.body)
            Resposta.getGabarito(req.body.idQuestao).then(response => {
                const code = req.body.code
                Runner.judge(response, code).then(response => {
                    Resposta.insert(connection, {...req.body, correto:response.result})
                    resp.json({result:response.result})
                    return next()
                })
                return next()
            })
                
        })
    }
}

export const respostaRouter = new RespostaRouter()