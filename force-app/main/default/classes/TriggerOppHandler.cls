public class TriggerOppHandler {

    public static void handleOpportunityInsert(List<Opportunity> newOpportunities) {
        try{
            for(Opportunity opp : newOpportunities) {
                opp.Type = 'New Customer';
            }
        }
        catch (Exception e) 
        {
            Integer lineNumber = e.getLineNumber();
            ErrorLogHandler.createExceptionRecord(e, 'TriggerOppHandler', 'handleOpportunityInsert', lineNumber, 'Plz find error in respective class');
        }
    }

    public static void handleOpportunityUpdate(List<Opportunity> newOpportunities, Map<Id, Opportunity> oldMap) {
        try{
            List<Task> tasksToInsert = new List<Task>();
            for (Opportunity opp : newOpportunities) {
                if (oldMap.get(opp.Id).Name != opp.Name) {
                    Task t = new Task();
                    t.Subject = 'Test Tasks';
                    t.Status = 'In Progress';
                    t.Description = 'The opportunity name has been updated from ' + oldMap.get(opp.Id).Name + ' to ' + opp.Name;
                    t.WhatId = opp.Id;
                    tasksToInsert.add(t);
                }
            }
            insert tasksToInsert;
        }

        catch (Exception e) 
        {
            Integer lineNumber = e.getLineNumber();
            ErrorLogHandler.createExceptionRecord(e, 'TriggerOppHandler', 'handleOpportunityUpdate', lineNumber, 'Plz find error in respective class');
        }
    }

    public static void handleOpportunityUpdate1(List<Opportunity> updatedOpportunities) {
        try{
            for(Opportunity opp : updatedOpportunities) {
                opp.StageName = 'Prospecting';
                opp.CloseDate = System.today().addDays(15);
            }
        }

        catch (Exception e) 
        {
            Integer lineNumber = e.getLineNumber();
            ErrorLogHandler.createExceptionRecord(e, 'TriggerOppHandler', 'handleOpportunityUpdate1', lineNumber, 'Plz find error in respective class');
        }
    }

}