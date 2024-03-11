public with sharing class AccountOpportunityContactController {
    @AuraEnabled
    public static List<AccountWrapper> getAccountsWithOpportunitiesAndContacts() {
        List<AccountWrapper> accountWrappers = new List<AccountWrapper>();
        List<Account> accounts = [SELECT Id, Name, (SELECT Id, Name FROM Opportunities), (SELECT Id, Name FROM Contacts) FROM Account];
        
        for (Account acc : accounts) {
            AccountWrapper wrapper = new AccountWrapper();
            wrapper.account = acc;
            wrapper.opportunities = acc.Opportunities;
            wrapper.contacts = acc.Contacts;
            accountWrappers.add(wrapper);
        }
        
        return accountWrappers;
    }
    
    public class AccountWrapper {
        @AuraEnabled
        public Account account { get; set; }
        @AuraEnabled
        public List<Opportunity> opportunities { get; set; }
        @AuraEnabled
        public List<Contact> contacts { get; set; }
    }
}
