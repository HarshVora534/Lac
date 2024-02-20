public class triggerhandler {
 	public static void BeforeInsert(List<Lead> newLeads)
    {
        try {
            for(Lead leadRecord : newLeads) {
                leadRecord.Rating = 'Hot';
                System.debug('Lead Rating set to Hot: ' + leadRecord.Name);
            }
        } 
        catch (Exception e) 
        {
            Integer lineNumber = e.getLineNumber();
            ErrorLogHandler.createExceptionRecord(e, 'TriggerHandler', 'BeforeInsert', lineNumber, 'Plz find error in respective class');
        }
    }
}