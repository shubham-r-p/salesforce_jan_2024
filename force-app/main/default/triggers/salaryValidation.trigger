trigger salaryValidation on Contact (before insert , after insert) {
    
    
    if(Trigger.isBefore){
        
        if(Trigger.isInsert){
            
            salaryValidationHandler.validateSalary(Trigger.new);
        }
    }
    
    
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            //salaryValidationHandler.createCase(Trigger.new);
        }
    }

}