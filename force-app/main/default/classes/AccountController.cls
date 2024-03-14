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
}
