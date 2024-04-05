public class PdfGeneratorController {
    @AuraEnabled
    public static List<String> generatePDFs(Id recordId) {
        List<String> pdfUrls = new List<String>();
        for(Integer i = 1; i <= 10; i++) {
            PageReference pdfPage = Page.valueOf('PdfPage' + i);
            pdfPage.getParameters().put('id', recordId);
            Blob pdfBlob;
            try {
                pdfBlob = pdfPage.getContentAsPDF();
                // Save the PDF to an attachment or file (not shown in this example)
                // Here you could save the PDF and return the URL to the saved file
                pdfUrls.add('URL_TO_THE_PDF'); // Replace with the actual URL
            } catch(Exception e) {
                System.debug('Error generating PDF: ' + e.getMessage());
            }
        }
        return pdfUrls;
    }
}
