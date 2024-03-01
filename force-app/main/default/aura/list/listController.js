({
    doInit : function(component, event, helper) {
        var action = component.get("c.getContacts");
        action.setParams({ AccountId: 'yourAccountIdHere' }); // Specify the AccountId as needed
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.contacts", response.getReturnValue());
            } else {
                console.error("Error fetching contacts");
            }
        });
        $A.enqueueAction(action);
    }
})
