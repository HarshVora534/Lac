public class AccountPDFController {
    public AccountPDFController(ApexPages.StandardController controller) 
    {
        List<Account> accountsToDownload = [SELECT Id,Email__c FROM Account LIMIT 5];
        for(Account acc : accountsToDownload) 
        {
            String Id = acc.Id;
            String email = acc.Email__c;
            System.debug(email);
            System.debug(Id);
            String fileName = 'Account_' + Id + '.pdf';
            generatePDF(fileName);
        }
    }
    public void generatePDF(String fileName)
    {
        System.debug(fileName);
        Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename=' + fileName);  
    }
}



