public class TriggerConHandler {
    private static Boolean isExecuting = false;

    //Create an event
    public static void BeforeInsertCon(List<Contact> conList) 
    {
        if (!isExecuting) {
            isExecuting = true;
            try 
            {
                List<Event> eventsToInsert = new List<Event>();

                for (Contact c : conList)
                {
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
            catch (Exception e) 
            {
                Integer lineNumber = e.getLineNumber();
                ErrorLogHandler.createExceptionRecord(e, 'TriggerConHandler', 'BeforeInsertCon', lineNumber, 'Plz find error in respective class');
            }
            finally 
            {
                isExecuting = false;
            }
        }
    }

    //Delete acc related to contact
    public static void afterdelete(List<Contact> deletedContacts) 
    {
        if (!isExecuting) 
        {
            isExecuting = true;
            try 
            {
                Set<Id> accountIds = new Set<Id>();

                for (Contact c : deletedContacts) 
                {
                    if (c.AccountId != null) 
                    {
                        accountIds.add(c.AccountId);
                    }
                }

                if (!accountIds.isEmpty()) 
                {
                    List<Account> accountsToDelete = [SELECT Id FROM Account WHERE Id IN :accountIds];
                    delete accountsToDelete;
                }
            }
            catch (Exception e) 
            {
                Integer lineNumber = e.getLineNumber();
                ErrorLogHandler.createExceptionRecord(e, 'TriggerConHandler', 'afterdelete', lineNumber, 'Plz find error in respective class');
            }
            finally 
            {
                isExecuting = false;
            }
        }
    }

    //Roll Up Summary
    public static void handleTrigger(List<Contact> newList, Map<Id, Contact> oldMap, Boolean isDelete) {
        if (!isExecuting) {
            isExecuting = true;
            try {
               
			    Set<Id> accountIds = new Set<Id>();

                for (Contact c : newList) 
                {
                    if (isDelete || (c.Amount__c != oldMap.get(c.Id).Amount__c)) 
                    {
                        accountIds.add(c.AccountId);
                    }
                }

                List<Account> accountToUpdate = [SELECT Id, (SELECT Amount__c FROM Contacts WHERE Amount__c != null) FROM Account WHERE Id IN :accountIds];
                for (Account acc : accountToUpdate) 
                {
                    Decimal total = 0;
                    for (Contact c : acc.Contacts) 
                    {
                        if (!isDelete || !oldMap.containsKey(c.Id)) 
                        {
                            total += c.Amount__c;
                        }
                    }
                    acc.Total_Amount__c = total; 
                }
                
                update accountToUpdate;
			
            } 
            catch (Exception e) 
            {
                Integer lineNumber = e.getLineNumber();
                ErrorLogHandler.createExceptionRecord(e, 'TriggerConHandler', 'handleTrigger', lineNumber, 'Plz find error in respective class');
            }
            finally 
            {
                isExecuting = false;
            }
        }
    }

    // Sheep Problem
    public static void updateContactAccount(List<Contact> oldContacts, List<Contact> newContacts) {
        if (!isExecuting) 
        {
            isExecuting = true;
            try 
            {
                
                Id accountIdss ;
                Id accountIds ;
                
                if(Trigger.isAfter && Trigger.isUpdate) 
                {
                    for (Contact con : oldContacts) 
                    {
                        accountIds = con.AccountId;
                        System.debug(accountIds);
                    }
                    for (Contact conn : newContacts) 
                    {
                        accountIdss = conn.AccountId;
                        System.debug(accountIdss);
                    }
                }

                List<Contact> contactsToUpdate = [SELECT Id, AccountId FROM Contact WHERE AccountId = :accountIds];
                System.debug(contactsToUpdate);
                
                for(Contact conc : contactsToUpdate) 
                {
                    conc.AccountId = accountIdss;
                }
                
                update contactsToUpdate;

            } 
            catch (Exception e) 
            {
                Integer lineNumber = e.getLineNumber();
                ErrorLogHandler.createExceptionRecord(e, 'TriggerConHandler', 'updateContactAccount', lineNumber, 'Plz find error in respective class');
            }
            finally 
            {
                isExecuting = false;
            }
        }
    }

    //the great problem
    public static void handleTriggerTrigger(List<Contact> newContacts, List<Contact> oldContacts, Boolean isDelete) {
        if (!isExecuting) 
        {
            isExecuting = true;
            try {
               
			        Set<Id> conaccid = new Set<Id>();
        
                    if (Trigger.isInsert || Trigger.isUpdate) 
                    {
                        for (Contact con : newContacts) 
                        {
                            conaccid.add(con.AccountId);
                        }
                    } 
                    else if (Trigger.isDelete) 
                    {
                        for (Contact con : oldContacts) 
                        {
                            conaccid.add(con.AccountId);
                        }
                    }
                    
                    if (!conaccid.isEmpty()) 
                    {
                        List<Account> accList = [SELECT Id, Max_Amount__c FROM Account WHERE Id IN :conaccid];
                        System.debug(accList);
                        
                        Integer amt;
                        Integer maxamt;
                        
                        for (Account a : accList) 
                        {
                            maxamt = a.Max_Amount__c != null ? Integer.valueOf(a.Max_Amount__c) : null;
                            System.debug(maxamt);
                        }
                        
                        for (Contact con : newContacts) 
                        {
                            amt = con.Amount__c != null ? Integer.valueOf(con.Amount__c) : null;
                            System.debug(amt);
                            
                            if (amt != null && maxamt != null && amt > maxamt) 
                            {
                                Integer noofcontacts = Integer.valueOf(amt / maxamt);
                                Integer rem = Math.mod(amt, maxamt);
                                Integer x = noofcontacts + 1;
                                System.debug('Number of Contacts: ' + noofcontacts);
                                System.debug('Remaining: ' + rem);
                                
                                List<Contact> additionalContacts = new List<Contact>();
                                for (Integer i = 1; i <= noofcontacts; i++) 
                                {
                                    Contact newcon = new Contact();
                                    newcon.FirstName = 'c' + i;
                                    newcon.LastName = 'contact';
                                    newcon.Amount__c = maxamt;
                                    newcon.AccountId = con.AccountId; 
                                    System.debug(newcon);
                                    additionalContacts.add(newcon);
                                }
                                insert additionalContacts;
                                
                                List<Contact> remaining = new List<Contact>();
                                if (rem > 0) 
                                {
                                    Contact remcon = new Contact();
                                    remcon.FirstName = 'c' + x;
                                    remcon.LastName = 'contact';
                                    remcon.Amount__c = rem;
                                    remcon.AccountId = con.AccountId;
                                    System.debug(remcon);
                                    remaining.add(remcon);
                                }
                                insert remaining;
                            }
                        }
                    }
                }  
                catch (Exception e) 
                {
                    Integer lineNumber = e.getLineNumber();
                    ErrorLogHandler.createExceptionRecord(e, 'TriggerConHandler', 'handleTriggerTrigger', lineNumber, 'Plz find error in respective class');
                } 
                finally 
                {
                    isExecuting = false;
                }
        }
    }
}