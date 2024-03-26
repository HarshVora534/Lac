({
    createContactAndEvent: function(component, event, helper) {
        var action = component.get("c.createContactAndEvent");
        var con = component.get("v.con");
        var fieldsevent = {
            "Subject": component.get("v.fieldsevent.Subject"),
            "StartDateTime": component.get("v.fieldsevent.StartDateTime")
        };
        action.setParams({
            "con": con,
            "fieldsevent": fieldsevent
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("Contact and Event created successfully");
            } else {
                console.error("Error creating Contact and Event: ", response.getError());
            }
        });
        $A.enqueueAction(action);
    }
})
