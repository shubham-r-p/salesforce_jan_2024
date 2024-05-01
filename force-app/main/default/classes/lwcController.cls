public class lwcController {
    
    
    @AuraEnabled(cacheable=true)
    public static List<Account> lstAllAccounts(){
        
        List<Account> lstAllAccounts = [SELECT Id ,Name ,AccountNumber ,Phone FROM Account];
        
        return lstAllAccounts;
    }
    
    
    
    
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> returnContacts(){
        
        List<Contact> lstContacts = [SELECT Id,Name ,Account.Name ,Email ,Phone,MailingAddress,Designation__c FROM Contact];
        
        return lstContacts;
    }
    
    
    @AuraEnabled
    public static Id createContacts(Contact objCon){
        
        if(objCon != null){
            
            insert objCon;
            return objCon.Id;
        }    
        return null;
    }
    
    
    @AuraEnabled
    public static void deleteAllRecords(List<sObject> lstSobjRec){
        
        try{
        delete lstSobjRec;
        }
        catch(Exception ex){
            
            throw new AurahandledException(ex.getMessage());
        }
    }
    
    
    

    
    
    
    
    
    
}