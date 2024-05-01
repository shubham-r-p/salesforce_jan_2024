public class chainedBatchForContact implements Database.Batchable<sObject> , schedulable {
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        
        return Database.getQueryLocator('SELECT Id FROM Contact');
    }
    
    public void execute(Database.BatchableContext bc , List<Contact> lstAllContacts){
        
        for(Contact eachCon : lstAllContacts){
            
            system.debug('Contact --> '+eachCon);
        }
    }
    
    public void finish(Database.BatchableContext bc){
        
        
    }
    
    
    public void execute(SchedulableContext qc){
        //system.schedule('newScheduleJobDemo', '0 30 21 ? * MON-FRI' , new batchDemo());
    }

}