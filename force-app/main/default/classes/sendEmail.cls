Public class sendEmail {
    
    public static void SendEmailTemplateWithTemplate() {
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        EmailTemplate emailTemp = [Select id, Subject, Body From EmailTemplate Where DeveloperName = 'Sample_Email'];
        Contact con = [Select Id, Email from Contact where LastName ='Test'];
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setTemplateId(emailTemp.Id);
        mail.setTargetObjectId(con.Id);
        emailList.add(mail);
        
        if(!emailList.isEmpty()){
            Messaging.sendEmail(emailList);
        }    
    }
}