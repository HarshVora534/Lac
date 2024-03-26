public with sharing class listOfObjects {
    @AuraEnabled(cacheable = true)
    public static Map<String, String> fetchAllObjects() {
        Map<String, String> allObjects = new Map<String, String>();
        allObjects.put('Account', 'Account');
        allObjects.put('Contact', 'Contact');
        allObjects.put('Opportunity', 'Opportunity');

        return allObjects;
    }

    @AuraEnabled(cacheable = true)
    public static List<List<SObject>> fetchSearchResults(String searchTerm, String selectedObjectsString) {
        System.debug('selectedObjectsString '+selectedObjectsString);
        System.debug('searchTerm '+searchTerm);

        List<String> selectedObjects = (List<String>) JSON.deserialize(selectedObjectsString, List<String>.class);

        String query = 'FIND \'' + searchTerm + '\' IN ALL FIELDS RETURNING  ';
        for(String s : selectedObjects){
            query += s + '(';
            query += 'name';
            query += '), ';
        }
        System.debug(query);

        query = query.removeEnd(', ');

        if (selectedObjects.size() == 0 ) {
            query = '';
        }

        if(query != ''){
            List<List<SObject>> searchResults = Search.query(query);
            return searchResults;
        }

        return null;
    }
}

