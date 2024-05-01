trigger contactCountTrigger on Contact (after insert , after undelete , after update , after delete){
    
    if(Trigger.isAfter){
        
        if(Trigger.isInsert || Trigger.isUndelete){
            
            contactCountTriggerHandler.contactCountUp(Trigger.new, null, null, true, true, false, false);
        }
        
        if(Trigger.isUpdate){
            
            contactCountTriggerHandler.contactCountUp(Trigger.new, Trigger.newMap, Trigger.oldMap, false, false, true, false);
        }
        
        if(Trigger.isDelete){
            
            contactCountTriggerHandler.contactCountUp(null, null, Trigger.oldMap, false, false, false, true);
        }
    }
    

}