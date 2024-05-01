public class caseUpdateValidationHandler {
    
    
    public static void validateCaseUpdation(List<Case> lstCase , Map<Id , Case> oldMapCase){
        
        Set<Id> setContactIds = new Set<Id>();
        
        for(Case cas : lstCase){
            
            setContactIds.add(cas.ContactId);
        }
        
        
        List<Contact> lstContactCase = [SELECT Id ,(SELECT Id , Status FROM Cases) , (SELECT Id ,Status__c FROM Hire_Forms__r) FROM Contact WHERE Id IN : setContactIds];
        
        for(Case newCases : lstCase){
            
            for(Contact con : lstContactCase){
                
                for(Case oldCases : con.Cases){
                    
                    for(Hire_Form__c hireForm : con.Hire_Forms__r){
                        
                        Case oldVersionCase = oldMapCase.get(newCases.Id);
                                                    
                            if(hireForm.Status__c != 'Completed'){
                                
                                newCases.addError('You can not close the case until hire form  is completed');    
                        }
                    }
                }
            }	
        }
        
    }
    
}