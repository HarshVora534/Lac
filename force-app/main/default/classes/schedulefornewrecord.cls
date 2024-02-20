public class schedulefornewrecord implements Schedulable{
    public void execute(SchedulableContext sc){
        for(Integer i=0;i<=10;i++)
        {
            Opportunity opp= new Opportunity();
            opp.Name='Opportunitiy_no.'+i;
            opp.StageName='Qualification';
            opp.Email__c='harsh200453@gmail.com';
            opp.CloseDate=System.today().addDays(15);
            insert opp;
        }
    }
}