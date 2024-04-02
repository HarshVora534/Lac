public with sharing class GmailIntegrationController {
    @AuraEnabled(cacheable=true)
    public static string GmailIntegration(Id ContactId){
        try {
            Contact con = [SELECT Email FROM Contact WHERE ID =: contactId LIMIT 1];
            System.debug(con);
            return 'Success';
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}



