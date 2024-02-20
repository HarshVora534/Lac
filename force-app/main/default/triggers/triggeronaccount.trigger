trigger triggeronaccount on Account (before insert, before update, after insert,after update) {
    if (Trigger.isInsert && Trigger.isBefore) 
    {
        TriggerAcccHandler.beforeinsert(Trigger.NEW);
        TriggerAcccHandler.handleDuplicateAccounts(Trigger.NEW);
    }
    if (Trigger.isBefore && Trigger.isUpdate) 
    {
        TriggerAcccHandler.beforeupdate(Trigger.NEW, Trigger.oldMap);
    }
    if(Trigger.isInsert && Trigger.isAfter)
    {
        TriggerAcccHandler.afterinsertdup(Trigger.NEW);
        TriggerAcccHandler.approvalafterinsert(Trigger.NEW);
    }
    if(Trigger.isUpdate && Trigger.isAfter)
    {
        TriggerAcccHandler.modifiedToHot(Trigger.NEW);
    }
}