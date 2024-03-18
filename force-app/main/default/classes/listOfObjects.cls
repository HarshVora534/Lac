// public with sharing class listOfObjects {
//     @AuraEnabled(cacheable = true)
//     public static Map<String,String> fetchAllObjects() {
//         Map<String,String> allobjects = new Map<String,String>();
//         for(Schema.SObjectType obj : Schema.getGlobalDescribe().Values()) {
//             String name = obj.getDescribe().getLocalName();
//             String label = obj.getDescribe().getLabel();
//             allobjects.put(name, label);
//         }
//         System.debug(allobjects); 
//         return allobjects; 
//     }
// }

public with sharing class listOfObjects {
    @AuraEnabled(cacheable = true)
    public static Map<String, String> fetchAllObjects() {
        Map<String, String> allobjects = new Map<String, String>();
        for (Schema.SObjectType obj : Schema.getGlobalDescribe().Values()) {
            String name = obj.getDescribe().getLocalName();
            String label = obj.getDescribe().getLabel();
            allobjects.put(name, label);
        }
        return allobjects;
    }

    @AuraEnabled(cacheable = true)
    public static List<SObject> fetchSearchResults(String searchTerm, String selectedObjectsString) {
        List<String> selectedObjects = (List<String>) JSON.deserialize(selectedObjectsString, List<String>.class);
        List<SObject> results = new List<SObject>();

        for (String objectApiName : selectedObjects) {
            String query = 'SELECT Id, Name FROM ' + objectApiName;
            if (!String.isBlank(searchTerm)) {
                query += ' WHERE Name LIKE \'%' + String.escapeSingleQuotes(searchTerm) + '%\'';
            }
            results.addAll(Database.query(query));
        }

        return results;
    }
}
