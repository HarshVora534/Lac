trigger Oppf on Opportunity (before insert,before update) {
    if(Trigger.isBefore)
    if(Trigger.isInsert) {
        TriggerOppHandler.handleOpportunityInsert(Trigger.NEW);
    }

    if (Trigger.isUpdate ) {
        TriggerOppHandler.handleOpportunityUpdate(Trigger.NEW, Trigger.oldMap);
        TriggerOppHandler.handleOpportunityUpdate1(Trigger.NEW);
    }

}