public with sharing class WizardController{
    @AuraEnabled(cacheable=true)
        
            public static List<sObject> getObjectRecords(String objectName) {
                String queryFields = 'Id, Name';
        
                if (objectName == 'Account') {
                    queryFields += ', Email__c';
                } else {
                    queryFields += ', Email';
                }
        
                return Database.query('SELECT ' + queryFields + ' FROM ' + objectName + ' LIMIT 10');
            }

            @AuraEnabled(cacheable=true)
                public static void draftEmail(List<sObject> records, String emailBody) {
                    List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
                    for (sObject record : records) {
                        String toAddress;
                        if (record.getSObjectType() == Account.SObjectType) {
                            toAddress = (String)record.get('Email__c');
                        } else {
                            toAddress = (String)record.get('Email');
                        }
                        if (String.isBlank(toAddress)) {
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
            public static void sendEmail(List<sObject> records, String emailBody) {
            List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

            for (sObject record : records) {
                String toAddress;
                if (record instanceof Account) {
                    toAddress = (String) record.get('Email__c');
                } else if (record instanceof Contact) {
                    toAddress = (String) record.get('Email');
                } else {
                    toAddress = 'default@example.com';
                }

                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(new List<String>{toAddress});
                email.setSubject('Your Email Subject Here');
                email.setPlainTextBody(emailBody);
                
                emails.add(email);
            }

            if (!emails.isEmpty()) {
                Messaging.sendEmail(emails);
            }
        }

    }

