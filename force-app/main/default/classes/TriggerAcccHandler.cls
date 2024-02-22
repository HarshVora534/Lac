public class TriggerAcccHandler {
        
        
        
        //Prefix will be added to name Mr.
        public static void beforeinsert(List<Account> newacc)
        { 
            try
            {    
                for(Account acc:newacc) 
                {
                    acc.Name = 'Mr.' + acc.Name; 
                }
            }
            catch (Exception e) 
            {
                Integer lineNumber = e.getLineNumber();
                ErrorLogHandler.createExceptionRecord(e, 'TriggerAcccHandler', 'BeforeInsert', lineNumber, 'Plz find error in respective class');
            }  
        }
        
        //Create a new contact for the account with the same name as the contact 
        public static void afterinsertdup(List<Account> ac) {
            try 
            {
                List<Contact> n = new List<Contact>();
        
                for (Account a : ac) {
                    Contact nc = new Contact();
                    nc.AccountId = a.Id;
                    nc.FirstName = a.Name; 
                    nc.LastName = 'Contact'; 
                    n.add(nc);
                }
                
                if (!n.isEmpty()) {
                    insert n;
                }
            } 
            catch (Exception e) 
            {
                Integer lineNumber = e.getLineNumber();
                ErrorLogHandler.createExceptionRecord(e, 'TriggerAcccHandler', 'afterinsertdup', lineNumber, 'Plz find error in respective class');
            }
        }
        

        //Submit for Approval on new account creation

        public static void approvalAfterInsert(List<Account> newList1) {
            try
            {
                String myId = '06m5g000006vaczAAA'; 
                List<Approval.ProcessSubmitRequest> approvalRequests = new List<Approval.ProcessSubmitRequest>();
            
                for (Account acc : newList1) {
                    Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
                    req.setComments('Submitted for Approval!!');
                    req.setObjectId(acc.Id);
                    req.setNextApproverIds(new List<Id>{myId}); 
                    approvalRequests.add(req);
                }
            
                List<Approval.ProcessResult> approvalResults = Approval.process(approvalRequests);
            }
            catch (Exception e) 
            {
                Integer lineNumber = e.getLineNumber();
                ErrorLogHandler.createExceptionRecord(e, 'TriggerAcccHandler', 'approvalAfterInsert', lineNumber, 'Plz find error in respective class');
            }
        }
        
        

        // Del dup account

        public static void handleDuplicateAccounts(List<Account> ac) {
            try
            {
                Set<String> ns = new Set<String>();
                Set<String> duplicateNames = new Set<String>();
        
                for (Account a : ac) {
                        duplicateNames.add(a.Name);
                        System.debug(a.Name);
                }
        
                List<Account> accountsToDelete = [SELECT Id,Name FROM Account WHERE Name IN :duplicateNames];
                System.debug(accountsToDelete);
                if (!accountsToDelete.isEmpty()) {
                    delete accountsToDelete;
                }
            }
            catch (Exception e) 
            {
                Integer lineNumber = e.getLineNumber();
                ErrorLogHandler.createExceptionRecord(e, 'TriggerAcccHandler', 'handleduplicateAccounts', lineNumber, 'Plz find error in respective class');
            }
            
        }
        
        //on modifying to hot record should be shared with wilson
        public static void modifiedToHot(List<Account> share) {
            try {
                String wilsonUserId = '0055g00000KNs8OAAT'; 
                
                for(Account acc : share) {
                    if(acc.Rating == 'Hot') {
                        AccountShare shareRecord = new AccountShare();
                        shareRecord.AccountId = acc.Id;
                        shareRecord.AccountAccessLevel = 'Read'; 
                        shareRecord.UserOrGroupId = wilsonUserId;
                        insert shareRecord;
                    }
                }
            } catch(Exception e) {
                Integer lineNumber = e.getLineNumber();
                ErrorLogHandler.createExceptionRecord(e, 'TriggerAcccHandler', 'beforeupdate', lineNumber, 'Please find error in respective class');
            }
        }
        
        
        
        //On Updating Account Name mail will be forwarded to related contacts
        public static void beforeupdate(List<Account> newAccounts, Map<Id, Account> oldMap)
         {
                try
                {
                    List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();
                    for (Account updatedAccount : newAccounts) 
                    {
                        Account oldAccount = oldMap.get(updatedAccount.Id);
                        if (oldAccount.Name != updatedAccount.Name)
                        {
                            List<Contact> relatedContacts = [SELECT Id, Email FROM Contact WHERE AccountId = :updatedAccount.Id AND Email != null];
            
                            for (Contact con : relatedContacts) 
                            {
                                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                                mail.setToAddresses(new String[] {con.Email});
                                mail.setSubject('Account Name Updated');
                                mail.setPlainTextBody('The name of the account ' + updatedAccount.Name + ' has been updated.');
                                emailsToSend.add(mail);
                            }
                        }
                    }
            
                    if (!emailsToSend.isEmpty()) 
                    {
                        Messaging.sendEmail(emailsToSend);
                    }
                }
                catch (Exception e) 
                {
                    Integer lineNumber = e.getLineNumber();
                    ErrorLogHandler.createExceptionRecord(e, 'TriggerAcccHandler', 'beforeupdate', lineNumber, 'Plz find error in respective class');
                }
        }
    
        
        
}