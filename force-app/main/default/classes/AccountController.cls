public class AccountController {
    
    public static void updateCaseResDays(Set<Id> setAccId){
        
        List<Account> lstAccWithCase = [SELECT Id, Name, Resolution_Days__c, 
                                        (SELECT Id, CreatedDate, ClosedDate FROM Cases WHERE isClosed = true) 
                                        FROM Account WHERE Id IN : setAccId];        
                
        for(Account eachAcc : lstAccWithCase){
            Integer totalDays = 0, totalCases = 0;
            for(Case eachCase : eachAcc.Cases){
                totalCases++;
                totalDays+= eachCase.CreatedDate.Date().daysBetween(eachCase.ClosedDate.Date());
            }
            eachAcc.Resolution_Days__c = totalCases/totalDays;
        }
        update lstAccWithCase;
    }

}