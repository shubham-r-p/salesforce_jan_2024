public class batchDemo implements Database.Batchable<sObject> , Schedulable {
    
    
    public Iterable<sObject> start(Database.BatchableContext bc){
        
        
        
        return Database.getQueryLocator('SELECT Id FROM Account');
    }
    
    public void execute(Database.BatchableContext bc , List<Account> lstObj){
        
        for(Account acc : lstObj){
        system.debug('Each Acc-> '+acc);
        }
    }
    
    public void finish(Database.BatchableContext bc){
        
        Database.executeBatch(new chainedBatchForContact() , 15);
    }
    
    public void execute(SchedulableContext qc){
        
    }
}