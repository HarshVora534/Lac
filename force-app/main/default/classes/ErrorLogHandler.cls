public with sharing class ErrorLogHandler {
    public static void createExceptionRecord(Exception ex, String className, String methodName, Integer lineNumber, String moreDetails) {
        Error_Log__c errorLog = new Error_Log__c(
            Class_Name__c = className,
            Exception_Message__c = ex.getMessage(),
            Line_Number__c = lineNumber,
            Method_Name__c = methodName,
            Exception_Type__c = ex.getTypeName(),
            More_Details__c = moreDetails
        );

        insert errorLog;
    }
}