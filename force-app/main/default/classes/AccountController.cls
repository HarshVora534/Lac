public class AccountController {
    @AuraEnabled
    public static String createAccount(Account account){
        try {
            insert account;
            return account.Id;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [SELECT Id, Name FROM Account];
    }
}
