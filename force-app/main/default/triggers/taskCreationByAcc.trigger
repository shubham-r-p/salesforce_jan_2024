trigger taskCreationByAcc on Account (before insert , after insert) {
    
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            
            validateStartDateEndDate.validate(Trigger.new);
        }
    }
    
    
    
    
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            
            taskCreationByAccHandler.createTask(Trigger.new, Trigger.newMap);
        }
    }
    
    

}