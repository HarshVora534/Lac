// public with sharing class WizardFormController {
//     @AuraEnabled
//     public static void createAccount(Account account) {
//         insert account;
//     }

//     @AuraEnabled
//     public static void createContact(Contact contact, Id accountId) {
//         contact.AccountId = accountId;
//         insert contact;
//     }

//     @AuraEnabled
//     public static void createEvent(Event event, Id contactId) {
//         event.Subject = 'Wizard Task';
//         event.WhoId = contactId;
//         insert event;
//     }
// }
public class WizardFormController {
    @AuraEnabled
    public static void saveAccount(Account acc) {
        insert acc;
    }
    
    @AuraEnabled
    public static void saveContact(Contact con) {
        insert con;
    }
    
    @AuraEnabled
    public static void saveEvent(Event evt) {
        insert evt;
    }
}
