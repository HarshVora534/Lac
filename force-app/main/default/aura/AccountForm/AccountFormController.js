({
    onSuccess: function(component, event, helper) {
        var payload = event.getParams().response;
        var accountId = payload.id;
        var event = component.getEvent("onSuccess");
        event.setParams({ "accountId": accountId });
        event.fire();
    }
})