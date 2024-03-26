({
    createAccount : function(component) {
        var account = component.get("v.account");
        var action = component.get("c.saveAccount");
        action.setParams({ "acc": account });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("Account created successfully");
            } else {
                console.log("Failed to create account");
            }
        });
        $A.enqueueAction(action);
    },
    createContact : function(component) {
        var contact = component.get("v.contact");
        var action = component.get("c.saveContact");
        action.setParams({ "con": contact });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("Contact created successfully");
            } else {
                console.log("Failed to create contact");
            }
        });
        $A.enqueueAction(action);
    },
    createEvent : function(component, eventObj) {
        var action = component.get("c.saveEvent");
        action.setParams({ "evt": eventObj });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("Event created successfully");
            } else {
                console.log("Failed to create event");
            }
        });
        $A.enqueueAction(action);
    }
})
