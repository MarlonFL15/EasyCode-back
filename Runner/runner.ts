import { execSync } from "child_process";
import { resolve } from "path";
import { rejects } from "assert";
import { Resolver } from "dns";

const fs = require('fs')
const  Promise = require('bluebird');
export default class Runner {
   
  static judge(examples, code) {
    return new Promise((resolve, reject) => {
      const promises = []
      fs.writeFileSync(`file.py`,code)

      for (var i = 0; i < examples.length ; i++) {
        const file = fs.writeFileSync(`entrada${i}.txt`, examples[i].entrada)
        promises.push(this.run(examples[i].saida, i))
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


    static run(resp, index){
        return new Promise((resolve, reject) => {
          var child;
          var exec = require('child_process').exec;
          exec(`python file.py < entrada${index}.txt`, function(error, stdout, stderr){
            stdout = stdout.substring(0,stdout.length-1)
            
            resolve({index:stdout===resp})
          });

        })
        
      
      
         
  }
}
   
  