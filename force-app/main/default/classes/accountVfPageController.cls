public class accountVfPageController {
    
    
    public List<Account> lstAccounts{get;set;}
    
    public accountVfPageController(){
        
        
        
        returnListAcc();
    }
    
    public List<Account> returnListAcc(){
        
        lstAccounts = [SELECT Id ,Name ,AccountNumber ,Rating FROM Account];
        return lstAccounts;
    }
    
    public PageReference save(){
        update(lstAccounts);
        return null;
    } 
    
    public PageReference reload(){
        
        String url = 'https://ibirdssoftservices-dev-ed--c.vf.force.com/apex/accountVfPage?core.apexpages.request.devconsole=1';
        
        PageReference objPr = new PageReference(url);
        objPr.setRedirect(True);
        
        return objPr;
    }
    

}