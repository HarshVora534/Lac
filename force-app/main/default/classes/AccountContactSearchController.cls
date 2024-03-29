public with sharing class AccountContactSearchController {
    @AuraEnabled(cacheable=true)
    public static List<Account> searchAccounts(String searchKeyword) {
        // Search accounts based on keyword
        String keyword = '%' + searchKeyword + '%';
        return [SELECT Id, Name FROM Account WHERE Name LIKE :keyword];
    }

    @AuraEnabled(cacheable=true)
    public static Map<String, List<Contact>> getContactsByAccountId(String accountId) {
        // Retrieve contacts related to account
        List<Contact> contacts = [SELECT Id, Name FROM Contact WHERE AccountId = :accountId];
        Map<String, List<Contact>> resultMap = new Map<String, List<Contact>>();
        resultMap.put(accountId, contacts);
        return resultMap;
    }
}
