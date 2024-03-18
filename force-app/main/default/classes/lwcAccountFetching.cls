public with sharing class lwcAccountFetching {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAllAcc(){
        try {
            List<Account> acc =[SELECT Name FROM Account ORDER BY Name];
            return acc;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled(cacheable=true)
    public static List<Account> getAllCon(){
        try {
            List<Account> acc1 =[SELECT Name,(SELECT FirstName , LastName FROM Contacts) FROM Account];
            return acc1;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled(cacheable=true)
    public static List<Account> getAllOpp(){
        try {
            List<Account> acc2 =[SELECT Name,(SELECT Name FROM Opportunities) FROM Account];
            return acc2;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

}