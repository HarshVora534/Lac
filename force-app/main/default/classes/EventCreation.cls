public class EventCreation {
    @AuraEnabled
    public static void createEventRecord(String accountId, String contactId) {
        // Logic to create the event record
        // Instantiate an Event object and set its fields
        Event newEvent = new Event();
        newEvent.Subject = 'Wizard Task'; // Set the subject of the event
        newEvent.WhoId = contactId; // Set the WhoId to the Contact Id

        // Optionally, you can set other fields of the event here

        // Insert the event record
        insert newEvent;
    }
}
