// sap.ui.define([
//     "sap/ui/base/ManagedObject"
// ], function(
//     ManagedObject
// ) {
//     "use strict";

//     return ManagedObject.extend("undefined", {});
// });
const Mysrvdemo = function(srv) {
    srv.on('myFunction', (req, res) => {
        return "hello " + req.data.msg;
    });
}

module.exports = Mysrvdemo;