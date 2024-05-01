public class ContactVFpageController 
{
   
    public List<String> contactList {get;set;}
    public id contactId{get;set;}
    // id is data type we can use string as well 
    
    List<contact> conList =  [SELECT Id, Name, Email, Phone, MailingStreet, MailingCity,MailingPostalCode , MailingState ,MailingCountry FROM Contact WHERE CreatedDate = THIS_MONTH];
    
  
    public List<WrapperClass> WrapperClassList {get; set;}

    public ContactVFpageController() 
    {
         
        if(WrapperClassList == Null)
        {
            
            WrapperClassList = new List<WrapperClass>();
            for(Contact con:conList)
            {
                WrapperClassList.add(new WrapperClass(con));
            }
        }
    }
    
    public class WrapperClass
    {
        
         public Contact cont {get; set;}
         public string mailingAddress{get;set;}
        
        
        public WrapperClass(Contact con)
        {
            
            cont = con ;
             if(cont.MailingStreet == null)
                {
                   cont.MailingStreet = ' '; 
                }
                if(cont.MailingCity == null)
                {
                   cont.MailingCity = ' '; 
                }
                if(cont.MailingPostalCode == null)
                {
                   cont.MailingPostalCode = ' '; 
                }                
            	if(cont.MailingState == null)
                {
                   cont.MailingState = ' '; 
            	}
            	if(cont.MailingCountry == null)
                {
                   cont.MailingCountry = ' '; 
                }
            	
             mailingAddress = cont.MailingStreet +' '+cont.MailingCity+' '+con.MailingPostalCode+' '+ cont.MailingState+' '+con.MailingCountry;
             
        }
    }
    
    
    public PageReference edit(){
        
		String url = 'https://ibirdssoftservices-dev-ed.lightning.force.com/lightning/r/Contact/'+contactId+'/view';      
        
        PageReference objRef = new PageReference(url);
        objRef.setRedirect(true);
        return objRef;
    }  
    
    
    public PageReference deleteRecord(){
        
        Contact con = [SELECT Id ,Name ,Email ,Phone ,MailingAddress FROM Contact WHERE Id =: contactId];
        
            delete con;
        
        WrapperClassList.clear();
        
        
   List<contact> conListNew =  [SELECT Id, Name, Email, Phone, MailingStreet, MailingCity,MailingPostalCode , MailingState ,MailingCountry FROM Contact WHERE CreatedDate = THIS_MONTH];
       
        
        //WrapperClass obj = new WrapperClass(Contact con);
        
                    //WrapperClassList = new List<WrapperClass>();
            for(Contact cont:conListNew)
            {
                
        		//WrapperClass obj = new WrapperClass(Contact con);
                WrapperClassList.add(new WrapperClass(cont));
            }
        
        
        
     return null;
            }
}