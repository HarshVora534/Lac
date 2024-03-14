public with sharing class EventController {
    @AuraEnabled
    public static Id createEvent(String subject, Id contactId) {
        Event newEvent = new Event(
            Subject = subject,
            WhoId = contactId
        );
        insert newEvent;
        return newEvent.Id;
    }
}