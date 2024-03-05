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
    
    handleAccountSuccess : function(component, event, helper) {
        var accountId = event.getParam("response").id;
        component.set("v.accountId", accountId);
    },
    
    handleContactLoad : function(component, event, helper) {
        var contactForm = component.find("contactForm");
        var accountId = component.get("v.accountId");
        if (accountId) {
            contactForm.set("v.fields.AccountId", accountId);
        }
    },
    
    saveEvent : function(component, event, helper) {
        var contactId = component.get("v.contactId");
        var eventRecord = component.find("eventForm").get("v.record");
        eventRecord.fields.Subject = "Wizard Task";
        eventRecord.fields.WhoId = contactId;
        component.find("eventForm").saveRecord($A.getCallback(function(saveResult) {
            if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                // Handle success or draft state
                console.log("Event saved successfully!");
            } else if (saveResult.state === "INCOMPLETE") {
                // Handle incomplete state
                console.log("User is offline, device doesn't support drafts.");
            } else if (saveResult.state === "ERROR") {
                // Handle error state
                console.log('Problem saving event, error: ' + JSON.stringify(saveResult.error));
            } else {
                console.log('Unknown problem, state: ' + saveResult.state + ', error: ' + JSON.stringify(saveResult.error));
            }
        }));
    }
})
