trigger updateOpportunityStageType on Opportunity (before insert) {
    
    
    if(Trigger.isBefore && Trigger.isInsert){
     
		updateOpportunityStageTypeHelper.updateOppStageType(Trigger.new);
    }
}