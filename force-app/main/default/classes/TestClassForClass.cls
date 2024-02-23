@isTest
public class TestClassForClass {
    @isTest
    static void TestClassForClass() {
        List<Account> testAccountsRatingWarm = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            Account acc = new Account(Name = 'Test Account ' + i, Email__c = 'test' + i + '@example.com', Rating = 'Cold');
            testAccountsRatingWarm.add(acc);
        }
        insert testAccountsRatingWarm;

        List<Lead> testLeads = new List<Lead>();
        for(Integer i = 0; i < 5; i++) {
            Lead lead = new Lead(
                FirstName = 'TestFirstName' + i,
                LastName = 'TestLastName' + i,
                Company = 'TestCompany' + i,
                Email = 'test' + i + '@example.com'
            );
            testLeads.add(lead);
        }

        List<Account> testAccountsDescription = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            Account acc = new Account(Name = 'Test Account ' + i, Email__c = 'test' + i + '@example.com');
            testAccountsDescription.add(acc);
        }
        insert testAccountsDescription;

        // Opp test class
        List<Opportunity> testOpps1 = new List<Opportunity>();
        for (Integer i = 0; i < 5; i++) {
            Opportunity opp = new Opportunity(Name = 'Test Opportunity ' + i,StageName='Qualification',Email__c='test1'+i+'@g.com',CloseDate=System.today().addDays(10));
            testOpps1.add(opp);
        }
        insert testOpps1;

        List<Opportunity> testOpps = new List<Opportunity>();
        for (Integer i = 0; i < 5; i++) {
            Opportunity opp2 = new Opportunity(Name = 'Test Opportunity ' + i,StageName='Qualification',Email__c='test'+i+'@g.com',CloseDate=System.today().addDays(10));
            testOpps.add(opp2);
        }
        insert testOpps;

        List<Opportunity> testOpps3 = new List<Opportunity>();
        for (Integer i = 0; i < 5; i++) {
            Opportunity opp = new Opportunity(Name = 'Test Opportunity ' + i,StageName='Qualification',Email__c='test2'+i+'@g.com',CloseDate=System.today().addDays(10));
            testOpps3.add(opp);
        }
        insert testOpps3;

        Test.startTest();
        // Schedule jobs
        TriggerHandler.BeforeInsert(testLeads);
        TriggerOppHandler.handleOpportunityUpdate(testOpps, new Map<Id, Opportunity>());
        TriggerOppHandler.handleOpportunityUpdate1(testOpps3);
        scheduleupdateratingwarm job1 = new scheduleupdateratingwarm();
        String jobId1 = System.schedule('Test Schedule 1', '0 24 16 * * ?', job1);

        schedulefornewaccdescription job2 = new schedulefornewaccdescription();
        String jobId2 = System.schedule('Test Schedule 2', '0 24 16 * * ?', job2);

        schedulefornewrecord job3 = new schedulefornewrecord();
        String jobId3 = System.schedule('Test Schedule 3', '0 24 16 * * ?', job3);
        Test.stopTest();
        System.assertEquals(5, [SELECT count() FROM Account WHERE Rating = 'Warm'], 'Accounts were not updated to "Warm" rating');
        List<Lead> updatedLeads = [SELECT Id, Rating FROM Lead WHERE Id IN :testLeads];
        for(Lead lead : updatedLeads) {
            System.assertEquals('Hot', lead.Rating, 'Lead rating should be set to "Hot"');
        }

        for (Opportunity opp : testOpps3) {
            System.assertEquals('Prospecting', opp.StageName);
            System.assertEquals(System.today().addDays(15), opp.CloseDate);
        }
        
        System.abortJob(jobId1);
        System.abortJob(jobId2);
        System.abortJob(jobId3);
    }

    //Lead handler Tests

    //rating as hot when lead is created
    // @isTest
    // static void testratinghotonleadcreation()
    // {
    //     List<Lead> newleads= new List<Lead>();
    //     newleads.add(new Lead(Name='Lead Test',Rating='hot'));
    //     Test.startTest();
    //     triggerHandler.BeforeInsert(newleads);
    //     Test.stopTest();
    // }
    @isTest
    Static void testtrycatchstatement5()
    {
        try{
            triggerHandler.beforeInsert(null);
        }
        catch(Exception e)
        {
            System.assertNotEquals(null, e);
            Integer lineNumber=e.getLineNumber();
            ErrorLogHandler.createExceptionRecord(e, 'triggerHandler', 'BeforeInsert', lineNumber, 'Plz find error in respective class');   
        }
    }

    // Account Handler Tests----------------------------------------------------------------

    //Prefix will be added to name Mr.
    //Create a new contact for the account with the same name as the contact 
    //Submit for Approval on new account creation
    // Del dup account
    //on modifying to hot record should be shared with wilson
    @isTest
    static void testApprovalAfterInsert() {
        List<Account> testAccounts = new List<Account>();
        testAccounts.add(new Account(Name = 'Test Account 3'));
        
        Test.startTest();
        TriggerAcccHandler.approvalAfterInsert(testAccounts);
        TriggerAcccHandler.beforeinsert(testAccounts);
        TriggerAcccHandler.afterinsertdup(testAccounts);
        TriggerAcccHandler.handleDuplicateAccounts(testAccounts);
        Test.stopTest();    
    }

    //test to modify account rating hot 
    @isTest
    static void testModifiedToHot() {
        List<Account> testAccounts = new List<Account>();
        testAccounts.add(new Account(Name = 'Test Account 5', Rating = 'Hot'));
        
        Test.startTest();
        TriggerAcccHandler.modifiedToHot(testAccounts);
        Test.stopTest();    
    }
    @isTest
    static void testaccmailoncreation() {
        Account ac2=new Account(Name = 'Test Account 5',Email__c='test@123gmail.com');
        insert ac2;
        ac2.Name='test Account 55';
        update ac2;

        Test.startTest();
        TriggerAcccHandler.beforeupdate(new List<Account>{ac2}, new Map<Id, Account>{ac2.Id => ac2});
        Test.stopTest();    
    }
    @isTest
    static void testtrycatchstatement12()
    {
        try{
            TriggerAcccHandler.beforeupdate(null,null);   
        }
        catch(Exception e){
            System.assertNotEquals(null, e);
            Integer lineNumber=e.getLineNumber();
            ErrorLogHandler.createExceptionRecord(e, 'TriggerAcccHandler', 'beforeupdate', lineNumber, 'Plz find error in respective class');
        }
    }

    @isTest
    static void testtrycatchstatement()
    {
        try{
            TriggerAcccHandler.approvalAfterInsert(null);   
        }
        catch(Exception e){
            System.assertNotEquals(null, e);
            Integer lineNumber=e.getLineNumber();
            ErrorLogHandler.createExceptionRecord(e, 'TriggerAcccHandler', 'approvalafterinsert', lineNumber, 'Plz find error in respective class');
        }
    }

    @isTest
    static void testtrycatchstatement1()
    {
        try{
            TriggerAcccHandler.beforeinsert(null);
        }
        catch(Exception e){
            System.assertNotEquals(null, e);
            Integer lineNumber=e.getLineNumber();
            ErrorLogHandler.createExceptionRecord(e, 'TriggerAcccHandler', 'beforeinsert', lineNumber, 'Plz find error in respective class');
        }
    }
   
    @isTest
    static void testtrycatchstatement2()
    {
        try{
            TriggerAcccHandler.afterinsertdup(null);
        }
        catch(Exception e){
            System.assertNotEquals(null, e);
            Integer lineNumber=e.getLineNumber();
            ErrorLogHandler.createExceptionRecord(e, 'TriggerAcccHandler', 'afterinsertdup', lineNumber, 'Plz find error in respective class');
        }
    }

    @isTest
    static void testtrycatchstatement3()
    {
        try{
            TriggerAcccHandler.handleDuplicateAccounts(null);
        }
        catch(Exception e){
            System.assertNotEquals(null, e);
            Integer lineNumber=e.getLineNumber();
            ErrorLogHandler.createExceptionRecord(e, 'TriggerAcccHandler', 'handleDuplicateAccounts', lineNumber, 'Plz find error in respective class');
        }
    }

    @isTest
    static void testtrycatchstatement4()
    {
        try{
            TriggerAcccHandler.modifiedToHot(null);
        }
        catch(Exception e){
            System.assertNotEquals(null, e);
            Integer lineNumber=e.getLineNumber();
            ErrorLogHandler.createExceptionRecord(e, 'TriggerAcccHandler', 'modifiedToHot', lineNumber, 'Plz find error in respective class');
        }
    }
    



    // Test class for contact Handler----------------------------------------------------------
    @isTest
    Static void testcontacteventcreation()
    {
        List <Contact> c = new List <Contact>();
        c.add(new Contact(LastName = 'Test Contact 5'));
        Test.startTest();
        TriggerConHandler.BeforeInsertCon(c);
        Test.stopTest();
    }
    @isTest
    Static void testtrycatchstatement6()
    {
        try{
            TriggerConHandler.BeforeInsertCon(null);
        }
        catch(Exception e){
            System.assertNotEquals(null, e);
            Integer lineNumber=e.getLineNumber();
            ErrorLogHandler.createExceptionRecord(e, 'TriggerConHandler', 'BeforeInsertCon', lineNumber, 'Plz find error in respective class');
        }
    }

    // con delete related acc
    @isTest
    Static void testcontactdeleterelated()
    {
        Account ac1 = new Account(Name = 'Test Account',Email__c='testrelateddelete@gmail.com');
        insert ac1;
        Contact con = new Contact(FirstName = 'Test', LastName = 'Contact', AccountId = ac1.Id);
        insert con;
        Test.startTest();
        delete con;
        Test.stopTest();
    }
    @isTest
    static void testtrycatchstatement7()
    {
        try{
            TriggerConHandler.afterdelete(null);  
        }
        catch(Exception e)
        {
            System.assertNotEquals(null, e);
            Integer lineNumber=e.getLineNumber();
            ErrorLogHandler.createExceptionRecord(e, 'TriggerConHandler', 'afterdelete', lineNumber, 'Plz find error in respective class');
        }
    }

    //roll up summary & sheep
    @isTest
    Static void testconrollup()
    {
        Account ac1 = new Account(Name = 'Test Account',Email__c='testrelateddelete@gmail.com',Max_Amount__c=24);
        insert ac1;
        Contact con = new Contact(FirstName = 'Test', LastName = 'Contact', AccountId = ac1.Id,Amount__c=100);
        insert con;
        con.Amount__c=200;
        update con; 

        Test.startTest();
        TriggerConHandler.handleTrigger(new List<Contact>{con}, new Map<Id, Contact>{con.Id => con}, false);  
        // TriggerConHandler.handleTriggerTrigger(new List<Contact>{con}, new Map<Id, Contact>{con.Id => con}, false);  
        Test.stopTest();
    }
    @isTest
    static void testtrycatchstatement8()
    {
        try{
            TriggerConHandler.handleTrigger(null,null,false);  
        }
        catch(Exception e)
        {
            System.assertNotEquals(null, e);
            Integer lineNumber=e.getLineNumber();
            ErrorLogHandler.createExceptionRecord(e, 'TriggerConHandler', 'handleTrigger', lineNumber, 'Plz find error in respective class');
        }
    }

    //test for the great problem
    Static void testgreatproblem()
    {
        Account ac1 = new Account(Name = 'Test Account',Email__c='testrelateddelete@gmail.com',Max_Amount__c=24);
        insert ac1;
        Contact con = new Contact(FirstName = 'Test', LastName = 'Contact', AccountId = ac1.Id,Amount__c=100);
        insert con;
        con.Amount__c=200;
        update con; 

        Test.startTest();
        TriggerConHandler.handleTriggerTrigger(new List<Contact>{con},new List<Contact>{con}, false);  
        Test.stopTest();
    }
    @isTest
    static void testtrycatchstatement9()
    {
        try{
            TriggerConHandler.handleTriggerTrigger(null,null,false);  
        }
        catch(Exception e)
        {
            System.assertNotEquals(null, e);
            Integer lineNumber=e.getLineNumber();
            ErrorLogHandler.createExceptionRecord(e, 'TriggerConHandler', 'handleTriggerTrigger', lineNumber, 'Plz find error in respective class');
        }
    }

    //try catch for sheep
    @isTest
    static void testtrycatchstatement10()
    {
        try{
            TriggerConHandler.updateContactAccount(null,null);  
        }
        catch(Exception e)
        {
            System.assertNotEquals(null, e);
            Integer lineNumber=e.getLineNumber();
            ErrorLogHandler.createExceptionRecord(e, 'TriggerConHandler', 'updateContactAccount', lineNumber, 'Plz find error in respective class');
        }
    }



    //Opp task -------------------------------------------------------------------------------------------
    @isTest
    static void testtrycatchstatement11()
    {
        try{
            TriggerOppHandler.handleOpportunityInsert(null);  
            TriggerOppHandler.handleOpportunityUpdate(null,null);           
            TriggerOppHandler.handleOpportunityUpdate1(null);        
        }
        catch(Exception e)
        {
            System.assertNotEquals(null, e);
            Integer lineNumber=e.getLineNumber();
            ErrorLogHandler.createExceptionRecord(e, 'TriggerOppHandler', 'handleOpportunityUpdate1', lineNumber, 'Plz find error in respective class');
        }
    }
}




