// // WizardController.cls
// public with sharing class WizardController {
//     @AuraEnabled(cacheable=true)
        
//         public static List<sObject> getObjectRecords(String objectName) {
//             String queryFields = 'Id, Name';
    
//             if (objectName == 'Account') {
//                 queryFields += ', Email__c';
//             } else {
//                 queryFields += ', Email';
//             }
    
//             return Database.query('SELECT ' + queryFields + ' FROM ' + objectName + ' LIMIT 10');
//         }
        
    

//     @AuraEnabled(cacheable=true)
//     public static void draftEmail(List<sObject> records, String emailBody) {
//         // Draft email logic
//         List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
//         for (sObject record : records) {
//             String toAddress = (String)record.get('Email');
//             if (String.isNotBlank(toAddress)) {
//                 Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
//                 email.setToAddresses(new List<String>{toAddress});
//                 email.setSubject('Draft Email Subject');
//                 email.setPlainTextBody(emailBody);
//                 emails.add(email);
//             }
//         }
//         Messaging.sendEmail(emails);
//     }

//     @AuraEnabled(cacheable=true)
//     public static void sendEmail(String records, String emailBody) {
//         List<sObject> selectedRecords = (List<sObject>) JSON.deserialize(records, List<sObject>.class);
//         // Send email logic
//         List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
//         for (sObject record : selectedRecords) {
//             String toAddress = (String) record.get('Email');
//             if (String.isNotBlank(toAddress)) {
//                 Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
//                 email.setToAddresses(new List<String>{toAddress});
//                 email.setSubject('Email Subject');
//                 email.setPlainTextBody(emailBody);
//                 emails.add(email);
//             }
//         }
//         if (!emails.isEmpty()) {
//             Messaging.sendEmail(emails);
//         }
// }

// }


// WizardController.cls
public with sharing class WizardController {
    @AuraEnabled(cacheable=true)
    public static List<sObject> getObjectRecords(String objectName) {
        String queryFields = 'Id, Name, ';

        if (objectName == 'Account') {
            queryFields += 'Email__c';
        } else {
            queryFields += 'Email';
        }
        System.debug(Database.query('SELECT ' + queryFields + ' FROM ' + objectName + ' LIMIT 10'));
        return Database.query('SELECT ' + queryFields + ' FROM ' + objectName + ' LIMIT 10');
    }

    @AuraEnabled(cacheable=true)
    public static void draftEmail(List<sObject> records, String emailBody) {
        // Draft email logic
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        for (sObject record : records) {
            String toAddress;
            if (record.getSObjectType() == Account.SObjectType) {
                toAddress = (String)record.get('Email__c');
            } else {
                toAddress = (String)record.get('Email');
            }
            if (String.isBlank(toAddress)) {
                // Assign default email address if blank
                toAddress = 'harsh200453@gmail.com';
            }
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new List<String>{toAddress});
            email.setSubject('Draft Email Subject');
            email.setPlainTextBody(emailBody);
            emails.add(email);
        }
        Messaging.sendEmail(emails);
    }

    @AuraEnabled(cacheable=true)
    public static void sendEmail(String records, String emailBody) {
        List<sObject> selectedRecords = (List<sObject>) JSON.deserialize(records, List<sObject>.class);
        // Send email logic
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        for (sObject record : selectedRecords) {
            String toAddress;
            if (record.getSObjectType() == Account.SObjectType) {
                toAddress = (String)record.get('Email__c');
            } else {
                toAddress = (String)record.get('Email');
            }
            if (String.isBlank(toAddress)) {
                // Assign default email address if blank
                toAddress = 'harsh200453@gmail.com';
            }
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new List<String>{toAddress});
            email.setSubject('Email Subject');
            email.setPlainTextBody(emailBody);
            emails.add(email);
            System.debug(email);
        }
        if (!emails.isEmpty()) {
            Messaging.sendEmail(emails);
        }
    }
}
