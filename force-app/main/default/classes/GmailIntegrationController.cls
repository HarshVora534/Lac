public with sharing class GmailIntegrationController {
    @AuraEnabled(cacheable=true)
    public static string GmailIntegration(Id contactId, String subject, String body, List<String> attachments) {
        try {
            Contact con = [SELECT Email FROM Contact WHERE Id = :contactId LIMIT 1];
            String mail = con.Email;
            String message = createMessage(mail, subject, body, attachments);
            System.debug(message);
            sendEmailViaGmailAPI(message);

            return 'Success';
        } 
        catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    private static String createMessage(String to, String subject, String body, List<String> attachments) {
        // MIME Format:----Multipurpose Internet Mail Extensions 
        String boundary = 'boundary_boundary';
        String separator = '\r\n--' + boundary + '\r\n';
        String ending = '\r\n--' + boundary + '--';
        String contentType = 'Content-Type: application/pdf';
        String contentTransferEncoding = 'Content-Transfer-Encoding: base64';
    
        String attachmentsString = '';
        for (String attachment : attachments) {
            Blob attachmentBlob = EncodingUtil.base64Decode(attachment);
            String attachmentBody = EncodingUtil.base64Encode(attachmentBlob);
            attachmentsString += separator +
                                 contentType + '\r\n' +
                                 contentTransferEncoding + '\r\n' +
                                 'Content-Disposition: attachment; filename="Attachment.pdf"\r\n\r\n' +
                                 attachmentBody;
        }
    
        // Remove HTML tags from the body
        String cleanBody = body.replaceAll('<br>', '\n');
        cleanBody = cleanBody.replaceAll('<[^>]+>', '');
    
        String messageBody = separator +
                             'Content-Type: text/plain; charset="UTF-8"\r\n\r\n' +
                             cleanBody;
    
        String message = 'To: ' + to + '\r\n' +
                         'Subject: ' + subject + '\r\n' +
                         'Content-Type: multipart/mixed; boundary="' + boundary + '"\r\n\r\n' +
                         messageBody +
                         attachmentsString +
                         ending;
    
        return message;
    }
    
    private static void sendEmailViaGmailAPI(String message) {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://www.googleapis.com/gmail/v1/users/me/messages/send');
        req.setMethod('POST');
        req.setHeader('Authorization', 'Bearer ya29.a0Ad52N3-yPx9tneKYLp_cR2LD0jQrs2bCWLv0pd9WOaQBnumyCo6AmZF6fmJ7MzJNZp8Sum5xk6HdmV7ybA68-7H7-P43OMLgclQia4zhmYzv4q6H8hl1gbBj7IAlGCbTaPeVGIdKFd8qhtkhCSA646f7SF6wyyDPup4DaCgYKAR8SARESFQHGX2MiUCag0_e_0GblmBZLsbzK4Q0171');
        req.setHeader('Content-Type', 'application/json');
        Blob messageBlob = Blob.valueOf(message);
        String base64EncodedMessage = EncodingUtil.base64Encode(messageBlob);
        String requestBody = '{"raw": "' + base64EncodedMessage + '"}';
        req.setBody(requestBody);
    
        try {
            HttpResponse res = http.send(req);
            if (res.getStatusCode() == 200) {
                System.debug('Successfully sended the Mail..!!!');
            } else {
                System.debug('ERROR: Failed to send message via Gmail API. Status code: ' + res.getStatusCode());
                System.debug('Response Body: ' + res.getBody());
            }
        } catch (Exception e) {
            System.debug('ERROR: Exception caught while sending message via Gmail API: ' + e.getMessage());
        }
    }
        
    
}
