public with sharing class AccountContactController {
    @AuraEnabled
    public static List<Account> getAccounts() {
        return [SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account];
    }
    
    @AuraEnabled
    public static void updateContactAccount(Id contactId, Id accountId) {
        Contact con = [SELECT Id FROM Contact WHERE Id = :contactId];
        con.AccountId = accountId;
        update con;
    }
}
