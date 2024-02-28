trigger triggerexception on Error_Log__c (before insert) {
    if(!TriggerAccHandler.isExecuting) {
        TriggerAccHandler.isExecuting = true;
        try {
            List<Error_Log__c> listlj = new List<Error_Log__c>();
            String someField = listlj[0].Class_Name__c;
        } catch(Exception e) {
            System.debug('Error found');
            Error_Log__c errorLog = new Error_Log__c();
            errorLog.Class_Name__c = 'TriggerAccHandler';
            errorLog.Exception_Message__c = e.getMessage();
            errorLog.Method_Name__c = 'beforeInsert';
            errorLog.Exception_Type__c = e.getTypeName();
            insert errorLog;
        }
        TriggerAccHandler.isExecuting = false;
    }
}