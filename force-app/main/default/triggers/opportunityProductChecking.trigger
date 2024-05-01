trigger opportunityProductChecking on Opportunity_Product__c ( before insert , after insert , after update) {
    
    if(Trigger.isBefore){
        if(Trigger.isInsert){
         
            opportunityProductCheckingHandler.checkOpportunityFirstProduct(Trigger.new);
        }        
    }
    
    if(Trigger.isAfter){
        if(Trigger.isInsert){
        
            opportunityProductCheckingHandler.uncheckOldProductsIfNewChecked(Trigger.new , Trigger.newMap);
    	}
    }
    
    
    if(Trigger.isAfter){
        if(Trigger.isUpdate){
            
			opportunityProductCheckingHandler.updateEventCheck(Trigger.old, Trigger.oldMap, Trigger.new);
            opportunityProductCheckingHandler.updateEventUncheck(Trigger.old, Trigger.oldMap, Trigger.new , Trigger.newMap);
        }
    }

}