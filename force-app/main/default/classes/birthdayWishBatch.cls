//System.schedule('sendBirthDayWish', '0 10 1 ? 9 MON-SUN', new birthdayWishBatch());
public class birthdayWishBatch implements Database.Batchable<sObject> , Database.Stateful , Schedulable
{
    
	List<Contact> lstContacts = new List<Contact>();    
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        
			return Database.getQueryLocator('SELECT Id ,Name ,FirstName ,LastName ,Birthdate ,Email FROM Contact');
    }  
    
    
    public void execute(Database.BatchableContext bc , List<Contact> lstContact){
        
        for(Contact con : lstContact){            
            
            if(con.Birthdate != null && con.Email != null){
                
                
            integer todayDate = Date.today().day();
            integer birthDate = con.Birthdate.day();
            
            integer thisMonth = Date.today().month();
            integer birthMonth = con.Birthdate.month();  
                
                if(todayDate == birthDate && thisMonth == birthMonth){
       		    system.debug(con);
                lstContacts.add(con);                    
                }

            } 
        }
        
    }
    
    
    public void finish(Database.BatchableContext bc){
        
        List<Messaging.SingleEmailMessage> lstEmails = new List<Messaging.SingleEmailMessage>();
        
                
        for(Contact con : lstContacts){
        
            Messaging.SingleEmailMessage objEmail = new Messaging.SingleEmailMessage();
            
            List<String> lstEmailsAdd = new List<String>{UserInfo.getUserEmail()};
            
            lstEmailsAdd.add(con.Email);
            
			//String[] toadd=new String[]{con.Email};   
                
            //objEmail.toaddresses = new List<String>{con.Email , UserInfo.getUserEmail()};
                
            objEmail.setToAddresses(lstEmailsAdd);
            
			objEmail.setSubject('Happy Birthday ! '+con.FirstName+' '+con.LastName);            
            
            objEmail.setPlainTextBody('Happy Birthday dear '+con.Name+' we wish you all the best for your future Regards ');
            
            lstEmails.add(objEmail);
        }

		List<Messaging.SendEmailResult> result = Messaging.sendEmail(lstEmails);
        
    }
    
	
    public void execute(SchedulableContext sc){
        
	Database.executeBatch(new birthdayWishBatch());
    }
}