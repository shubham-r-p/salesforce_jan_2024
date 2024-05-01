public class upOppStageTypeAfterAccUpdateHelper {
    
    
    public static void updateOpportunityStageType(List<Account> lstAccounts){
        
        Set<Id> setAccountId = new Set<Id>();
	
        for(Account acc : lstAccounts){
            
            setAccountId.add(acc.Id);
        }
        
       List<Account> lstAccountOpportunity = [SELECT Id ,Account_Type__c ,(SELECT Id ,Stage_Type__c FROM Opportunities) FROM Account WHERE Id IN : setAccountId];
        
        List<Opportunity> lstOpportunityToUp = new List<Opportunity>();
        
        for(Account account : lstAccountOpportunity){
            
            for(Opportunity opportunity : account.Opportunities){
                
                Opportunity opp = opportunity;
                
                if(account.Account_Type__c == null){
                    
                    opportunity.Stage_Type__c = '0';
                }
                else if(account.Account_Type__c == 'Reseller'){
                    
                    opportunity.Stage_Type__c = '10';
                }
                else if(account.Account_Type__c == 'Buyer'){
                    
                    opportunity.Stage_Type__c = '25';
                }
                else if(account.Account_Type__c == 'Current Customer'){
                    
                    opportunity.Stage_Type__c = '100';
                }
                
                lstOpportunityToUp.add(opp);
            }
            
        } 
        
        UPDATE lstOpportunityToUp;
    }
}