trigger contexttrigger on Account (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

    // before insert event
    if (Trigger.isBefore && Trigger.isInsert) {
        
        System.debug('Trigger.new: ' + Trigger.new);
    }

    //  before update event
    if (Trigger.isBefore && Trigger.isUpdate) {
      
        System.debug('Trigger.old: ' + Trigger.old);
        System.debug('Trigger.new: ' + Trigger.new);
    }

    //  before delete event
    if (Trigger.isBefore && Trigger.isDelete) {
        
        System.debug('Trigger.old: ' + Trigger.old);
    }

    //  after insert event
    if (Trigger.isAfter && Trigger.isInsert) {
        
        System.debug('Trigger.new: ' + Trigger.new);
    }

    //  after update event
    if (Trigger.isAfter && Trigger.isUpdate) {
        
        System.debug('Trigger.old: ' + Trigger.old);
        System.debug('Trigger.new: ' + Trigger.new);
    }

    //  after delete event
    if (Trigger.isAfter && Trigger.isDelete) {
        
        System.debug('Trigger.old: ' + Trigger.old);
    }

    //  after undelete event
    if (Trigger.isAfter && Trigger.isUndelete) {
        
        System.debug('Trigger.new: ' + Trigger.new);
    }
}
