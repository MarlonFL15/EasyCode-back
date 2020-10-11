import {Router} from '../common/router'
import * as restify from 'restify'
import connection from '../common/bd/connection'
import Tabela from './tabela-verdade.models'

class TabelaRouter extends Router{
    applyRoutes(application: restify.Server){
        application.get('/tabelas-verdade/:id', (req,resp,next)=>{
            Tabela.findAll(connection, req.params.id).then(result=>{
                resp.json(result)
                return next()
            })
        })
        application.get('/tabela-verdade/:id', (req,resp,next)=>{
            Tabela.index(connection, req.params.id).then(result=>{
                resp.json(result)
                return next()
            })
        })
        application.post('/tabela-verdade', (req,resp,next)=>{
            console.log(req.body)
            Tabela.insert(connection, req.body).then(result=>{
                resp.json(result)
                return next()
            })
        })
    }
}
export const tabelaVerdadeRouter = new TabelaRouter()