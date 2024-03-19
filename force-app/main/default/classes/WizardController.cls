public with sharing class WizardController {
    @AuraEnabled(cacheable=true)
    public static List<sObject> getObjectRecords(String objectName) {
        return Database.query('SELECT Id, Name, Email FROM ' + objectName + ' LIMIT 10');
    }

    @AuraEnabled
    public static void draftEmail(List<sObject> records, String emailBody) {
    }

    @AuraEnabled
    public static void sendEmail(List<sObject> records, String emailBody) {
    }
}
