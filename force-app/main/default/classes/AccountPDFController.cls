// public class AccountPDFController {
//     public AccountPDFController(ApexPages.StandardController controller) 
//     {
//         List<Account> accountsToDownload = [SELECT Id,Email__c FROM Account LIMIT 5];
//         for(Account acc : accountsToDownload) 
//         {
//             String Id = acc.Id;
//             String email = acc.Email__c;
//             System.debug(email);
//             System.debug(Id);
//             String fileName = 'Account_' + Id + '.pdf';
//             generatePDF(fileName);
//         }
//     }
//     public void generatePDF(String fileName)
//     {
//         System.debug(fileName);
//         Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename=' + fileName);  
//     }
// }

// public with sharing class AccountPDFController {
//     @AuraEnabled(cacheable=true)
//     public static List<Blob> generatePDFs() {
//         List<Blob> pdfBlobs = new List<Blob>();
//         for(Integer i = 0; i < 11; i++) 
//         {
//             String mystring = 'String';
//             pdfBlobs.add(Blob.valueOf(mystring+i));
//             System.debug('File number:-'+i);
//         }
//         return pdfBlobs;
//     }
// }


public with sharing class AccountPDFController {
    @AuraEnabled(cacheable=true)
    public static List<Blob> generatePDFs() {
        List<Blob> pdfBlobs = new List<Blob>();
        List<Attachment> attachmentsToInsert = new List<Attachment>();
        List<Account> accounts = [SELECT Id, Name FROM Account LIMIT 11];
        
        // Prepare attachments for insertion
        for(Account acc : accounts) {
            String pdfContent = 'This is a test string'; // You can modify this with your desired content
            Attachment attachmentPDF = new Attachment();
            attachmentPDF.ParentId = acc.Id;
            attachmentPDF.Name = acc.Name + '.pdf';
            attachmentPDF.Body = Blob.toPDF(pdfContent);
            attachmentsToInsert.add(attachmentPDF);
        }
        
        // Perform bulk insert of attachments
        try {
            insert attachmentsToInsert;
            
            // After insert, retrieve Blob data from attachments and add to pdfBlobs
            for (Attachment att : attachmentsToInsert) {
                pdfBlobs.add(att.Body);
            }
        } catch (Exception e) {
            System.debug('An error occurred while inserting attachments: ' + e.getMessage());
            throw e;
        }
        
        return pdfBlobs;
    }
}


// public with sharing class AccountPDFController {
//     @AuraEnabled(cacheable=true)
//     public static List<Blob> generatePDFs(List<Id> accountIds) {
//         List<Blob> pdfBlobs = new List<Blob>();
//         for(Id accountId : accountIds) {
//             pdfBlobs.add(createPDFBlob(accountId));
//         }
//         return pdfBlobs;
//     }
    
//     // Method to create a PDF Blob with account details
//     private static Blob createPDFBlob(Id accountId) {
//         Account acc = [SELECT Id, Name, Email__c, Industry FROM Account WHERE Id = :accountId LIMIT 1];
        
//         // Example: Create a PDF content with account details
//         String pdfContent = 'Account Name: ' + acc.Name + '\n'
//             + 'Account Email: ' + acc.Email__c + '\n'
//             + 'Account ID: ' + acc.Id + '\n'
//             + 'Industry: ' + acc.Industry;

//         return Blob.toPdf(pdfContent);
//     }
// }



// public with sharing class AccountPDFController {
//     // @AuraEnabled
//     public static List<String> generatePDFContent() {
//         // Logic to generate PDF content
//         List<String> pdfContents = new List<String>();
//         for(Integer i = 1; i <= 20; i++) {
//             pdfContents.add('PDF Content ' + i);
//         }
//         return pdfContents;
//     }
// }
