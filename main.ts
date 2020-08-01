import {Server} from './server/server'
import {perguntasRouter} from './questao/questao.router'
import {respostaRouter} from './resposta/respostas.router'
import {usuarioRouter} from './Usuario/usuario.router'
const server = new Server()

server.bootstrap([perguntasRouter,respostaRouter, usuarioRouter]).then(server=>{
    console.log('Server is linstening', server.application.address())
    console.log('foi')
}).catch(error=>{
    console.log('Server failed to start')
    console.error(error)
    process.exit(1)
})




