public with sharing class AccountCreationProgressBarController {
    @AuraEnabled
    public static void createEventRecord(Map<String, Object> eventFields) {
        Event newEvent = new Event();
        newEvent.Subject = (String) eventFields.get('Subject');
        newEvent.WhoId = (Id) eventFields.get('WhoId');
        insert newEvent;
    }
}
