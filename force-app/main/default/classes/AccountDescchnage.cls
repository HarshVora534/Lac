global class AccountDescchnage implements Database.Batchable<sObject>, Schedulable {
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT Id, Description FROM Account');
    }
    
    global void execute(Database.BatchableContext BC, List<Account> scope) {
        for (Account acc : scope) {
            acc.Description = Datetime.now().format('yyyy-MM-dd HH:mm:ss');
        }
        update scope;
    }
    
    global void finish(Database.BatchableContext BC) {
       
    }
    
    
    global void execute(SchedulableContext sc) {
        Database.executeBatch(this);
    }
}