//Assignment 1 :

public class salaryValidationHandler {
        
    public static void validateSalary(List<Contact> lstContacts){
                
        for(Contact contact : lstContacts){
            
            if(contact.Designation__c == 'Clerk' && (contact.Salary__c < 5000 || contact.Salary__c > 15000 || contact.Salary__c == null )){
                contact.addError('For Clerk salary must be greater than 5,000 and less than 15,000 !');
            }
            else if(contact.Designation__c == 'Manager' && (contact.Salary__c < 12000 || contact.Salary__c > 50000 || contact.Salary__c == null)){
                contact.addError('For Manager salary must be greater than 12,000 and less than 50,000 !');
            }            
            if(contact.Designation__c == 'Accountant' && (contact.Salary__c < 10000 || contact.Salary__c > 30000|| contact.Salary__c == null)){
                contact.addError('For Accountant salary must be greater than 10,000 and less than 30,000 !');
            }              
        }     
    }
    
    
    public static void createCase(List<Contact> lstContact){
        
        List<Case> lstCase = new List<Case>();
        
        for(Contact con : lstContact){
            
            Case cas = new Case();
            cas.ContactId = con.Id;
            cas.Status = 'New';   
            cas.Description = 'Created when Contact is created';
            lstCase.add(cas);
        }
        INSERT lstCase;
    }

}