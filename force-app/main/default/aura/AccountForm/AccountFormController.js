// ({
//     doSave : function(component, event, helper) {
//         var action=component.get("c.createContact");
//         action.setParams({'contObj':component.get('v.contactObj')});
//         action.setCallback(this,function(data)
//         {
//             component.set('v.contactId',data.getReturnValue())
//         });
//     $A.enqueueAction(action);
//     }
// })

// ({
//     doSave : function(component, event, helper) {
//         var action = component.get("c.createContact");
//         action.setParams({'contObj': component.get('v.contactObj')});
//         action.setCallback(this, function(response) {
//             var state = response.getState();
//             if (state === "SUCCESS") {
//                 component.set('v.contactId', response.getReturnValue());
//             } else if (state === "ERROR") {
//                 var errors = response.getError();
//                 if (errors) {
//                     for (var i = 0; i < errors.length; i++) {
//                         console.error("Error message: " + errors[i].message);
//                     }
//                 } else {
//                     console.error("Unknown error");
//                 }
//             }
//         });
//         $A.enqueueAction(action);
//     }
// })

({

    doInit : function(component, event, helper) {

        var action = component.get('c.getPickList');

        action.setParams({

            objName : component.get('v.objName'),

            fldName : component.get('v.fldName')

        });

        action.setCallback(this,function(result){

            var resultValue = result.getReturnValue();

            component.set('v.ratingList',resultValue);

        });

        $A.enqueueAction(action);

    },

    doSave : function(component, event, helper) {

        var action = component.get('c.createAccount');

        action.setParams({

            ac : component.get('v.createAcc')

        });

        action.setCallback(this,function(result){

            var getAllValue = component.get('v.createAcc');

            alert(JSON.stringify(getAllValue));

        });

        $A.enqueueAction(action);

    },

    docancel : function(component, event, helper) {

        component.set('v.createAcc','');

    },

})

// ({
//     saveAccount : function(component, event, helper) {
//         var name = component.get("v.name");
//         var email = component.get("v.email");

//         var action = component.get("c.saveAccount");
//         action.setParams({
//             "name": name,
//             "email": email
//         });

//         action.setCallback(this, function(response) {
//             var state = response.getState();
//             if (state === "SUCCESS") {
//                 component.set("v.name", "");
//                 console.log('-->',v.name);
//                 component.set("v.email", "");
//                 console.log('-->',v.email);
//             }
//             else {
//                 console.log('Error occurred: ' + response.getError()[0].message);
//             }
//         });

//         $A.enqueueAction(action);
//     }
// })
