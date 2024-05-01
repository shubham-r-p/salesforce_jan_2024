public class restOrgToOrgIntegrationHandler {
    
    @AuraEnabled
    public static List<dynamicObjectsIntegration__c> returnAllSobjects(){

       List<dynamicObjectsIntegration__c> allSobjects = [SELECT Id, Name, API_Name__c FROM dynamicObjectsIntegration__c];
       return allSobjects;
    }

}