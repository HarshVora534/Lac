({
    getContacts: function(component) {
        var action = component.get("c.getContacts");
        var pageSize = component.get("v.pageSize");
        var currentPage = component.get("v.currentPage");
        var accountId = component.get("v.accountId");
        var searchTerm = component.get("v.searchTerm");
        
        action.setParams({
            "accountId": accountId,
            "pageSize": pageSize,
            "pageNumber": currentPage,
            "searchTerm": searchTerm
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                component.set("v.contacts", result.contacts);
                component.set("v.totalPages", Math.ceil(result.totalContacts / pageSize));
            } else {
                console.error("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    }
})
