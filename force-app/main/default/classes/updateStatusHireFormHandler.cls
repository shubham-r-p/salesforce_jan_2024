public class updateStatusHireFormHandler {
    
    
    public static void updateStatus(List<Hire_Form__c> lstHireForms){
       
               
        for(Hire_Form__c hireForm : lstHireForms){
            
            hireForm.Status__c = 'In Progress';
        }
    
    }
    
    
    public static void createContactCase(List<Hire_Form__c> lstHireForms){
        
        
        List<Contact> conList = new List<Contact>();
        
        Set<Id> lstHireFormRec = new Set<Id>();
        
        Map<Id , Contact> mapHireFormIdContact = new Map<Id , Contact>();
        
        for(Hire_Form__c hireForm : lstHireForms){
            
            
            Contact con = new Contact();
            
            con.FirstName = hireForm.Name;
            con.LastName = hireForm.Last_Name__c;
            con.Email = hireForm.Email__c;
            con.Phone = hireForm.Phone__c;
            conList.add(con);
            
            lstHireFormRec.add(hireForm.Id);
           // hireForm.Candidate__c = con.id;
            
            mapHireFormIdContact.put(hireForm.Id , Con);
        }
        
        INSERT conList;
        
        List<Hire_Form__c> lstHireForm = [SELECT Id ,Candidate__c FROM Hire_Form__c WHERE Id IN : lstHireFormRec];
        
        List<Hire_Form__c> lstToUp = new List<Hire_Form__c>();
        
        for(Hire_Form__c hireForm : lstHireForm){
            
            hireForm.Candidate__c = mapHireFormIdContact.get(hireForm.Id).Id;
            lstToUp.add(hireForm);
        }
        
        UPDATE lstToUp;
        
        //----------------------------------------------case creation--------------------------------------------------
        
        List<Case> lstCase = new List<Case>();
        
        for(Hire_Form__c hireForm : lstHireForm){
        
        Contact con = mapHireFormIdContact.get(hireForm.Id);
            
            Case cas = new Case();
            cas.ContactId = con.Id;
            cas.Status = 'New';   
            cas.Description = 'Created when Contact is created';
            lstCase.add(cas);
        
        }
        
        INSERT lstCase;
        
        
    }
    

    
    
    /*public static void updateCaseClosed(List<Hire_Form__c> lstHireForm , Map<Id , Hire_Form__c> mapOldHireForm){
        
        Set<Id> setContactIds = new Set<Id>();
        
        for(Hire_Form__c hireForm : lstHireForm){
            
				 setContactIds.add(hireForm.Candidate__c);
        }
        
        
        List<Contact> lstContacts = [SELECT Id ,(SELECT Id FROM Hire_Forms__r) , (SELECT Id ,Status FROM Cases) FROM Contact WHERE Id IN : setContactIds];
        
        //List<Case> lstCases = [SELECT Id FROM Case WHERE ContactId IN : setContactIds];
        
        List<Case> caseToUpdate = new List<Case>();
        
        for(Contact con : lstContacts){
            
            for(Case cass : con.Cases){
        
        for(Hire_Form__c newHireForm : lstHireForm){
            
            		Hire_Form__c oldHireForm = mapOldHireForm.get(newHireForm.Id);
            
            if(oldHireForm.Status__c != 'Completed' && oldHireForm.Status__c == 'Completed'){
                
                
                    
                    cass.Status = 'Closed';
                    caseToUpdate.add(cass);   
                  
            }
        }
        
        }
        }
        UPDATE caseToUpdate;
    }*/
    
    
    
    public static void updateCaseClosed(List<Hire_Form__c> lstHireForm , Map<Id , Hire_Form__c> mapOldHireForm){
        
        Set<Id> setContactIds = new Set<Id>();
        
        for(Hire_Form__c hireForm : lstHireForm){
            
				 setContactIds.add(hireForm.Candidate__c);
        }
        
        
        //List<Contact> lstContacts = [SELECT Id ,(SELECT Id FROM Hire_Forms__r) FROM Contact WHERE Id IN : setContactIds];
        
        List<Case> lstCases = [SELECT Id FROM Case WHERE ContactId IN : setContactIds];
        
        List<Case> caseToUpdate = new List<Case>();
        
        for(Hire_Form__c newHireForm : lstHireForm){
            
            		Hire_Form__c oldHireForm = mapOldHireForm.get(newHireForm.Id);
            
            if( (oldHireForm.Status__c == 'In Progress' || oldHireForm.Status__c == 'Rejected') && newHireForm.Status__c == 'Completed'){
                
                for(Case cas : lstCases){
                    
                    cas.Status = 'Close';
                    caseToUpdate.add(cas);   
                }  
            }
        }
        
        UPDATE caseToUpdate;
    }
    
    
    
    
    
    

}