public class schedulefornewaccdescription implements Schedulable {
    public void execute(SchedulableContext sc) {
        List<Account> accToUpdate = new List<Account>();
        List<Account> accList = [SELECT Id, Email__c, Description FROM Account];

        for(Account ac : accList) {
            if(String.isBlank(ac.Description)) {
                ac.Description = Datetime.now().format('yyyy-MM-dd HH:mm:ss');
            }
            
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
