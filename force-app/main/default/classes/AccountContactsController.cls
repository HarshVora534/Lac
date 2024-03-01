public with sharing class AccountContactsController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getRelatedContacts(Id accountId) {
        return [SELECT Id, Name FROM Contact WHERE AccountId = :accountId LIMIT 100];
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> searchContacts(String searchTerm, Id accountId) {
        return [SELECT Id, Name FROM Contact WHERE AccountId = :accountId AND Name LIKE :('%' + ':' +searchTerm + '%') LIMIT 100];
    }
} 