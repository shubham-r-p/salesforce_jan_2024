public class wrapperClassDemo {
    
    // public List<myWrapClass> myWrapListWithAccContacts;
    
    public wrapperClassDemo(){
        
        List<Account> lstAccWithContacts = [SELECT Id , Name ,(SELECT Id , Name FROM Contacts) FROM Account];
        
        List<MyWrapClass>  myWrapListWithAccContacts = new List<MyWrapClass>();
        
        for(Account eachAcc : lstAccWithContacts){
            
            myWrapListWithAccContacts.add(new myWrapClass(eachAcc , eachAcc.Contacts));
            
        }  
        
        for(MyWrapClass eachWrapCls : myWrapListWithAccContacts){
            
            system.debug('eachWrapObj--> '+eachWrapCls);
            system.debug('eachWrap acc--> '+eachWrapCls.acc);
            system.debug('eachWrap con list size --> '+eachWrapCls.conList.size());            
            system.debug('eachWrap con list--> '+eachWrapCls.conList);
            
            system.debug('===================================================================================================');
        }
    }
    
    
    public class MyWrapClass{
        
        public Account acc;
        public List<Contact> conList;
        
        public myWrapClass(Account acc , List<Contact> accContacts){
            
            this.acc = acc;
            this.conList = accContacts;
            
        }        
    }
    
}