public with sharing class wizardComponentController {
    @AuraEnabled
    public static void createEvent(Map<String, Object> eventFields) {
        try {
            Event newEvent = new Event();
            newEvent.put('Subject', eventFields.get('Subject'));
            newEvent.put('WhoId', eventFields.get('WhoId'));
            insert newEvent;
        } catch(Exception e) {
            throw new AuraHandledException('Error creating Event: ' + e.getMessage());
        }
    }
}
