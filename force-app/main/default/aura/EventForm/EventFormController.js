({
    saveEvent: function(component, event, helper) {
        var subject = component.find("subjectField").get("v.value");
        var contactId = component.get("v.contactId");

        var action = component.get("c.createEvent");
        action.setParams({
            "subject": subject,
            "contactId": contactId
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var eventId = response.getReturnValue();
                var event = component.getEvent("onSuccess");
                event.setParams({ "eventId": eventId });
                event.fire();
            } else if (state === "ERROR") {
            }
        });
        $A.enqueueAction(action);
    }
})