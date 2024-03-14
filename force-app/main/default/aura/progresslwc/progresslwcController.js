({
    nextStep: function(component, event, helper) {
        var next = "s4";
        component.set("v.current", next);
    },
    
    addError: function(component, event, helper) {
        component.set("v.hasError", true);
    }    
})