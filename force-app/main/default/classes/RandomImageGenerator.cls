// public with sharing class RandomImageGenerator {
//         @future(callout=true)
//         public static void makeCallout(){
//             Http http = new Http();
//             HttpRequest req = new HttpRequest();
//             req.setEndpoint('https://api.unsplash.com/photos/random/oauth/authorize');
//             req.setMethod('GET');
//             HTTPResponse res=http.send(req);
//             if(res.getStatusCode() == 200)
//             {
//                 System.debug(res.getBody());
//             }
//             else {
//                 System.debug('ERROR');
//             }
//         }
// }

// public with sharing class RandomImageGenerator {
    
//     @future(callout=true)
//     public static void makeCallout(Id opportunityId){
//         Http http = new Http();
//         HttpRequest req = new HttpRequest();
//         req.setEndpoint('https://api.unsplash.com/photos/random');
//         req.setMethod('GET');
//         req.setHeader('Authorization', 'Client-ID <hSYIgxivyBRORVd6ZKKXTsMX7L1-Z5TJOTAmh194l7s>'); 
//         HTTPResponse res = http.send(req);
        
//         if(res.getStatusCode() == 200) {
//             Map<String, Object> responseData = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
//             String imageUrl = (String) responseData.get('urls');
            
//             if(imageUrl != null) {
//                 Attachment attachment = new Attachment();
//                 attachment.Name = 'Random Image';
//                 attachment.Body = Blob.valueOf(imageUrl);
//                 attachment.ParentId = opportunityId;
//                 insert attachment;
//             }
//         } else {
//             System.debug('ERROR: Failed to fetch random image');
//         }
//     }
    
//     @AuraEnabled
//     public static void addRandomImage(Id opportunityId) {
//         makeCallout(opportunityId);
//     }
// }

public with sharing class RandomImageGenerator {
    
    @AuraEnabled
    public static String makeCallout(){
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.unsplash.com/photos/random');
        req.setMethod('GET');
        req.setHeader('Authorization', 'Client-ID hSYIgxivyBRORVd6ZKKXTsMX7L1-Z5TJOTAmh194l7s');
        
        try {
            HTTPResponse res = http.send(req);
            if(res.getStatusCode() == 200) {
                Map<String, Object> responseData = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                return (String) ((Map<String, Object>) responseData.get('urls')).get('regular');
            } else {
                System.debug('ERROR: Failed to fetch random image. Status code: ' + res.getStatusCode());
                return null;
            }
        } catch (Exception e) {
            System.debug('ERROR: Exception occurred while making API callout: ' + e.getMessage());
            return null;
        }
    }
    
    @AuraEnabled
    public static String addRandomImage() {
        return makeCallout();
    }
}
