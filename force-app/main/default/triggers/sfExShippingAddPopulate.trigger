trigger sfExShippingAddPopulate on Account (before insert , after insert , before update , after update , before delete , after delete){
    
    if(Trigger.isInsert && Trigger.isBefore && sfExShippingAddPopulateHandler.handleRecursion){
        
       // sfExShippingAddPopulateHandler.handleRecursion = false;
        
        //sfExShippingAddPopulateHandler.recursionDemo(Trigger.new);
    }
    
    //if(Trigger.isBefore && Trigger.isInsert){
    
    //sfExShippingAddPopulateHandler.updateShippingAddress(Trigger.new);
    //sfExShippingAddPopulateHandler.throwRevError(Trigger.new);
    
    /*system.debug('Trigger.isBefore --> '+Trigger.isBefore);
system.debug('Trigger.isInsert --> '+Trigger.isInsert);
system.debug('Trigger.isExecuting --> '+Trigger.isExecuting);
system.debug('Trigger.new --> '+Trigger.new);*/
    //}
    
    
    /*if(Trigger.isInsert && Trigger.isAfter){

sfExShippingAddPopulateHandler.insertConForAcc(Trigger.new);

system.debug('Trigger.isBefore --> '+Trigger.isBefore);
system.debug('Trigger.isAfter --> '+Trigger.isAfter);
system.debug('Trigger.isInsert --> '+Trigger.isInsert);
system.debug('Trigger.isExecuting --> '+Trigger.isExecuting);
system.debug('Trigger.new --> '+Trigger.new);
}*/
    
    
    /*if(Trigger.isBefore && Trigger.isUpdate){

//sfExShippingAddPopulateHandler.nameUpdateError(Trigger.new,Trigger.oldMap);

system.debug('Trigger.isBefore --> '+Trigger.isBefore);
system.debug('Trigger.isAfter --> '+Trigger.isAfter);
system.debug('Trigger.isInsert --> '+Trigger.isInsert);
system.debug('Trigger.isupdate --> '+Trigger.isUpdate);
system.debug('Trigger.isExecuting --> '+Trigger.isExecuting);
system.debug('Trigger.new --> '+Trigger.new);
system.debug('Trigger.newMap --> '+Trigger.newMap);
system.debug('Trigger.old --> '+Trigger.old);
system.debug('Trigger.oldMap --> '+Trigger.oldMap);
}*/ 
    
    
    /*if(Trigger.isAfter && Trigger.isUpdate){

sfExShippingAddPopulateHandler.updateCon(Trigger.new , Trigger.oldMap);

system.debug('Trigger.isBefore --> '+Trigger.isBefore);
system.debug('Trigger.isAfter --> '+Trigger.isAfter);
system.debug('Trigger.isInsert --> '+Trigger.isInsert);
system.debug('Trigger.isupdate --> '+Trigger.isUpdate);
system.debug('Trigger.isExecuting --> '+Trigger.isExecuting);
system.debug('Trigger.new --> '+Trigger.new);
system.debug('Trigger.newMap --> '+Trigger.newMap);
system.debug('Trigger.old --> '+Trigger.old);
system.debug('Trigger.oldMap --> '+Trigger.oldMap);
}*/
    
    
    /*if(Trigger.isBefore && Trigger.isDelete){


sfExShippingAddPopulateHandler.deleteValidation(Trigger.new);
}*/
    
    
  /*  if(Trigger.isAfter && Trigger.isDelete){
        
        sfExShippingAddPopulateHandler.sendMailAccDel(Trigger.old);
    }
    
    if(Trigger.isAfter && Trigger.isUndelete){
        
        sfExShippingAddPopulateHandler.sendMailAccUndel(Trigger.old);
    }*/
    
}