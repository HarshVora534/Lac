public class scheduleupdateratingwarm implements Schedulable {
    public void execute(SchedulableContext sc) {
        List<Account> accToUpdate = new List<Account>();
        List<Account> accList = [SELECT Id, Email__c, Rating FROM Account];

        for(Account ac : accList) {
            ac.Rating='Warm';
            
            if(String.isBlank(ac.Email__c)) {
                ac.Email__c = 'harsh200453@gmail.com';
            }
            
            accToUpdate.add(ac);
        }
        if(!accToUpdate.isEmpty()) {
            update accToUpdate;
        }
    }
}
