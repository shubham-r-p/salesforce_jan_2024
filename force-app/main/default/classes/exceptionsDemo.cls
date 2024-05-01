public class exceptionsDemo {
    
    
    public void dmlException(){
        
        try{
        Account acc = new Account();
        insert acc;
        }
        
        catch(Exception ex){
            system.debug('exception caught--> '+ex);
            system.debug('exception msg--> '+ex.getMessage());
            system.debug('exception type--> '+ex.getTypeName());  
            system.debug('exception line no--> '+ex.getLineNumber());            
        }
        
        system.debug('==============================================================================================');
    }
    
    public void nullPointerException(){
        
        Account acc = new Account();
        
        system.debug('acc name--> '+acc.Name);
        
        
        
    }

}