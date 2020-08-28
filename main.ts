import {Server} from './server/server'
import {questoesRouter} from './Questao/questao.router'
import {respostaRouter} from './Resposta/respostas.router'
import {usuarioRouter} from './Usuario/usuario.router'
import {conquistaRouter} from './Conquista/conquista.router'
import {perguntasRouter} from './Quiz/quiz.router'
const server = new Server()

server.bootstrap([perguntasRouter, conquistaRouter,questoesRouter,respostaRouter, usuarioRouter]).then(server=>{
    console.log('Server is linstening', server.application.address())
    console.log('foi')
}).catch(error=>{
    console.log('Server failed to start')
    console.error(error)
    process.exit(1)
})




