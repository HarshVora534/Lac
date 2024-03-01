({
    init: function(component, event, helper) {
        helper.getContacts(component);
    },

    previousPage: function(component, event, helper) {
        component.set("v.currentPage", component.get("v.currentPage") - 1);
        helper.getContacts(component);
    },

    nextPage: function(component, event, helper) {
        component.set("v.currentPage", component.get("v.currentPage") + 1);
        helper.getContacts(component);
    },

    search: function(component, event, helper) {
        component.set("v.currentPage", 1);
        helper.getContacts(component);
    }
})