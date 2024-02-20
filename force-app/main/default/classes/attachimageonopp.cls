global class AttachImageOnOpp {
    @future(callout=true)
    public static void attachImageOnOpp() {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://th.bing.com/th/id/OIP.YjJSBQVO5Cy9RBxwNqfj7AHaJ5?rs=1&pid=ImgDetMain');
        req.setMethod('GET');
        
        HttpResponse response = http.send(req);
        if(response.getStatusCode() == 200) {
            Attachment attachment = new Attachment();
            attachment.Name = 'RandomImage.jpg';
            attachment.Body = response.getBodyAsBlob();
            attachment.ParentId = 'OpportunityId'; 
            insert attachment;
        } else {
            System.debug('Failed to get the image from the URL: ' + response.getBody());
        }
    }
}

// 
// 
