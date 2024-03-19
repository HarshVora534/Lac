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

// public with sharing class listOfObjects {
//     @AuraEnabled(cacheable = true)
//     public static Map<String, String> fetchAllObjects() {
//         Map<String, String> allobjects = new Map<String, String>();
//         for (Schema.SObjectType obj : Schema.getGlobalDescribe().Values()) {
//             String name = obj.getDescribe().getLocalName();
//             String label = obj.getDescribe().getLabel();
//             allobjects.put(name, label);
//         }
//         System.debug(allObjects);
//         return allobjects;
//     }

//     @AuraEnabled(cacheable = true)
//     public static Map<String, List<String>> fetchAllFields() {
//         Map<String, List<String>> allFields = new Map<String, List<String>>();
//         Map<String, String> allObjects = fetchAllObjects();
//             for (String objName : allObjects.keySet()) {
//                 List<String> fields = new List<String>();
//                 for (Schema.SObjectField field : Schema.getGlobalDescribe().get(objName).getDescribe().fields.getMap().Values()) {
//                     // System.debug(field.getDescribe().getName());
//                     fields.add(field.getDescribe().getName());
//                 }
//                 // System.debug(fields);
//                 allFields.put(objName, fields);
//             }
//             System.debug(allFields);
//             return allFields;
//         }
    
    

    // @AuraEnabled(cacheable = true)
    // public static List<SObject> fetchSearchResults(String searchTerm, String selectedObjectsString) {
    //     List<String> selectedObjects = (List<String>) JSON.deserialize(selectedObjectsString, List<String>.class);
    //     List<SObject> results = new List<SObject>();

    //     for (String objectApiName : selectedObjects) {
    //         String query = 'SELECT Id, Name FROM ' + objectApiName;
    //         if (!String.isBlank(searchTerm)) {
    //             query += ' WHERE Name LIKE \'%' + String.escapeSingleQuotes(searchTerm) + '%\'';
    //         }
    //         results.addAll(Database.query(query));
    //     }

    //     return results;
    // }
//     @AuraEnabled(cacheable = true)
//     public static List<SObject> fetchSearchResults(String searchTerm, String selectedObjectsString) {
//     List<String> selectedObjects = (List<String>) JSON.deserialize(selectedObjectsString, List<String>.class);
//     List<SObject> results = new List<SObject>();

//     for (String objectApiName : selectedObjects) {
//         List<String> fields = fetchAllFields().get(objectApiName);
//         if (fields == null || fields.isEmpty()) {
//             continue;
//         }
        
//         String query = 'SELECT Id';
//         for (String field : fields) {
//             query += ', ' + field;
//         }
//         query += ' FROM ' + objectApiName;
        
//         if (!String.isBlank(searchTerm)) {
//             String searchTermEscaped = String.escapeSingleQuotes(searchTerm);
//             String whereClause = ' WHERE ';
//             for (String field : fields) {
//                 whereClause += field + ' LIKE \'%' + searchTermEscaped + '%\' OR ';
//             }
//             whereClause = whereClause.removeEnd(' OR ');
//             query += whereClause;
//         }
        
//         results.addAll(Database.query(query));
//     }

//     return results;
// }
// }


public with sharing class listOfObjects {
    @AuraEnabled(cacheable = true)
    public static Map<String, String> fetchAllObjects() {
        Map<String, String> allObjects = new Map<String, String>();
        for (Schema.SObjectType obj : Schema.getGlobalDescribe().Values()) {
            allObjects.put(obj.getDescribe().getLocalName(), obj.getDescribe().getLabel());
        }
        return allObjects;
    }

    @AuraEnabled(cacheable = true)
public static List<SObject> fetchSearchResults(String searchTerm, String selectedObjectsString) {
    List<String> selectedObjects = (List<String>) JSON.deserialize(selectedObjectsString, List<String>.class);
    List<SObject> results = new List<SObject>();
    
    for (String objectApiName : selectedObjects) {
        String query = 'FIND \'' + String.escapeSingleQuotes(searchTerm) + '\' IN ALL FIELDS RETURNING ' + objectApiName;
        List<List<SObject>> searchList = search.query(query);
        for(List<SObject> objList : searchList) {
            // Add 'type' field to each SObject
            for(SObject obj : objList) {
                obj.put('type', obj.getSObjectType().getDescribe().getName());
            }
            results.addAll(objList);
        }
    }
    
    return results;
}
}

