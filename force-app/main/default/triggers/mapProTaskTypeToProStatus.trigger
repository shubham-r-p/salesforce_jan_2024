trigger mapProTaskTypeToProStatus on Project_Task__c (after update) {
    
    
    mapProTaskTypeToProStatusHandler.mapProjectTaskType(Trigger.old , Trigger.new);

}