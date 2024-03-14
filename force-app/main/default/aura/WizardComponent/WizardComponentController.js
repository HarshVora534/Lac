({
    init: function(component, event, helper) {
        // Initialize the component
    },
    
    nextStep: function(component, event, helper) {
        var currentStep = component.get("v.currentStep");
        currentStep++;
        component.set("v.currentStep", currentStep);
    },
    
    previousStep: function(component, event, helper) {
        var currentStep = component.get("v.currentStep");
        currentStep--;
        component.set("v.currentStep", currentStep);
    },
    
    handleAccountSuccess: function(component, event, helper) {
        component.set("v.accountId", event.getParam("accountId"));
        this.nextStep(component);
    },
    
    handleContactSuccess: function(component, event, helper) {
        component.set("v.contactId", event.getParam("contactId"));
        this.nextStep(component);
    },
    
    handleEventSuccess: function(component, event, helper) {
        component.set("v.eventId", event.getParam("eventId"));
        component.set("v.isSaveDisabled", true); // Disable the Save button after event creation
    }
})
