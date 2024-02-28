({
    addAutocompleteToFields : function(component, event, helper) {
        var inputFields = document.querySelectorAll('input');
        
        inputFields.forEach(function(inputField) {
            inputField.setAttribute('autocomplete', 'on');
        });
    },
    
    recordController : function(component, event, helper) {
        var esuccess = $A.get("e.force:showToast");
        esuccess.setParams({
            title: 'Success',
            message: 'Record has been Created successfully!!!',
            type: 'info'
        });
        esuccess.fire();
    }
})
