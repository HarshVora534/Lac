trigger deldupstudent on Student__c (before insert) 
{
  Set<String> nn = new Set<String>();
    for (Student__c newAccount : Trigger.new) 
    {
        nn.add(newAccount.Name);
    }
    List<Student__c> acc = [SELECT Id FROM Student__c WHERE Name IN :nn];
    if (!acc.isEmpty()) 
    {
        delete acc;
    }
}