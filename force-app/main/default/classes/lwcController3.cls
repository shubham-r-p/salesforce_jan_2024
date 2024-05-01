public class lwcController3 {
    
    @AuraEnabled
    public static List<Account> returnAllAcc(){
        
        List<Account> lstAccounts = [SELECT Id ,Name FROM Account];
        
        return lstAccounts;
    }
    
    @AuraEnabled
    public static List<Contact> returnRelContacts(Id accId){
    
            List<Contact> lstRelContacts = [SELECT Id ,Name ,Email ,Phone FROM Contact WHERE AccountId =: accId];
            
            return lstRelContacts; 
    }
    
    
    @AuraEnabled
    public static Id returnCase(String caseNumber){
        
        try{
            //if(caseNumber.length() )
            Case getCase = [SELECT ID ,CaseNumber ,Status ,Description FROM Case WHERE CaseNumber =: caseNumber];
            
            return getCase.Id;
        }
        Catch(Exception e){
            
            throw new AurahandledException(e.getMessage());
        }
    }

}