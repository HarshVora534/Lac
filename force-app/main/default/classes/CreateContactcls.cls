public class CreateContactcls {
    @AuraEnabled
    public static string createContact(Contact contobj){
        try {
            insert contobj;
            return contobj.id;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}