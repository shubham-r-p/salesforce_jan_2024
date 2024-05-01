public class AccountsGoogleMapTracker {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> lstAllAccounts(){
        
        List<Account> lstAllAccounts = [ SELECT Id, Name, BillingAddress, BillingLatitude, BillingLongitude
                                        FROM Account
                                        WHERE BillingLatitude != null AND BillingLongitude != null];
        
        return lstAllAccounts;
    }
    
    @AuraEnabled
    public static List<Account> getNearByAccounts(Decimal latitude, Decimal longitude, Decimal distance){
        
        system.debug('Received latti --> '+latitude);
         system.debug('Received longi --> '+longitude);
        
        //String returnedGeo = Location.getDistance;
        
        List<Account> lstAllAccounts = [SELECT Id, Name, BillingAddress, BillingLatitude, BillingLongitude
                                        FROM Account
                                        WHERE 
                                        DISTANCE(BillingAddress, GEOLOCATION(:latitude, :longitude), 'km') < :distance];
        system.debug('lstAllAccounts-->'+lstAllAccounts);
            
            /*[ SELECT Id, Name, BillingAddress, BillingLatitude, BillingLongitude
                                        FROM Account
                                        WHERE DISTANCE (GEOLOCATION(BillingLatitude,BillingLongitude), 
                                                       GEOLOCATION(latitude,longitude), :'km') < 100];*/
    
    	return lstAllAccounts;
    }
    
    //DISTANCE(Location__c, GEOLOCATION(37.775,-122.418), 'mi') < 20
    
    
//    SELECT ID, Name, BillingLatitude, BillingLongitude 
  //   FROM Account 
    // WHERE DISTANCE(My_Location_Field__c, GEOLOCATION(10,10), :units) < 10
    
    
}