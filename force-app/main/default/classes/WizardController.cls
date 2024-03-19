// WizardController.cls
public with sharing class WizardController {
    @AuraEnabled(cacheable=true)
    public static List<sObject> getObjectRecords(String objectName) {
        return Database.query('SELECT Id, Name, Email FROM ' + objectName + ' LIMIT 10');
    }

    @AuraEnabled(cacheable=true)
    public static void draftEmail(List<sObject> records, String emailBody) {
        // Draft email logic
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        for (sObject record : records) {
            String toAddress = (String)record.get('Email');
            if (String.isNotBlank(toAddress)) {
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(new List<String>{toAddress});
                email.setSubject('Draft Email Subject');
                email.setPlainTextBody(emailBody);
                emails.add(email);
            }
        }
        Messaging.sendEmail(emails);
    }

    @AuraEnabled(cacheable=true)
    public static void sendEmail(String records, String emailBody) {
        List<sObject> selectedRecords = (List<sObject>) JSON.deserialize(records, List<sObject>.class);
        // Send email logic
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        for (sObject record : selectedRecords) {
            String toAddress = (String) record.get('Email');
            if (String.isNotBlank(toAddress)) {
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(new List<String>{toAddress});
                email.setSubject('Email Subject');
                email.setPlainTextBody(emailBody);
                emails.add(email);
            }
        }
        if (!emails.isEmpty()) {
            Messaging.sendEmail(emails);
        }
}

}
