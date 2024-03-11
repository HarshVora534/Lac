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
        var eventDetails = component.get("v.eventDetails");
        var action = component.get("c.createEventRecord");
        action.setParams({
            "eventDetails": eventDetails,
            "recordId": component.get("v.recordId")
        });
        action.setCallback(this, function(response){
            // handle response here
        });
        $A.enqueueAction(action);
    }
})
