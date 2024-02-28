global class AccountInsertBatch implements Database.Batchable<sObject> {

    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT Id FROM Account');
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        List<Account> accountsToInsert = new List<Account>();

        for (Integer i = 0; i < 2000; i++) {
            Account acc = new Account(
                Name = 'Testing a' + i,
                Email__c='testingacca'+i+'@gmail.com'
            );
            accountsToInsert.add(acc);
        }
        insert accountsToInsert;
    }

    global void finish(Database.BatchableContext BC) {
    }
}