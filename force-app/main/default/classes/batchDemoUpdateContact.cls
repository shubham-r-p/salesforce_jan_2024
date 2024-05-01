public class batchDemoUpdateContact implements Database.Batchable<sObject> {
    
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        
        system.debug('inside start method');
        
        String query = 'SELECT LastName FROM Contact';
        
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc , List<Contact> lstContacts){
		
        system.debug('inside execute method');

        
        for(Contact con : lstContacts){
            
            con.LastName =  'shubh';            
        }
        
        UPDATE lstContacts;
    }
    
    public void finish(Database.BatchableContext bc){
                system.debug('inside finish method');

    }
    

}