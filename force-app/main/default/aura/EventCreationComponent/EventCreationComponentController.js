({
    createEvent : function(component, event, helper) {
        var eventDetails = component.get("v.eventDetails");
        var action = component.get("c.createEventRecord");
        action.setParams({
            "eventDetails": eventDetails,
            "recordId": component.get("v.recordId")
        });
        action.setCallback(this, function(response){
            // handle response here
        });
        $A.enqueueAction(action);
    }
})
