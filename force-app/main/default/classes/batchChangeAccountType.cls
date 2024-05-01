//Database.executeBatch(new batchChangeAccountType());
public class batchChangeAccountType implements Database.Batchable<sObject> , Database.Stateful {
    
		public List<Account> lstAccountToUp = new List<Account>();
    
		Integer recordCount;    
    
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        
        String query = 'SELECT Id ,Name ,Account_Type__c FROM Account';
        
        return Database.getQueryLocator(query);   
    }
    
    public void execute(Database.BatchableContext bc, List<Account> lstAccounts){
        
        
        for(Account acc : lstAccounts){
            
            if(acc.Account_Type__c == 'Buyer' || acc.Account_Type__c == 'Current Customer'){
                
                acc.Account_Type__c = 'Reseller';
                lstAccountToUp.add(acc);
            }
        }
        if(!lstAccountToUp.isEmpty()){
            UPDATE lstAccountToUp;
        }
        
        recordCount = lstAccountToUp.size();
    }
    
    public void finish(Database.BatchableContext bc){
        
        List<Messaging.SingleEmailMessage> lstEmail = new List<Messaging.SingleEmailMessage>();
        
        List<String> lstEmailAddresses = new List<String>{UserInfo.getUserEmail()};
        
        Messaging.SingleEmailMessage emailObj = new Messaging.SingleEmailMessage();
        
        emailObj.toaddresses = lstEmailAddresses;
        emailObj.setSubject('Regarding successful batch updation to Reseller | record count');
        emailObj.setPlainTextBody('All account records with "Account Type" Buyer and Current Customer are UPDATED to Account Type "Reseller". The total count of updated record is -> '+recordCount);
    	
        lstEmail.add(emailObj);
        
        Messaging.sendEmail(lstEmail);
    }
    
    
    
    
}