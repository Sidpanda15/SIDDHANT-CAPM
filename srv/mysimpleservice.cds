using{ siddhant.db.master , siddhant.db.transaction} from '../db/datamodel';
service Mysrvdemo {

    function myFunction(msg:  String) returns String;
    // controllin gthe CURDQ operation by my own 

@readonly
entity ReadEmployeeSrv as projection on master.employees;
@insertonly
entity InsertEmployeeSrv as projection on master.employees;
@updateonly
entity UpdateEmployeeSrv as projection on master.employees;
@deleteonly
entity DeleteEmployeeSrv as projection on master.employees;
}