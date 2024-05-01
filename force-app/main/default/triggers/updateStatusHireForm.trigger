trigger updateStatusHireForm on Hire_Form__c (before insert , after insert , after update) {
    
    
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            
            updateStatusHireFormHandler.updateStatus(Trigger.new);
            
        }
    }

    
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            updateStatusHireFormHandler.createContactCase(Trigger.new);
            
        }
        if(Trigger.isUpdate){
            
            updateStatusHireFormHandler.updateCaseClosed(Trigger.new , Trigger.oldMap);
        }
    }
    
    
}