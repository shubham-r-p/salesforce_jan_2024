public class sfExShippingAddPopulateHandler {
    
    //we will use a static boolean variable to handle trigger recursion
    
    public static boolean handleRecursion = true;
    
    public static void recursionDemo(List<Account> lstAccount){
        
        List<Account> lstAccToInsert = new List<Account>();
        
        for(Account acc : lstAccount){
            
            Account accIns = new Account(Name='Recusrion Demo');
            lstAccToInsert.add(accIns);
        }
        
        if(!lstAccToInsert.isEmpty()){
            insert lstAccToInsert;
            system.debug(lstAccToInsert);
        }
    }
    
    
    
    
    public static void sendMailAccUndel(List<Account> lstAcc){
        
        List<Messaging.SingleEmailMessage> lstEamil = new List<Messaging.SingleEmailMessage>();
        
        for(Account eachAcc : lstAcc){
            
            Messaging.SingleEmailMessage objEmail = new Messaging.SingleEmailMessage();
            
            List<String> lstReceivers = new List<String>{UserInfo.getUserEmail()};
                
                objEmail.setSubject('Acc Del');
          	 	objEmail.setToAddresses(lstReceivers);
            	objEmail.setPlainTextBody('no body');
            
            lstEamil.Add(objEmail);
        }
        Messaging.sendEmail(lstEamil);        
        
        
        
    }
    
    
    
    
    
    public static void sendMailAccDel(List<Account> lstAllAcc){
        
        List<Messaging.SingleEmailMessage> lstEamil = new List<Messaging.SingleEmailMessage>();
        
        for(Account eachAcc : lstAllAcc){
            
            Messaging.SingleEmailMessage objEmail = new Messaging.SingleEmailMessage();
            
            List<String> lstReceivers = new List<String>{UserInfo.getUserEmail()};
                
                objEmail.setSubject('Acc Del');
          	 	objEmail.setToAddresses(lstReceivers);
            	objEmail.setPlainTextBody('no body');
            
            lstEamil.Add(objEmail);
        }
        Messaging.sendEmail(lstEamil);
    }
    
    
    public static void deleteValidation(List<Account> lstAllAcc){
        
        for(Account acc : lstAllAcc){
            
            if(acc.Active__c == 'Yes'){
                
                acc.addError('An active account can not be deleted !');
            }
        }
    }
    
    
    public static void updateCon(List<Account> lstNewAccounts , Map<Id , Account> mapOldAccounts){
        
        Set<Id> setAccIds = new Set<Id>();
        
        for(Account eaxhAcc : lstNewAccounts){
            
            setAccIds.add(eaxhAcc.Id);
        }
        
        List<Account> lstAccCon = [SELECT Id , BillingStreet, BillingCity, BillingPostalCode, BillingState, BillingCountry, BillingAddress,
                                   (SELECT Id , MailingStreet, MailingCity, MailingPostalCode, 
                                    MailingState, MailingCountry FROM Contacts) FROM Account WHERE Id IN : setAccIds];
        
        List<Contact> lstConToUp = new List<Contact>();
        
        for(Account eachAcc : lstAccCon){
            for(Contact eachCon : eachAcc.Contacts){
                
                Account oldVersionAcc = mapOldAccounts.get(eachAcc.Id);
                
                system.debug(eachAcc.BillingAddress +'  '+ oldVersionAcc.BillingAddress);
                
                
                if(eachAcc.BillingAddress != oldVersionAcc.BillingAddress){
                    
                    
                    eachCon.MailingStreet = eachAcc.BillingStreet;
                    eachCon.MailingCity = eachAcc.BillingCity;
                    eachCon.MailingPostalCode = eachAcc.BillingPostalCode;
                    eachCon.MailingState = eachAcc.BillingState;
                    eachCon.MailingCountry = eachAcc.BillingCountry;
                    
                    lstConToUp.add(eachCon);
                }   
            }
            
            if(!lstConToUp.isEmpty()){
                
                UPDATE lstConToUp;
            }
        }
        
        
        
        
        
        /*List<Contact> relatedCon = [SELECT Id , MailingStreet, MailingCity, MailingPostalCode, 
MailingState, MailingCountry FROM Contact WHERE AccountId IN : setAccIds];*/
    }
    
    
    public static void nameUpdateError(List<Account> lstNewAccounts , Map<Id ,Account> mapOldAcc){
        
        for(Account eachAcc : lstNewAccounts){
            
            Account oldVerAcc =  mapOldAcc.get(eachAcc.Id);
            
            if(eachAcc.Name != oldVerAcc.Name){
                
                eachAcc.addError('Once account is insertred Name can not be changed !');
            }
        }
    }
    
    
    public static void updateShippingAddress(List<Account> lstNewAcc){
        
        for(Account eachAccont : lstNewAcc){
            
            if(eachAccont.ShippingStreet == null){
                
                eachAccont.ShippingStreet = eachAccont.BillingStreet;
            }
            if(eachAccont.ShippingCity == null){
                
                eachAccont.ShippingCity = eachAccont.BillingCity;
            }
            if(eachAccont.ShippingPostalCode == null){
                
                eachAccont.ShippingPostalCode = eachAccont.BillingPostalCode;
            }
            if(eachAccont.ShippingState == null){
                
                eachAccont.ShippingState = eachAccont.BillingState;
            }
            if(eachAccont.ShippingCountry == null){
                
                eachAccont.ShippingCountry = eachAccont.BillingCountry;
            }   
        }
    }
    
    
    public static void throwRevError(List<Account> lstNewAcc){
        
        for(Account eachAcc : lstNewAcc){    
            if(eachAcc.AnnualRevenue < 1000){
                eachAcc.addError('Annual revenue must be at least 1000 !');
            }
        }
    }
    
    
    public static void insertConForAcc(List<Account> lstNewAcc){
        
        List<Contact> lstConToInsert = new List<Contact>();
        
        for(Account acc : lstNewAcc){
            Contact newCon = new Contact(FirstName='test');
            newCon.LastName = 'demo';
            newCon.AccountId  = acc.Id;
            lstConToInsert.add(newCon);
        }
        INSERT lstConToInsert;
    }
}