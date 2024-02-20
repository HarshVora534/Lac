trigger oppevent on Opportunity (before insert) {
    if (Trigger.isInsert) {
        List<Event> eventsToInsert = new List<Event>();
        
        for (Opportunity c : Trigger.new) {
            Event event = new Event(
                WhatId = c.Id,
                Subject = 'Go Live',
                DurationInMinutes = 60,
                ActivityDateTime = System.now()
            );
            eventsToInsert.add(event);
        }
        
        insert eventsToInsert;
    }
}