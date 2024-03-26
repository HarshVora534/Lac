public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String accountId) {
        return [SELECT Id, Name FROM Contact WHERE AccountId = :accountId];
    }
}
