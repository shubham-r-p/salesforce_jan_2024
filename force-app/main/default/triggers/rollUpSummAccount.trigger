trigger rollUpSummAccount on Contact (after insert , after undelete , after update , after delete) {
    
    
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUndelete)){
        
        rollUpSummAccountHandler.handleInsertUndelete(Trigger.new);
    }
    
    if(Trigger.isAfter && Trigger.isUpdate){
        
        rollUpSummAccountHandler.updateHandler(Trigger.new , Trigger.oldMap);
    }
    
    
    if(Trigger.isAfter && Trigger.isDelete){
        
        rollUpSummAccountHandler.deleteHandler(Trigger.Old);
    }
    

}