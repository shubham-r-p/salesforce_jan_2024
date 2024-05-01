public class contactEditDeletePageController {
    
    public mailAddressWrapper objMailAddWrap{get;set;}
    
    public List<mailAddressWrapper> lstAddWrap{get;set;}
    
        public Map< id , mailAddressWrapper> mapWraperrCls{get;set;}

    
    //wrapper class
    public class mailAddressWrapper{
                
        public string MailingStreet{get;set;}
        public string MailingCity{get;set;}
        public string MailingPostalCode{get;set;}
        public string MailingState{get;set;}
        public string MailingCountry{get;set;}
        
    }    
    
    
    public List<Contact> lstContacts{get;set;}
    public Id contactId{get;set;}
    public String address{get;set;}

    
    public contactEditDeletePageController(){
        
        lstContacts = [SELECT Id ,Name ,Email ,Phone ,MailingStreet,MailingCity,MailingPostalCode,MailingState,MailingCountry FROM Contact WHERE CreatedDate = This_month];
        
        
        lstAddWrap = new List<mailAddressWrapper>();
        
        mapWraperrCls = new Map< id , mailAddressWrapper>();
        
        //Contact lstConForAdd = [SELECT Id ,Name ,Email ,Phone ,MailingStreet,MailingCity,MailingPostalCode,MailingState,MailingCountry FROM Contact WHERE Id =: contactId];
        
        for(Contact con : lstContacts){
        
            
        objMailAddWrap = new mailAddressWrapper();
        
            
        objMailAddWrap.MailingStreet = con.MailingStreet;
        objMailAddWrap.MailingCity = con.MailingCity;
        objMailAddWrap.MailingPostalCode = con.MailingPostalCode;
        objMailAddWrap.MailingState = con.MailingState;
        objMailAddWrap.MailingCountry = con.MailingCountry;

        lstAddWrap.add(objMailAddWrap);
            
            
            
            for(mailAddressWrapper obj : lstAddWrap){
                
                
                address = obj.MailingStreet;
                address = address+obj.MailingCity;
                address = address+obj.MailingPostalCode;
                address = address+obj.MailingState;
                address = address+obj.MailingCountry;

                
                break;
            }
            
				system.debug(address);
            
            }
    }
    
    

    

    
    public PageReference edit(){
        
		String url = 'https://ibirdssoftservices-dev-ed.lightning.force.com/lightning/r/Contact/'+contactId+'/view';
        
        //https://ibirdssoftservices-dev-ed.lightning.force.com/lightning/r/Contact/0035i00000DKkgRAAT/edit?navigationLocation=
        //LIST_VIEW_ROW&count=2&backgroundContext=%2Flightning%2Fo%2FContact%2Flist%3FfilterName%3DRecent
        
        PageReference objRef = new PageReference(url);
        objRef.setRedirect(true);
        return objRef;
    }     
    
    public PageReference deleteRecord(){
        
        Contact con = [SELECT Id ,Name ,Email ,Phone ,MailingAddress FROM Contact WHERE Id =: contactId];
        
        if(con != NULL){
            delete con;
        }
        
        //https://ibirdssoftservices-dev-ed.lightning.force.com/lightning/n/Recent_Contacts
        //PageReference objRef = new PageReference('/apex/contactEditDeletePage');
        
        //PageReference objRef = new PageReference('/lightning/n/Recent_Contacts');
        //objRef.setRedirect(true);
        return null;
    }    
}

/*public class contactEditDeletePageController {
    
    public List<Contact> lstContacts{get;set;}
    public Id contactId{get;set;}
    
    public contactEditDeletePageController(){
        
        lstContacts = [SELECT Id ,Name ,Email ,Phone ,MailingAddress FROM Contact WHERE CreatedDate = This_month];
    }
    
    
    public PageReference edit(){
        
		String url = 'https://ibirdssoftservices-dev-ed.lightning.force.com/lightning/r/Contact/'+contactId+'/view';
        
        //https://ibirdssoftservices-dev-ed.lightning.force.com/lightning/r/Contact/0035i00000DKkgRAAT/edit?navigationLocation=
        //LIST_VIEW_ROW&count=2&backgroundContext=%2Flightning%2Fo%2FContact%2Flist%3FfilterName%3DRecent
        
        PageReference objRef = new PageReference(url);
        objRef.setRedirect(true);
        return objRef;
    }     
    
    public void deleteRecord(){
        
        Contact con = [SELECT Id ,Name ,Email ,Phone ,MailingAddress FROM Contact WHERE Id =: contactId];
        system.debug('Contact :'+con);
        
        if(con != NULL){
            delete con;
        }
        
        //https://ibirdssoftservices-dev-ed.lightning.force.com/lightning/n/Recent_Contacts
        //PageReference objRef = new PageReference('/apex/contactEditDeletePage');
        
        PageReference objRef = new PageReference('/lightning/n/Recent_Contacts');
        objRef.setRedirect(true);
        return objRef;
}
}*/