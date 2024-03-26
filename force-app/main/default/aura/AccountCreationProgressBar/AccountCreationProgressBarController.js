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
//         var eventDetails = component.get("v.eventDetails");
//         var action = component.get("c.createEventRecord");
//         action.setParams({
//             "eventDetails": eventDetails,
//             "recordId": component.get("v.recordId")
//         });
//         action.setCallback(this, function(response){
//             // handle response here
//         });
//         $A.enqueueAction(action);
//     }
// })


// ({
//     init: function(component, event, helper) {
//         // Initialization logic here
//         // You can perform any initialization tasks here if needed
//     },
//     previousStep: function(component, event, helper) {
//         // Logic to navigate to previous step
//         var currentStep = component.get("v.currentStep");
//         if (currentStep > 1) {
//             component.set("v.currentStep", currentStep - 1);
//         }
//     },
//     nextStep: function(component, event, helper) {
//         // Logic to navigate to next step
//         var currentStep = component.get("v.currentStep");
//         if (currentStep < 3) {
//             component.set("v.currentStep", currentStep + 1);
//         }
//     },
//     saveEvent: function(component, event, helper) {
//         // Logic to save the event
//         // You can implement the logic to save the event record here
//         // For example, you can use lightning:recordEditForm to handle record submission
//         var recordEditForm = component.find('recordEditForm');
//         recordEditForm.submit();
//     }
// })


({
    init : function(component, event, helper) {
        component.set("v.currentStep", 1); 
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
        var action = component.get("c.createEventRecord");
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS") {
                console.log("Event created successfully.");
            } else if(state === "ERROR") {
                var errors = response.getError();
                if(errors) {
                    if(errors[0] && errors[0].message) {
                        console.error("Error message: " + errors[0].message);
                    }
                } else {
                    console.error("Unknown error.");
                }
            }
        });
        $A.enqueueAction(action);
    }
})
