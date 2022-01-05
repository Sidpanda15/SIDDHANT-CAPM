const cds = require('@sap/cds');
const {employees}= cds.entities("siddhant.db.master");

const Mysrvdemo = function(srv) {
        srv.on('myFunction', (req, res) => {
            return "hello " + req.data.msg;
        });
    srv.on("READ","ReadEmployeeSrv", async(req,res)=>{
        var results =[];
        //    results.push({
        //        "ID" : "02BD2137-0890-1EEA-A6C2-BB55C19787FB",
        //        "nameFirst": "Ananaya",
        //        "nameLast": "Vishwanathan"
        //    });

        // 1. CDS Query language - SELECT * FROM
        // results = await cds.tx(req).run(SELECT.from(employees));

        // 2.  CDS Query lang - for gtting single record with condition (using of where)
        // results = await cds.tx(req).run(SELECT.from(employees).where({
        //     "nameFirst":"Franco"
        // }));

        // 3.When some user pass any key e.g: /entity/key
        var whereCondition = req.data;
        if(whereCondition.hasOwnProperty("ID")){
            results = await cds.tx(req).run(SELECT.from(employees).where(whereCondition));
        }else{
            results = await cds.tx(req).run(SELECT.from(employees).limit(1));
        }
      return results;
    });
   
  srv.on("CREATE","InsertEmployeeSrv", async(req,res)=>{
      let returnData = await cds.transaction(req).run
      ([
          INSERT.into(employees).entries([req.data])
      ]).then((resolve,reject)=>{
          if(typeof(resolve)!==undefined){
              return req.data
          }else{
              req.error(500,"there is some isssue");
          }
      }).catch(err=>{
          req.error(500,"there was an issue"+err.toString());
      });
      return returnData;
  })
   
  srv.on("UPDATE","UpdateEmployeeSrv", async(req,res)=>{
      let returnData = await cds.transaction(req).run([

          UPDATE(employees).set({
              nameFirst : req.data.nameFirst
          }).where({ID : req.data.ID}),

          UPDATE(employees).set({
              nameLast : req.data.nameLast
          }).where({ID : req.data.ID})

      ]).then((resolve,reject)=>{
           if(typeof(resolve) !== undefined){
               return req.data;
           }else{
               req.error(400,"There is a issue in your update");
           }
      }).catch(err=>{
          req.error(400,"something went wrong"+err.toString());
      });
      return returnData;
  })


srv.on("DELETE","DeleteEmployeeSrv",async(req,res)=>{
    let returnData = await cds.transaction(req).run([
        DELETE(employees).where(req.data)
    ]).then((resolve,reject)=>{
        if(typeof(resolve) !== undefined){
            return req.data;
        }else{
            req.error(300,"there is an issue in Delete");
        }
    }).catch(err=>{
        req.error(400,"Something is wrong in delete"+err.toString());
    });
    return returnData;
});


}

module.exports = Mysrvdemo;