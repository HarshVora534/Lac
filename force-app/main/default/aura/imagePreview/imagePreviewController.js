({
    handleFileChange: function (component, event) {
        var fileInput = component.find("fileInput").getElement();
        var file = fileInput.files[0];
        if(file) {
            var reader = new FileReader();
            reader.onloadend = function() {
                var imageURL = reader.result;
                var uploadEvent = component.getEvent("upload");
                uploadEvent.setParams({"imageURL": imageURL});
                uploadEvent.fire();
            };
            reader.readAsDataURL(file);
        }
    }
})
