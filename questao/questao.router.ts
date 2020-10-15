import {Router} from '../common/router'
import * as restify from 'restify'
import connection from '../common/bd/connection'
import Pergunta from './questao.models'
import { NodeBaseExport } from 'readable-stream'

class QuestaoRouter extends Router{
    applyRoutes(application: restify.Server){
        
        application.get('/perguntas', (req,resp,next)=>{
            Pergunta.index(connection).then(result=>{
                resp.json(result)
                return next()
            }).catch(e => {
                resp.json(e)
                return next()
            })
        }),
        application.get('/pergunta/:id', (req,resp,next)=>{
            Pergunta.indexById(connection, req.params.id).then(result=>{
                resp.json(result)
                return next()
            }).catch(e => {
                resp.json(e)
                return next()
            })
        }),
        application.get('/getRoleta', (req, resp, next) => {
            
            Pergunta.getRandomByAssunto(connection, req.query.assunto).then(result => {
                resp.json(result)
                return next()
            }).catch(e => {
                resp.json(e)
                return next()
            })
        }),
        application.get('/getPontuacaoTotal', (req, resp, next) => {
            Pergunta.getPontuacaoTotal(connection).then(result => {
                resp.json(result)
                return next()
            }).catch(e => {
                resp.json(e)
                return next()
            })
        }),
        application.get('/getPontuacaoByUser/:id', (req, resp, next) => {
            Pergunta.getPontuacaoByUsuario(connection, req.params.id).then(result => {
                resp.json(result)
                return next()
            }).catch(e => {
                resp.json(e)
                return next()
            })
        }),
        application.get('/getCountPontuacaoByUser/:id', (req, resp, next) => {
            Pergunta.getCountSubmissoes(connection, req.params.id).then(result => {
                resp.json(result)
                return next()
            }).catch(e => {
                resp.json(e)
                return next()
            })
        })
    }
}

export const questoesRouter = new QuestaoRouter()