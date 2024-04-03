// public with sharing class dropbox {
//     @AuraEnabled
//     public static string dropboxfiles(List<String> files){
//         try {
//             for (String file : files) {
//                 System.debug(file);
//                 callout(file);
//             }
//             return 'success';
//         } catch (Exception e) {
//             throw new AuraHandledException(e.getMessage());
//         }
//     }

//     private static void callout(String file){
//         Http http = new Http();
//         HttpRequest req = new HttpRequest();
//         req.setEndpoint('https://content.dropboxapi.com/2/files/upload');
//         req.setMethod('POST');
//         req.setHeader('Authorization','Bearer sl.BypBVisV7f__MjnbaEhR0wXayEcUi_Lgleyy6m6tOE_vVxZs6RWBCejhV2WhhTjz8Upbc0fJNk8jS84AMiuwoLJy0DTY4N8FLjHwLRmGbRvzQWmBtbovQFSVseeVmAJHJ8thUwY3xf_z');
//         try {
//             HttpResponse res = http.send(req);
//             if (res.getStatusCode() == 200) {
//                 System.debug('Successfully Uploaded the File..!!!');
//             } else {
//                 System.debug('ERROR: Failed to upload file Status code: ' + res.getStatusCode());
//             }
//         } catch (Exception e) {
//             System.debug('ERROR: Exception caught while uploading file: ' + e.getMessage());
//         }
//     }
// }


// public with sharing class dropbox {
//     @AuraEnabled
//     public static String dropboxfiles(List<String> files) {
//         try {
//             for (String file : files) {
//                 System.debug(file);
//                 callout(file);
//             }
//             return 'success';
//         } catch (Exception e) {
//             throw new AuraHandledException(e.getMessage());
//         }
//     }

//     private static void callout(String file) {
//         Http http = new Http();
//         HttpRequest req = new HttpRequest();
//         req.setEndpoint('https://content.dropboxapi.com/2/files/upload');
//         req.setMethod('POST');
//         req.setHeader('Authorization', 'Bearer YOUR_ACCESS_TOKEN');
//         req.setHeader('Content-Type', 'application/octet-stream');
//         req.setHeader('Dropbox-API-Arg', '{"path":"/' + file + '"}');
        
//         // Read file content and set request body
//         Blob fileBlob = Blob.valueOf('File content goes here'); // Replace with actual file content
//         req.setBodyAsBlob(fileBlob);

//         try {
//             HttpResponse res = http.send(req);
//             if (res.getStatusCode() == 200) {
//                 System.debug('Successfully Uploaded the File..!!!');
//             } else {
//                 System.debug('ERROR: Failed to upload file Status code: ' + res.getStatusCode());
//             }
//         } catch (Exception e) {
//             System.debug('ERROR: Exception caught while uploading file: ' + e.getMessage());
//         }
//     }
// }


public with sharing class dropbox {
    @AuraEnabled
    public static String dropboxfiles(List<String> files) {
        try {
            for (String file : files) {
                System.debug(file);
                callout(file);
            }
            return 'success';
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    private static void callout(String file) {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://content.dropboxapi.com/2/files/upload');
        req.setMethod('POST');
        req.setHeader('Authorization', 'Bearer sl.BypBVisV7f__MjnbaEhR0wXayEcUi_Lgleyy6m6tOE_vVxZs6RWBCejhV2WhhTjz8Upbc0fJNk8jS84AMiuwoLJy0DTY4N8FLjHwLRmGbRvzQWmBtbovQFSVseeVmAJHJ8thUwY3xf_z');
        req.setHeader('Content-Type', 'application/octet-stream');
        req.setHeader('Dropbox-API-Arg', '{"path":"/' + file + '"}');
        
        // Read file content and set request body
        Blob fileBlob = Blob.valueOf('File content goes here'); // Replace with actual file content
        req.setBodyAsBlob(fileBlob);

        try {
            HttpResponse res = http.send(req);
            if (res.getStatusCode() == 200) {
                System.debug('Successfully Uploaded the File..!!!');
            } else {
                System.debug('ERROR: Failed to upload file Status code: ' + res.getStatusCode());
            }
        } catch (Exception e) {
            System.debug('ERROR: Exception caught while uploading file: ' + e.getMessage());
        }
    }
}
