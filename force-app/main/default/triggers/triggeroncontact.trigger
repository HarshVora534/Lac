trigger triggeroncontact on Contact (before insert, after delete, after update) {
    if (Trigger.isBefore && Trigger.isInsert) {
        TriggerConHandler.BeforeInsertCon(Trigger.new);
    }
    if (Trigger.isAfter && Trigger.isDelete) {
        TriggerConHandler.afterdelete(Trigger.old);
    }
    if (Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete)) {
        TriggerConHandler.handleTrigger(Trigger.new, Trigger.oldMap, Trigger.isDelete);
        TriggerConHandler.handleTriggerTrigger(Trigger.new, Trigger.old, Trigger.isDelete);
    }
    if (Trigger.isAfter && Trigger.isUpdate) {
        TriggerConHandler.updateContactAccount(Trigger.old, Trigger.new);
    }
}