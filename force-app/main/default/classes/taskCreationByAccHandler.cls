public class taskCreationByAccHandler {
    
    public static void createTask(List<Account> newListAcc , Map<Id , Account> mapNewAccount){
                
        List<Task> lstTasks = new List<Task>();
        
        Integer monthsBetween;
        Id accountId;
        Date firstDate;
        
        for(Account acc : newListAcc){
            
            if(acc.Start_Date__c != null && acc.End_Date__c != null){
            monthsBetween = acc.Start_Date__c.monthsBetween(acc.End_Date__c);
            firstDate = acc.Start_Date__c;
            accountId = acc.Id;
            }
        }
        
        for(integer i=0 ; i<= monthsBetween ; i++){
            
            Task task = new Task();
            task.Subject = 'Email';
            task.whatId = accountId;
                
            Date activityDate = firstDate.addMonths(i);
            Datetime dateTimeNew = Datetime.newInstance(activityDate, Time.newInstance(0, 0, 0, 0));
            String day = dateTimeNew.format('EEEE');
            
			if(day=='Saturday' )
			{
   			dateTimeNew=dateTimeNew.addDays(2);
			}
			else if(day=='Sunday'){
			dateTimeNew=dateTimeNew.addDays(1);
			}

            task.ActivityDate = dateTimeNew.date();
            lstTasks.add(task);
        }
        
		        
        INSERT lstTasks;
        
    }

}