global class BatchOppUpdate implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
       
        return Database.getQueryLocator([
            SELECT Id, Name, AccountId, Account.Name 
            FROM Opportunity 
        ]);
    }
    
    global void execute(Database.BatchableContext BC, List<Opportunity> updt) {
        Map <Id,String> nameupdatemap=new Map <Id,String>();
        
       
        for (Opportunity opp : updt) {
            if (!nameupdatemap.containsKey(opp.AccountId)) {
                nameupdatemap.put(opp.AccountId, opp.Name);
            }
        }
        
        if(!nameupdatemap.isEmpty())
        {
            List<Account> accountsToUpdate = [SELECT Id,Name FROM Account WHERE Id IN:nameupdatemap.KeySet()];
        
        for(Account acc:accountsToUpdate)
        {
            acc.Name=nameupdatemap.get(acc.Id);
            System.debug(acc.Name);
        }
        update accountsToUpdate;
        }
        
    }
    
    global void finish(Database.BatchableContext BC) {

    }
}