// public with sharing class DragAndDropContact {
    
//     public class SearchResult {
//         @AuraEnabled
//         public Account account { get; set; }
        
//         @AuraEnabled
//         public List<Contact> relatedContacts { get; set; }
        
//         public SearchResult(Account acc, List<Contact> contacts) {
//             this.account = acc;
//             this.relatedContacts = contacts;
//         }
//     }
    
//     @AuraEnabled
//     public static List<SearchResult> searchAccounts(String searchKeyword) {
//         List<SearchResult> results = new List<SearchResult>();
        
//         List<Account> accounts = [SELECT Id, Name FROM Account WHERE Name LIKE :('%' + searchKeyword + '%') LIMIT 10];
        
//         for (Account acc : accounts) {
//             List<Contact> relatedContacts = [SELECT Id, Name FROM Contact WHERE AccountId = :acc.Id];
//             results.add(new SearchResult(acc, relatedContacts));
//         }
//         System.debug(results);
//         return results;
//     }

//     public with sharing class DragAndDropContact {
    
//         public class SearchResult {
//             @AuraEnabled
//             public Account account { get; set; }
            
//             @AuraEnabled
//             public List<Contact> relatedContacts { get; set; }
            
//             public SearchResult(Account acc, List<Contact> contacts) {
//                 this.account = acc;
//                 this.relatedContacts = contacts;
//             }
//         }
        
//         @AuraEnabled
//         public static List<SearchResult> searchAccounts(String searchKeyword) {
//             List<SearchResult> results = new List<SearchResult>();
            
//             List<Account> accounts = [SELECT Id, Name FROM Account WHERE Name LIKE :('%' + searchKeyword + '%') LIMIT 10];
            
//             for (Account acc : accounts) {
//                 List<Contact> relatedContacts = [SELECT Id, Name FROM Contact WHERE AccountId = :acc.Id];
//                 results.add(new SearchResult(acc, relatedContacts));
//             }
            
//             return results;
//         }
    
//         @AuraEnabled
//         public static void updateParentAccount(Id accountId, String newName){
//             try {
//                 Account ac = [SELECT Id, Name FROM Account WHERE Id = :accountId LIMIT 1];
//                 if(ac != null) {
//                     ac.Name = newName;
//                     update ac;
//                 } else {
//                     throw new AuraHandledException('Account not found');
//                 }
//             } catch (Exception e) {
//                 throw new AuraHandledException(e.getMessage());
//             }
//         }
//     }
    
// }

public with sharing class DragAndDropContact {
    
    public class SearchResult {
        @AuraEnabled
        public Account account { get; set; }
        
        @AuraEnabled
        public List<Contact> relatedContacts { get; set; }
        
        public SearchResult(Account acc, List<Contact> contacts) {
            this.account = acc;
            this.relatedContacts = contacts;
        }
    }
    
    @AuraEnabled
    public static List<SearchResult> searchAccounts(String searchKeyword) {
        List<SearchResult> results = new List<SearchResult>();
        
        List<Account> accounts = [SELECT Id, Name FROM Account WHERE Name LIKE :('%' + searchKeyword + '%') LIMIT 10];
        
        for (Account acc : accounts) {
            List<Contact> relatedContacts = [SELECT Id, Name FROM Contact WHERE AccountId = :acc.Id];
            results.add(new SearchResult(acc, relatedContacts));
        }
        return results;
    }
                        
    @AuraEnabled
    public static void updateParentAccount(Id accountId, Id contactId){
        try {
            Contact contactToUpdate = [SELECT Id, AccountId FROM Contact WHERE Id = :contactId LIMIT 1];
            if(contactToUpdate != null) {
                contactToUpdate.AccountId = accountId;
                update contactToUpdate;
            } else {
                throw new AuraHandledException('Contact not found');
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
}
