public class insertingAccConOppController {
    
    public String accName{get;set;}
    public String LastName{set;get;}
    public String oppName{set;get;}
    public Date closeDate{set;get;}
    public String stageName{set;get;}
	
    public void Save(){
        
        Account account = new Account(Name = accName);
        insert account;
        
        Contact contact = new Contact(LastName = LastName , AccountId = account.Id);
        insert contact;
        
        Opportunity opportunity = new Opportunity(Name = oppName,CloseDate = closeDate, StageName =  stageName, AccountId = account.Id );
        insert opportunity;
    }
    
    public PageReference reload(){
        
        String url = '/apex/insertingAccConOpp?core.apexpages.request.devconsole=1';
        
        PageReference objPr = new PageReference(url);
        objPr.setRedirect(true);
        return objPr;
    }
    

}