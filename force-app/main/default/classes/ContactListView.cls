public with sharing class ContactListView {
    @AuraEnabled(cacheable=true)
    public static PaginationWrapper getContacts(Id accountId, Integer pageSize, Integer pageNumber, String searchTerm) {
        String query = 'SELECT Id, Name ,Email,Phone FROM Contact WHERE AccountId != NULL';
        
        if (!String.isBlank(searchTerm)) {
            query += ' AND Name LIKE \'%' + String.escapeSingleQuotes(searchTerm) + '%\'';
        }
        
        Integer offset = (pageNumber - 1) * pageSize;
        query += ' ORDER BY Name LIMIT :pageSize OFFSET :offset';
        
        List<Contact> contacts = Database.query(query);
        
        Integer totalContacts = [SELECT COUNT() FROM Contact WHERE AccountId != NULL];
        
        PaginationWrapper wrapper = new PaginationWrapper();
        wrapper.contacts = contacts;
        wrapper.totalContacts = totalContacts;
        
        return wrapper;
    }
    
    public class PaginationWrapper {
        @AuraEnabled public List<Contact> contacts {get; set;}
        @AuraEnabled public Integer totalContacts {get; set;}
    }
}