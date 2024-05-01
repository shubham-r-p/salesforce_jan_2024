public class updateOpportunityStageTypeHelper {
    
    
    public static void updateOppStageType(List<Opportunity> lstOpportunity){
        
      	Set<Id> setAcountIds = new Set<Id>();  
        
        for(Opportunity opportunity : lstOpportunity){
            
            
        setAcountIds.add(opportunity.AccountId);        	 
        }
        
        
        if(setAcountIds != null){
            
        List<Account> accountRelToOpportunity = [SELECT Id ,Account_Type__c FROM Account WHERE Id =: setAcountIds];        
                    
            
            for(Account acc : accountRelToOpportunity){
            
            for(Opportunity opportunity : lstOpportunity)
            {
                
                
                if(acc.Account_Type__c == null){
                    
                    opportunity.Stage_Type__c = '0';
                }
                else if(acc.Account_Type__c == 'Reseller'){
                    
                    opportunity.Stage_Type__c = '10';
                }
                else if(acc.Account_Type__c == 'Buyer'){
                    
                    opportunity.Stage_Type__c = '25';
                }
                else if(acc.Account_Type__c == 'Current Customer'){
                    
                    opportunity.Stage_Type__c = '100';
                }           
            }
		}        
   }
        
        else{
            system.debug('Opp is not related to acc !');
        }
    } 
}