({
    nextStep : function(component, event, helper) {
        var currentStep = component.get("v.step");
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
