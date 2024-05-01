public class contactCountTriggerHandler {
    
    public static void contactCountUp(List<Contact> lstAfterInsertContacts , Map<Id ,Contact> mapNewContacts , Map<Id , Contact> mapOldContacts , Boolean isInsert , Boolean isUndelete , Boolean isUpdate , Boolean IsDelete){
        
        
        Set<Id> setAccIds = new Set<Id>();
        
        if(isInsert || isUndelete){
            
            
            for(Contact con : lstAfterInsertContacts){
                
                setAccIds.add(con.AccountId);
            }
        }
        
        
        if(isUpdate){
            
            for(Contact con : lstAfterInsertContacts){
                
                Contact oldContactVer = mapOldContacts.get(con.Id);
                
                if(con.AccountId != oldContactVer.AccountId){
                    setAccIds.add(con.AccountId);
                    setAccIds.add(oldContactVer.AccountId);
                }
            }             
        }
        
        
        if(IsDelete){
            
            
            for(Contact oldCon : mapOldContacts.values()){
                
                setAccIds.add(oldCon.AccountId);
            }
        }   
        
        
        List<Account> lstAccountToUp = new List<Account>();
        
        List<Account> lstAcc = [SELECT Id ,Contact_Count__c ,(SELECT Id FROM Contacts) FROM Account WHERE Id IN : setAccIds];
        
        for(Account acc : lstAcc){
            
            acc.Contact_Count__c = acc.Contacts.size();
            lstAccountToUp.add(acc);
        }
        
        update lstAccountToUp;
    }
    
}