public class afterTaskDelUpdateOtherTasksHandler {
    
    
    public static void updateOtherTasks(List<Task> lstOldTasks){
        
        Set<Id> setTaskIds = new Set<Id>();
        Set<Id> setAccIds = new Set<Id>();
        
        for(Task eachTask : lstOldTasks){
            
            setTaskIds.add(eachTask.Id);
            setAccIds.add(eachTask.AccountId);
        }
        
        List<Account> lstAccFromTask = [SELECT Id ,(SELECT Id ,ActivityDate FROM Tasks WHERE Id NOT IN : setTaskIds order by ActivityDate asc) FROM Account WHERE Id IN : setAccIds];
        
        List<Task> lstTaskToUpdate = new List<Task>();
        
        List<Task> lstChildTasks;
        
        for(Account acc : lstAccFromTask){
            
            for(Task eachTask : acc.Tasks){
                for(Task deletedTask : lstOldTasks){
                    
                	eachTask.ActivityDate = deletedTask.ActivityDate;

                    break;    
                }
                
                for(integer i=1 ;  i<acc.Tasks.size() ; i++){
                    
                eachTask.ActivityDate = acc.Tasks[i].ActivityDate;
                }
                lstTaskToUpdate.add(eachTask);
            }
        }
                
		update lstTaskToUpdate;
    }

}