({
    doInit : function(component, event, helper) {
        var action = component.get("c.getAccountsWithOpportunitiesAndContacts");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.accountWrappers", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    }
})
