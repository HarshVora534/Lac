public with sharing class SearchController {
    @AuraEnabled(cacheable=true)
    public static List<SearchResultWrapper> searchRecords(String searchTerm, List<String> objectNames) {
        List<SearchResultWrapper> searchResults = new List<SearchResultWrapper>();

        String soslQuery = 'FIND \'' + String.escapeSingleQuotes(searchTerm) + '\' IN ALL FIELDS RETURNING ';
        for (String objectName : objectNames) {
            soslQuery += objectName + '(' + String.join(getSearchableFields(objectName), ',') + '),';
        }
        soslQuery = soslQuery.removeEnd(',');

        List<List<SObject>> searchList = search.query(soslQuery);
        Integer i = 0;
        for (String objectName : objectNames) {
            searchResults.add(new SearchResultWrapper(objectName, searchList[i]));
            i++;
        }

        return searchResults;
    }

    public static List<String> getSearchableFields(String objectName) {
        List<String> searchableFields = new List<String>();
        if (objectName == 'Account') {
            searchableFields.add('Name');
            searchableFields.add('Industry');
        } else if (objectName == 'Contact') {
            searchableFields.add('Name');
        }
        else if(objectName == 'Opportunity')
        {
            searchableFields.add('Name');
        }
        return searchableFields;
    }

    public class SearchResultWrapper {
        @AuraEnabled
        public String objectName;
        @AuraEnabled
        public List<SObject> records;

        public SearchResultWrapper(String objectName, List<SObject> records) {
            this.objectName = objectName;
            this.records = records;
        }
    }
}
