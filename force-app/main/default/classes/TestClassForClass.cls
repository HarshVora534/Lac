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

        // // Wait for all scheduled jobs to finish
        // while (!Test.isRunningTest(System.schedule(jobId1)) || !Test.isRunningTest(System.schedule(jobId2)) || !Test.isRunningTest(System.schedule(jobId3))) {
        //     // Wait for jobs to finish
        // }

        // Assert results after jobs have finished
        System.assertEquals(5, [SELECT count() FROM Account WHERE Rating = 'Warm'], 'Accounts were not updated to "Warm" rating');
        // List<Task> tasks = [SELECT Subject, Status, Description, WhatId FROM Task];
        // System.assertEquals(5, tasks.size(), 'Tasks were not inserted as expected');
        // for (Task t : tasks) {
        //     System.assertEquals('Test Tasks', t.Subject);
        //     System.assertEquals('In Progress', t.Status);
        //     System.assertNotEquals(null, t.Description);
        // }
        List<Lead> updatedLeads = [SELECT Id, Rating FROM Lead WHERE Id IN :testLeads];
        for(Lead lead : updatedLeads) {
            System.assertEquals('Hot', lead.Rating, 'Lead rating should be set to "Hot"');
        }
        List<Task> tasks = [SELECT Subject, Status, Description, WhatId FROM Task];
        System.assertEquals(5, tasks.size());
        for (Task t : tasks) {
            System.assertEquals('Test Tasks', t.Subject);
            System.assertEquals('In Progress', t.Status);
            System.assertNotEquals(null, t.Description);
            System.assertNotEquals(null, t.Id);
        }

        for (Opportunity opp : testOpps3) {
            System.assertEquals('Prospecting', opp.StageName);
            System.assertEquals(System.today().addDays(15), opp.CloseDate);
        }
        
        System.abortJob(jobId1);
        System.abortJob(jobId2);
        System.abortJob(jobId3);
    }
}
