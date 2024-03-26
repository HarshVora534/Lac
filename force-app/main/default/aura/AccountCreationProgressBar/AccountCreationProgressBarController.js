// ({
//     init : function(component, event, helper) {
//         component.set("v.currentStep", 1); 
//     },

//     previousStep : function(component, event, helper) {
//         var currentStep = component.get("v.currentStep");
//         if (currentStep > 1) {
//             component.set("v.currentStep", currentStep - 1);
//         }
//     },

//     nextStep : function(component, event, helper) {
//         var currentStep = component.get("v.currentStep");
//         if (currentStep < 3) {
//             component.set("v.currentStep", currentStep + 1);
//         }
//     },

//     createEvent : function(component, event, helper) {
//         var fieldsevent = component.get("v.fieldsevent");
//         console.log('-->hello',fieldsevent);
//         console.log('--->');
//         var action = component.get("c.createEventRecord");
//         console.log('-->get',action);
//         action.setParams({
//             "fieldsevent": fieldsevent,
//             "recordId": component.get("v.recordId")
//         });
//         action.setCallback(this, function(response){
//             var state = response.getState();
//             console.log('-->Success');
//             if (state === "SUCCESS") {
//                 console.log("Event created successfully");
//             } else if (state === "ERROR") {
//                 var errors = response.getError();
//                 if (errors) {
//                     console.error("Error creating event: " + errors[0].message);
//                 } else {
//                     console.error("Unknown error");
//                 }
//             }
//         });
//         $A.enqueueAction(action);
//     }
// })

// ({
//     init : function(component, event, helper) {
//         component.set("v.currentStep", 1); 
//         component.set("v.contactId", component.get("v.recordId"));
//     },

//     previousStep : function(component, event, helper) {
//         var currentStep = component.get("v.currentStep");
//         if (currentStep > 1) {
//             component.set("v.currentStep", currentStep - 1);
//         }
//     },

//     nextStep : function(component, event, helper) {
//         var currentStep = component.get("v.currentStep");
//         if (currentStep < 3) {
//             component.set("v.currentStep", currentStep + 1);
//         }
//     },

//     createEvent : function(component, event, helper) {
//         var fieldsevent = component.get("v.fieldsevent");
//         console.log(fieldsevent);
//         console.log(component.get("v.recordId"));
//         var action = component.get("c.createEventRecord");
//         action.setParams({
//             "fieldsevent": fieldsevent,
//             "recordId": component.get("v.recordId")
//         });
//         action.setCallback(this, function(response){
//             var state = response.getState();
//             if (state === "SUCCESS") {
//                 console.log("Event created successfully");
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
    init : function(component, event, helper) {
        component.set("v.currentStep", 1); 
        component.set("v.contactId", component.get("v.recordId"));
    },

    previousStep : function(component, event, helper) {
        var currentStep = component.get("v.currentStep");
        if (currentStep > 1) {
            component.set("v.currentStep", currentStep - 1);
        }
    },

    nextStep : function(component, event, helper) {
        var currentStep = component.get("v.currentStep");
        if (currentStep < 3) {
            component.set("v.currentStep", currentStep + 1);
        }
    },

    createEvent : function(component, event, helper) {
        var fieldsevent = component.get("v.fieldsevent");
        console.log(fieldsevent);
        console.log(component.get("v.recordId"));
        var action = component.get("c.createEventRecord");
        action.setParams({
            "fieldsevent": fieldsevent,
            "recordId": component.get("v.recordId")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            console.log(state);
            if (state === "SUCCESS") {
                console.log("Event created successfully");
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    for (var i = 0; i < errors.length; i++) {
                        console.error("Error message: " + errors[i].message);
                    }
                } else {
                    console.error("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    }
})