// public class createAcc {
 
//     @AuraEnabled
//     public static Account createAccount(Account acc) {
//         system.debug('acc'+acc);
//         insert acc;
//         return acc; 
//     }
// }

// CreateAccountController.cls
public with sharing class CreateAccount {
    // @AuraEnabled
    // public static void saveAccount(String name, String email) {
    //     Account acc = new Account();
    //     acc.Name = name;
    //     acc.Email__c = email;
    //     insert acc;
    // }

    @AuraEnabled

    public static List<String> getPickList(String objName,String fldName) {

        List<String> pkList = new List<String>();Map<String,Schema.SObjectType> allObj = Schema.getGlobalDescribe();

        Map<String,Schema.SObjectField> allFlds = allObj.get(objName).getDescribe().fields.getMap();

        List<Schema.PicklistEntry> pickList = allFlds.get(fldName).getDescribe().getPickListValues();

        for(Schema.PicklistEntry pk : pickList){

            pkList.add(pk.getValue());

        }

        return pkList;

    }

    @AuraEnabled

    public static Account createAccount(Account ac){

        insert ac;

        return ac;

    }
}
