public class validateStartDateEndDate {
    
    
    public static void validate(List<Account> lstAcc){
        
        for(Account acc : lstAcc){
            
            if(acc.Start_Date__c > acc.End_Date__c || (acc.Start_Date__c == null && acc.End_Date__c != null) || (acc.Start_Date__c != null && acc.End_Date__c == null)){
                
                acc.addError('Please fill correct dates !');
            }
        }
    }
}