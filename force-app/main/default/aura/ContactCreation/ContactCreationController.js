({

    
    recordController : function(component, event, helper) {
        var esuccess = $A.get("e.force:showToast");
        esuccess.setParams({
            title: 'Success',
            message: 'Record has been Created successfullyy!!!',
            type: 'info'
        });
        esuccess.fire();
    }
})
