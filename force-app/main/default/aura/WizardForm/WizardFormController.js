({
    init: function(component, event, helper) {
        component.set("v.step", 1); // Initialize step to 1 when the component loads
    },
    nextStep : function(component, event, helper) {
        var currentStep = component.get("v.step");
        if(currentStep === 1) {
            helper.createAccount(component);
        } else if(currentStep === 2) {
            helper.createContact(component);
        }
        component.set("v.step", currentStep + 1);
    },
    previousStep : function(component, event, helper) {
        var currentStep = component.get("v.step");
        component.set("v.step", currentStep - 1);
    },
    saveEvent : function(component, event, helper) {
        var eventObj = component.get("v.event");
        eventObj.Subject = "Wizard Task";
        helper.createEvent(component, eventObj);
    }
})
