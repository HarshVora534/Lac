// ({
//     createAccount : function(component, event, helper) {
//         var newAccount=component.get("v.newAccount");
//         var action=  component.get("c.saveAccount");
//         action.setParams({
//             "acc":newAccount
//         });
//         action.setCallback(this, function(response)
//         {
//             var state=response.getState();
//             if(state=='SUCCESS')
//             {
//                 var accountId = response.getReturnValue();
//                 var createdAccount = component.get("v.newAccount");
//                 createdAccount.Id = accountId;
//                 console.log('Account created successfully')
//             }
//             else
//             {
//                 console.log('Error Occurred')
//             }
//         });
//         $A.enqueueAction(action);
//     }
// })




({
    createAccount : function(component, event, helper) {
        var newAcc = component.get("v.newAccount");
        var action = component.get("c.saveAccount");
        action.setParams({ 
            "acc": newAcc
        });
        if (callback) {
          action.setCallback(this, callback);
        }
        $A.enqueueAction(action)
    }
})