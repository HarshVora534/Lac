public with sharing class DragAndDropContact {
    @AuraEnabled
    public static List<Contact> getRelatedContacts(String accountName,Integer totalcon1) {
        List<Contact> relatedContacts = [SELECT Id, Name, Account.Name FROM Contact WHERE Account.Name != NULL];
        System.debug(relatedContacts);
        Integer totalcon=[SELECT COUNT() FROM Contact WHERE Account.Name !=NULL];
        System.debug(totalcon);
        return relatedContacts;
    }
}
