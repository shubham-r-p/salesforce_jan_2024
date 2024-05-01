trigger createProjectTasks on Project__c (after insert) {
    
    if(Trigger.isAfter && Trigger.isInsert){
        
        //List<Project_task__C> lstNewProTasks = projectTasksInsertHandler.getChildTasks(Trigger.new);
        
        
        projectTasksInsertHandler.insertProjectTasksAfterProject(Trigger.new);
    }
}