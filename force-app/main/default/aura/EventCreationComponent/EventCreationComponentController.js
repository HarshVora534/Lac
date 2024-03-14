// ({
//     createEvent : function(component, event, helper) {
//         var eventDetails = component.get("v.eventDetails");
//         var action = component.get("c.createEventRecord");
//         action.setParams({
//             "eventDetails": eventDetails,
//             "recordId": component.get("v.recordId")
//         });
//         action.setCallback(this, function(response){
//             // handle response here
//         });
//         $A.enqueueAction(action);
//     }
// })


({
    createEvent : function(component, event, helper) {
        var eventDetails = component.get("v.eventDetails");
        var action = component.get("c.createEventRecord");
        action.setParams({
            "eventDetails": eventDetails,
            "recordId": component.get("v.recordId")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("Event created successfully");
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    console.error("Error creating event: " + errors[0].message);
                } else {
                    console.error("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    }
})