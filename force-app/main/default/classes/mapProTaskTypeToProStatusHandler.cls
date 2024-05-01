public class mapProTaskTypeToProStatusHandler {
    
    
    public static void mapProjectTaskType(List<Project_task__C> lstOldProjectTasks , List<Project_task__C> lstNewProjectTasks){
        
        Set<Id> setProjectRecIds = new Set<Id>();
        
        for(Project_task__C eachProTask : lstNewProjectTasks){
            
            setProjectRecIds.add(eachProTask.Project__c);
        }
        
        List<Project__c> lstRelProjetRec = [SELECT Id , Name ,Status__c FROM Project__c WHERE Id IN : setProjectRecIds];
        
        
        for(Project_task__C eachProTask : lstNewProjectTasks){
            
            for(Project__c eachPro : lstRelProjetRec){
                
                
                
            }
        }        
    }

}