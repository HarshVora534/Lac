public with sharing class OpportunityController {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunities(String accountId) {
        return [SELECT Id, Name FROM Opportunity WHERE AccountId = :accountId];
    }
}
    