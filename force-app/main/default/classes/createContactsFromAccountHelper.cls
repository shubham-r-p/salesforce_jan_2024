public class createContactsFromAccountHelper {
    
    
    public static void createContact(List<Account> lstAccounts){
        	
        List<Contact> lstContacts = new List<Contact>();
        
        for(integer i=1 ; i<=3 ; i++){
            
            for(Account account : lstAccounts){
            
            Contact con = new Contact();
            con.LastName = account.Name+' '+i;
            con.AccountId = account.Id;
            //con.Phone = (1234).toInteger()+i;
            con.Description = ' Updated by ~upOppStageTypeAfterAccUpdate~ trigger';
            lstContacts.add(con);   
            }   
        }
        
        if(lstContacts != null){
        INSERT lstContacts;
        }
    }
}