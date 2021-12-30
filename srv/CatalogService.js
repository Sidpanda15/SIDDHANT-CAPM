module.exports = cds.service.impl(async function(){

    const{
        EmployeeSet
    }=this.entities

    this.before('UPDATE',EmployeeSet,(req,res)=>{
       if(parseFloat(req.data.salaryAmount) >=1000000){
           req.error(300,"Sorry this salary amount is not acceptable in our system");
       }
    });
});