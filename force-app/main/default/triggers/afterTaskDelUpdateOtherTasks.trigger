trigger afterTaskDelUpdateOtherTasks on Task (before delete) {
    
    if(Trigger.isbefore){
        if(Trigger.isDelete){
            
            afterTaskDelUpdateOtherTasksHandler.updateOtherTasks(Trigger.old);
        }
    }

}