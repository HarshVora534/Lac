public class AccountCreationController {
    @AuraEnabled
    public static void saveAccount(Account acc) {
        try {
            insert acc;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
