trigger leadratinghigh on Lead (before insert) {
    if(Trigger.isInsert && Trigger.isBefore)
    {
        triggerhandler.BeforeInsert(Trigger.NEW);
    }
}