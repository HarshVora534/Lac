// public with sharing class pdfdownloadnew {
//     public pdfdownloadnew() {

//     }
// }

public with sharing class pdfdownloadnew {
    @AuraEnabled 
    public static String getPdfFileAsBase64String() {
        PageReference pdfPage = Page.envelope;
        Blob pdfBlob = pdfPage.getContent();
        String base64Pdf = EncodingUtil.base64Encode(pdfBlob);
        return base64Pdf;
    }
}