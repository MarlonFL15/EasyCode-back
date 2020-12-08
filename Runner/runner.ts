import { execSync } from "child_process";
import { resolve } from "path";
import { rejects } from "assert";
import { Resolver } from "dns";

const fs = require('fs')
const path = require('path')
const  Promise = require('bluebird');
export default class Runner {
   
  static judge(question, code) {
    return new Promise((resolve, reject) => {
      const promises = []
      fs.writeFileSync(`file.py`,code)
      
      for (var i = 1; i <= question.qtdTestes ; i++) {
        
        const file = fs.readFileSync(path.join(process.cwd(), `\\Gabarito\\${question.id}\\out${i}.txt`), 'utf-8')
        promises.push(this.run(file, question.id, i))
      }
      Promise.all(promises).then(function (results) {
        var result=true
        results.forEach(element => {
          result = result && element.index
        });
        resolve({result:result})
      });
    
    })
    
  }


    static run(resp, id, index){
        return new Promise((resolve, reject) => {
          var child;
          var exec = require('child_process').exec;
          exec(`python file.py < ${path.join(process.cwd(), `\\Gabarito\\${id}\\in${index}.txt`)}`, function(error, stdout, stderr){
            resolve({index:stdout===resp})
          });

        })
        
      
      
         
  }
}
   
  