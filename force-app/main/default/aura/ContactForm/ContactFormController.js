({
    handleSuccess: function(component, event, helper) {
        var payload = event.getParams().response;
        var contactId = payload.id;
        var event = component.getEvent("onSuccess");
        event.setParams({ "contactId": contactId });
        event.fire();
    }
})