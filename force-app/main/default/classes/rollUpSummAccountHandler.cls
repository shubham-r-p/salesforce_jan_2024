public class rollUpSummAccountHandler {
    
    
    public static void handleInsertUndelete(List<Contact> lstContacts){
        
        Set<Id> setAccIds = new Set<Id>();
        
        for(Contact eachCon : lstContacts){
            
            setAccIds.add(eachCon.AccountId);
        }
        
        //List<Account> updateList = new List<Account>();
        
        List<Account> lstAccToUp = [SELECT Id ,Name ,Contacts_Count__c , All_Contacts_Amt__c,
                                    (SELECT Id ,Amount__c FROM Contacts) FROM Account WHERE Id IN : setAccIds];
        
        for(Account eachAcc : lstAccToUp){
            
            Decimal calculateAmt = 0;
            
            for(Contact eachCon : eachAcc.Contacts){
                
                if(eachCon.Amount__c != null){
                    calculateAmt = calculateAmt + eachCon.Amount__c;
                }
            }
            
            eachAcc.Contacts_Count__c = eachAcc.Contacts.size();
            eachAcc.All_Contacts_Amt__c = calculateAmt;
            system.debug('size--> '+eachAcc.Contacts_Count__c);
            //updateList.add(eachAcc);
        }
        
        if(!lstAccToUp.isEmpty()){
            update lstAccToUp;
        }
    }
    
    
    
    public static void updateHandler(List<Contact> lstNewVerContacts , Map<Id ,Contact> mapOldVerContacts){
        
        Set<Id> setAccIds = new Set<Id>();
        for(Contact eachCon : lstNewVerContacts){
            
            Contact oldVerContact = mapOldVerContacts.get(eachCon.Id);
            
            //if(oldVerContact.AccountId != eachCon.AccountId){
                setAccIds.add(oldVerContact.AccountId);
                setAccIds.add(eachCon.AccountId);
            //}
        }
        
        List<Account> lstAccToUp = [SELECT Id ,Name ,Contacts_Count__c , All_Contacts_Amt__c,
                                    (SELECT Id ,Amount__c FROM Contacts) FROM Account WHERE Id IN : setAccIds];
        
        for(Account eachAcc : lstAccToUp){
            
            Decimal calculateAmt = 0;
            
            for(Contact eachCon : eachAcc.Contacts){
                if(eachCon.Amount__c != null){
                    calculateAmt = calculateAmt + eachCon.Amount__c;
                    system.debug('amt-> '+calculateAmt);
                }
            }
            
            eachAcc.Contacts_Count__c = eachAcc.Contacts.size();
            eachAcc.All_Contacts_Amt__c = calculateAmt;
            
            system.debug('size--> '+eachAcc.Contacts_Count__c);
        }
        
        if(!lstAccToUp.isEmpty()){
            update lstAccToUp;
        }        
    }
    
    
    
    public static void deleteHandler(List<Contact> lstDelContact){
        
        Set<Id> setAccIds = new Set<Id>();
        
        for(Contact eachCon : lstDelContact){
            
            setAccIds.add(eachCon.AccountId);
        }        
        
        List<Account> lstAccToUp = [SELECT Id ,Name ,Contacts_Count__c , All_Contacts_Amt__c,
                                    (SELECT Id ,Amount__c FROM Contacts) FROM Account WHERE Id IN : setAccIds];
        
        for(Account eachAcc : lstAccToUp){
            
            Decimal calAmt = 0;
            
            for(Contact eachCon : eachAcc.Contacts){
                if(eachCon.Amount__c != null){
                    calAmt = calAmt + eachCon.Amount__c;
                }
            }
            
            eachAcc.Contacts_Count__c = eachAcc.Contacts.size();
            eachAcc.All_Contacts_Amt__c = calAmt;
            system.debug('size--> '+eachAcc.Contacts_Count__c);
            //updateList.add(eachAcc);
        }
        
        if(!lstAccToUp.isEmpty()){
            update lstAccToUp;
        }        
    }
    
}