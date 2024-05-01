trigger proTaskComUpToProject on Project_Task__c (before update , after update) {
    
    /*if(Trigger.isBefore && Trigger.isupdate){
        
    proTaskComUpToProjectHandler.validatePreviousTaskComp(Trigger.new);
    }
    */ 
    
    if(Trigger.isAfter && Trigger.isUpdate){
        
    proTaskComUpToProjectHandler.updateProjectStatus(Trigger.new);
    }
    
        if(Trigger.isBefore){
        /*if(Trigger.isInsert){
            handler.doBeforeInsert(trigger.new);
        }else*/ if(Trigger.isUpdate){
         //   proTaskComUpToProjectHandler.doBeforeUpdate(trigger.old, trigger.oldmap, trigger.new, Trigger.newmap);
        }/*else if(Trigger.isDelete){
            handler.doBeforeDelete(trigger.old, trigger.oldmap);
        }*/
    }else if(Trigger.isAfter){
        /*if(Trigger.isInsert){
            handler.doAfterInsert(trigger.new, trigger.newmap);
        }else*/ if(Trigger.isUpdate){
       //     proTaskComUpToProjectHandler.doAfterUpdate(trigger.old, trigger.oldmap, trigger.new, Trigger.newmap);
        }/*else if(Trigger.isDelete){
            handler.doAfterDelete(trigger.old, trigger.oldmap);
        }else if(Trigger.isUndelete){
            handler.doAfterUndelete(trigger.new, trigger.newmap);
        }*/
    }
    
}