public class lwcControllerTwo {
    
    @AuraEnabled
    public static List<Account> returnAccWithConOpp(Id Id){
        
        try{
            
            List<Account> lstAccWithConOpp = [SELECT Id ,Name , phone ,AccountNumber,Fax,BillingState, BillingCity ,
                                              (SELECT Id ,Name ,FirstName ,LastName ,Phone ,Email FROM Contacts),
                                              (SELECT Id ,Name ,Amount ,StageName , CloseDate FROM Opportunities) FROM Account WHERE Id =: Id];
            system.debug('******all con & opp'+lstAccWithConOpp);
            return lstAccWithConOpp;
        }
        catch(Exception e){
            
            throw new AuraHandledException(e.getMessage());
        }
        
        
        
    }
        
        
        
        
        
        
        
        @AuraEnabled
        public static List<Account> returnAllAcc(){
            
            try{
                List<Account> lstAccounts = [SELECT Id ,Name FROM Account];
                return lstAccounts;
            }
            catch(Exception e){
                
                throw new AurahandledException(e.getMessage());
            }
        }
    
    
    @AuraEnabled
    public static List<Contact> returnContacts(List<Id> lstSobjectRecIds){
        
        try{
            List<Contact> lstContactsByAccounts = [SELECT Id ,Name ,Phone,Email FROM Contact WHERE AccountId IN : lstSobjectRecIds];
            return lstContactsByAccounts;
            
        }
        catch(Exception e){
            
            throw new AurahandledException(e.getMessage());
        }
    }
    
    
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> lstAllContacts(){
        
        try{
            List<Contact> lstContacts = [SELECT Id ,Name ,Email ,Phone FROM Contact];
            return lstContacts;
        }
        catch(Exception e){
            
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    
    
    @AuraEnabled
    public static List<Opportunity> getOpportunities(){
        
        try{
            
            List<Opportunity> lstOpportunity = [SELECT Id ,Name ,Type FROM Opportunity];
            return lstOpportunity;
        }        
        catch(Exception e){
            
            throw new AuraHandledException(e.getMessage());
        }
        
    }
    
    
    @AuraEnabled(cacheable=true)
    public static List<Case> returnCases(){
        
        try{
            List<Case> lstAllCases = [SELECT Id ,CaseNumber ,Subject FROM Case];
            return lstAllCases;
        }
        catch(Exception e){
            
            throw new AuraHandledException(e.getMessage());
        }
        
    }
    
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> returnRelatedContacts(Id accountId , string key){
        
        try{
            if(key != null && key != ''){
                
                String searchK = '%'+key+'%';
                
                List<Contact> lstContactReAcc = [SELECT Id ,Name ,Email FROM Contact WHERE AccountId =: accountId AND Name LIKE : searchK];
                return lstContactReAcc;
            }
            else{
                List<Contact> lstContactReAcc = [SELECT Id ,Name ,Email FROM Contact WHERE AccountId =: accountId];
                return lstContactReAcc;                
            }
            
        }
        catch(Exception e){
            
            throw new AurahandledException(e.getMessage());
        }
    }
    
    
    
    
    
    
    
    @AuraEnabled
    public static List<Opportunity> returnOpp(Id accId){
        
        try{
            
            List<Opportunity> lstAccOpp = [SELECT Id ,Name ,Amount FROM Opportunity WHERE AccountId =: accId];
            return lstAccOpp;
        }
        catch(Exception e){
            
            throw new AuraHandledException(e.getMessage());
        }
        
        
    }
    
    
}