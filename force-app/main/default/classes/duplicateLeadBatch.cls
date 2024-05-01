//Database.executeBatch(new duplicateLeadBatch());
public class duplicateLeadBatch implements Database.Batchable<sObject> , Database.Stateful{
    
    List<Lead> lstDupLeads = new List<Lead>();
    
    public Iterable<sObject> start(Database.BatchableContext bc){
        
        return Database.getQueryLocator('SELECT Id ,Name ,Email FROM Lead');
    }
    
    public void execute(Database.BatchableContext bc , List<Lead> lstAllLeads){
        
        for(Lead leadOne : lstAllLeads){
            for(Lead leadTwo : lstAllLeads){
                
                if(leadOne.Id != leadTwo.Id && leadOne.Name == leadTwo.Name){
                    
                    if(!lstDupLeads.contains(leadOne) && !lstDupLeads.contains(leadTwo)){
                        
                        lstDupLeads.add(leadOne);                    
                    }
                }
            }
        }
        system.debug(lstDupLeads);
        system.debug(lstDupLeads.size());
        
    }
    
    public void finish(Database.BatchableContext bc){
        
        List<Messaging.SingleEmailMessage> lstEmails = new List<Messaging.SingleEmailMessage>();
        
        Messaging.SingleEmailMessage objEmail = new Messaging.SingleEmailMessage();
        
        List<String> lstEmailsAdd = new List<String>{UserInfo.getUserEmail()};
            
            objEmail.setToAddresses(lstEmailsAdd);
        
        objEmail.setSubject('Regarding duplicate LEAD records | '+UserInfo.getUserName());            
        
        String htmlBody = '<h4>Duplicate Lead Records : '+lstDupLeads.size()+'</h4><br>';
        htmlBody = htmlBody + '<p>'+ String.join(new List<Lead>(lstDupLeads), ' , ') + '</p><hr>';   
        
        objEmail.setPlainTextBody(' Duplicate leads found -> ');
        
        objEmail.setHtmlBody(htmlBody);
        
        lstEmails.add(objEmail);
        
        Messaging.sendEmail(lstEmails);
    }
    
}