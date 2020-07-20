import * as restify from 'restify'
import {environment} from '../common/environment'
import {Router} from '../common/router'
import * as mongoose from 'mongoose'
import * as corsMiddleware from "restify-cors-middleware";  

export class Server{
    
    application :restify.Server


    initRoutes(routers: Router[] = []) : Promise<any>{
        return new Promise((resolve,reject)=>{
          try{
            this.application = restify.createServer({
                name:'meat-api',
                version: '1.0.0'
            })
            
            const corsOptions: corsMiddleware.Options={
                preflightMaxAge:10,
                origins: ['*'],
                allowHeaders: ['X-Requested-With, Access-Control-Allow-Origin, Content-Type, Access-Control-Allow-Methods, Accept, Authorization'],
                exposeHeaders: ['x-custom-header'],
            }
            const cors: corsMiddleware.CorsMiddleware = corsMiddleware(corsOptions);

            this.application.pre(cors.preflight)
            this.application.use(cors.actual)
            this.application.use(restify.plugins.queryParser())
            this.application.use(restify.plugins.bodyParser())
            //routes
            for(let router of routers){
                router.applyRoutes(this.application)
            }
            this.application.listen(3001, ()=>{
                resolve(this.application)
                console.log('Listen localhost')
            })
          }catch(error){
              reject(error)
          }
        })

      
    }

    bootstrap(routers: Router[] = []):Promise<Server>{
        return this.initRoutes(routers).then(()=>this)
    }
}
const server = restify.createServer({
    name:'auditoria-api',
    version: '1.0.0'
})


server.use(restify.plugins.queryParser())

server.listen(3002, ()=>{
    console.log('APi is running on http://localhost:3001')
})