public class CTLocationController {
    
    public static List<Location__c> getRecentStatusChanges(){
        
        List<Location__c> locationRec = [SELECT Id, Name, Address__c, Pincode__c, Red_Score__c, Status__c, 
                                         Status_Update_Date__c FROM Location__c ORDER BY Status_Update_Date__c DESC NULLS LAST
                                         LIMIT 100];
        return locationRec;
    }
    
    public static List<Location__c> searchLocations(String searchTerm){
        
        searchTerm = searchTerm+'%';
        
        List<Location__c> locationRec = [SELECT Id, Name, Address__c, Pincode__c, Red_Score__c, Status__c, 
                                         Status_Update_Date__c FROM Location__c WHERE 
                                         Name LIKE : searchTerm OR
                                         Pincode__c LIKE : searchTerm OR
                                         Address__c LIKE : searchTerm
                                         ORDER BY Status_Update_Date__c DESC];
        return locationRec;
    }
    
    public static Location__c getLocationById(String locationId){
        
        List<Location__c> locationRec = [SELECT Id, Name, Address__c, Pincode__c, Red_Score__c, Status__c, 
                                         Status_Update_Date__c FROM Location__c WHERE Id =: locationId]; 
        
        if(!locationRec.isEmpty()){
            return locationRec[0];
        }
        return null;
    }
    
}