public class proTaskComUpToProjectHandler {
    
    
       /* public static void doBeforeUpdate(List<Project_Task__c> oldList, Map<Id,Project_Task__c> oldMap, List<Project_Task__c> newList, Map<Id,Project_Task__c> newMap){
        preventTypeChange(newList, oldMap);
        //checkIfAttachmentIsAvailable(newList, newMap, oldMap);	
        checkCompletionDateIsSelected(newList);
        checkCompletionDateIsSelectedAndProjectIsNotCompleted(newList);
    }
    
    
        private static void preventTypeChange(List<Project_Task__c> projectTaskList, Map<Id, Project_Task__c> oldProjectTaskMap) {
        for(Project_Task__c projectTask : projectTaskList) {
            if(oldProjectTaskMap.get(projectTask.Id).Type__c != projectTask.Type__c) {
                projectTask.Type__c.addError('Cannot update type now!!!');
            }
        }*/
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   /* public static void validatePreviousTaskComp(List<Project_Task__c> lstNewProjectTasks){
        
        Set<Id> setProjectRecIds = new Set<Id>();
        
        for(Project_Task__c eachProTask : lstNewProjectTasks){
            setProjectRecIds.add(eachProTask.Project__c);   
        }
        
        
        List<Project__c> lstRelProjRec =
            [SELECT Id ,(SELECT Completed__c , Type__c FROM Project_Task__r) FROM Project__C WHERE Id IN : setProjectRecIds];
        
        
        for(Project__c eachPro : lstRelProjRec){
            for(Project_Task__c updatedProTask : lstNewProjectTasks){
                for(Project_Task__c eachProTask : eachPro.Project_Task__r){
                    
                    
                    if(updatedProTask.Completed__c == true){
                        if(updatedProTask.Type__c == 'Planning Phase' && eachProTask.Type__c == 'New Task'){
                            if(eachProTask.Completed__c == false){
                                
                                updatedProTask.addError('Previous Project Task must be completed before completing this task !');
                            }}
                    
                        if(updatedProTask.Type__c == 'Construction Work' && eachProTask.Type__c == 'Planning Phase'){
                            if(eachProTask.Completed__c == false){
                                
                                updatedProTask.addError('Previous Project Task must be completed before completing this task !');
                            }}               
                    
                        if(updatedProTask.Type__c == 'Completion Step' && eachProTask.Type__c == 'Construction Work'){
                            if(eachProTask.Completed__c == false){
                                
                                updatedProTask.addError('Previous Project Task must be completed before completing this task !');
                            }}
                    
                        if(updatedProTask.Type__c == 'Contract End' && eachProTask.Type__c == 'Completion Step'){
                            if(eachProTask.Completed__c == false){
                                
                                updatedProTask.addError('Previous Project Task must be completed before completing this task !');
                            }}}
                    
                }
            }
        }
        
        
    }*/
    
    
    public static void updateProjectStatus(List<Project_Task__c> lstNewProjectTasks){
        
        Set<Id> setProjectRecIds = new Set<Id>();
        
        for(Project_Task__c eachProTaskRec : lstNewProjectTasks){    
            setProjectRecIds.add(eachProTaskRec.Project__c);
        }
        
        List<Project__c> lstProjectRecToUp = [SELECT Id , Status__c FROM Project__c WHERE Id IN : setProjectRecIds];
        
        for(Project__c eachPro : lstProjectRecToUp){
            for(Project_Task__c eachProTask : lstNewProjectTasks){
                
                if(eachProTask.Completed__c == true){
                    
                    if(eachProTask.Type__c == 'New Task'){
                        
                        eachPro.Status__c = 'New';
                    }
                    else if(eachProTask.Type__c == 'Planning Phase'){
                        
                        eachPro.Status__c = 'Planning';
                    }
                    else if(eachProTask.Type__c == 'Construction Work'){
                        
                        eachPro.Status__c = 'Construction';
                    }
                    else if(eachProTask.Type__c == 'Completion Step'){
                        
                        eachPro.Status__c = 'Deployment';
                    }
                    else{
                        eachPro.Status__c = 'Signoff';
                    }
                }
            }
        }
        
        update lstProjectRecToUp;
    }
    
}
/*
New Task --> New
Planning Phase -> Planning
Construction Work --> Construction
Completion Step -> Deployment
Contract End -> Signoff

*/