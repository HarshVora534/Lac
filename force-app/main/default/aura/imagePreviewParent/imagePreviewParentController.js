({
    handleUploadComplete : function(component, event, helper) {
        var imageURL = event.getParam("imageURL");
        component.set("v.imageURL", imageURL);
    }
})
