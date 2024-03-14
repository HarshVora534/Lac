({
    createAccount : function(component, event, helper) {
        var newAccount = component.get("v.account");
        var action = component.get("c.createAccount");

        action.setParams({ "account": newAccount });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var accountId = response.getReturnValue();
                component.set("v.accountId", accountId);
                alert("Account created successfully!");
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    console.log("Error message: " + errors[0].message);
                } else {
                    console.log("Unknown error");
                }
            }
        });

        $A.enqueueAction(action);
    }
})
