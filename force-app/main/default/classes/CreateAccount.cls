// public class CreateAccount {
//     @AuraEnabled
    
//     public static void createEventRecord(Map<String, String> fieldsevent, Id recordId) {
//         try {
//             Event newEvent = new Event();
//             newEvent.WhoId = recordId; 
//             newEvent.Subject = fieldsevent.get('Subject');
//             String startDateTimeString = fieldsevent.get('StartDateTime');
//             Datetime startDateTime = Datetime.valueOf(startDateTimeString);
//             newEvent.StartDateTime = startDateTime;
//             insert newEvent;
//             System.debug('Event created successfully');
//         }   
//         catch (Exception e) {
//             System.debug('Error creating Event record: ' + e.getMessage());
//             System.debug('Error: '+fieldsevent);
//             throw new AuraHandledException('Error creating Event record: ' + e.getMessage());
//         }
//     }    
//     }

// public class CreateAccount {
//     @AuraEnabled
//     public static void createEventRecord(Map<String, String> fieldsevent, Id recordId) {
//         try {
//             Event newEvent = new Event();
//             newEvent.WhoId = recordId; 
//             newEvent.Subject = fieldsevent.get('Subject');
            
//             String startDateTimeString = fieldsevent.get('StartDateTime');
            
//             // Parse the ISO 8601 datetime string manually
//             Datetime startDateTime = Datetime.newInstanceGmt(
//                 Integer.valueOf(startDateTimeString.substring(0, 4)),
//                 Integer.valueOf(startDateTimeString.substring(5, 7)),
//                 Integer.valueOf(startDateTimeString.substring(8, 10)),
//                 Integer.valueOf(startDateTimeString.substring(11, 13)),
//                 Integer.valueOf(startDateTimeString.substring(14, 16)),
//                 Integer.valueOf(startDateTimeString.substring(17, 19))
//             );
            
//             newEvent.StartDateTime = startDateTime;
            
//             // Calculate end datetime (assuming 1 hour duration for simplicity)
//             Datetime endDateTime = startDateTime.addHours(1);
//             newEvent.EndDateTime = endDateTime;
            
//             // Calculate and set duration in minutes
//             Long durationMinutes = (endDateTime.getTime() - startDateTime.getTime()) / (1000 * 60);
//             newEvent.DurationInMinutes = durationMinutes.intValue(); // Convert Long to Integer
            
//             insert newEvent;
//             System.debug('Event created successfully');
//         }   
//         catch (Exception e) {
//             System.debug('Error creating Event record: ' + e.getMessage());
//             throw new AuraHandledException('Error creating Event record: ' + e.getMessage());
//         }
//     }
    
// }
public class CreateAccount {
    @AuraEnabled
    public static void createEventRecord(Map<String, String> fieldsevent, Id recordId) {
        try {
            Event newEvent = new Event();
            newEvent.WhoId = recordId; 
            newEvent.Subject = fieldsevent.get('Subject');
            
            String startDateTimeString = fieldsevent.get('StartDateTime');
            
            // Parse the ISO 8601 datetime string manually for start date
            Datetime startDateTime = Datetime.newInstanceGmt(
                Integer.valueOf(startDateTimeString.substring(0, 4)),
                Integer.valueOf(startDateTimeString.substring(5, 7)),
                Integer.valueOf(startDateTimeString.substring(8, 10)),
                Integer.valueOf(startDateTimeString.substring(11, 13)),
                Integer.valueOf(startDateTimeString.substring(14, 16)),
                Integer.valueOf(startDateTimeString.substring(17, 19))
            );
            
            newEvent.StartDateTime = startDateTime;
            
            // Calculate end datetime (assuming 1 hour duration for simplicity)
            Datetime endDateTime = startDateTime.addHours(1);
            newEvent.EndDateTime = endDateTime;
            
            // Calculate and set duration in minutes
            Long durationMinutes = (endDateTime.getTime() - startDateTime.getTime()) / (1000 * 60);
            newEvent.DurationInMinutes = durationMinutes.intValue(); // Convert Long to Integer
            
            insert newEvent;
            System.debug('Event created successfully');
        }   
        catch (Exception e) {
            System.debug('Error creating Event record: ' + e.getMessage());
            throw new AuraHandledException('Error creating Event record: ' + e.getMessage());
        }
    }
}
