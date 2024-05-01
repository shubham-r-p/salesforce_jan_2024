// Assignment 2
// Assignment 3 
trigger upOppStageTypeAfterAccUpdate on Account (after insert , after update) {
    
    if(Trigger.isAfter){
        
        if(Trigger.isUpdate){
            
            upOppStageTypeAfterAccUpdateHelper.updateOpportunityStageType(Trigger.new);
        }
        
        if(Trigger.isInsert){
            
            createContactsFromAccountHelper.createContact(Trigger.new);
            
        }   
    }    
}





    
    
 /*   if(Trigger.isAfter && Trigger.isUpdate){
  * 
        upOppStageTypeAfterAccUpdateHelper.updateOpportunityStageType(Trigger.new);
    }
    
    
    if(Trigger.isAfter && Trigger.isInsert){
        
        createContactsFromAccountHelper.createContact(Trigger.new);    
    }*/