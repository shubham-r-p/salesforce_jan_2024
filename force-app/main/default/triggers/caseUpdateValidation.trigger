trigger caseUpdateValidation on Case (before update) {
    
    
    if(Trigger.isBefore){
        if(Trigger.isUpdate){
            
            caseUpdateValidationHandler.validateCaseUpdation(Trigger.new , Trigger.oldMap);
        }
        
    }
    
    

}