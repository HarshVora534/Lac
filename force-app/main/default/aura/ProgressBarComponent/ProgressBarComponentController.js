({
    incrementProgress : function(component, event, helper) {
        var currentProgress = component.get("v.progress");
        if (currentProgress < 100) {
            component.set("v.progress", currentProgress + 10); 
        }
    },
    
    decrementProgress : function(component, event, helper) {
        var currentProgress = component.get("v.progress");
        if (currentProgress > 0) {
            component.set("v.progress", currentProgress - 10); 
        }
    }
})
