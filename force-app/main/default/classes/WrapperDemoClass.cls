public class WrapperDemoClass {
    public String companyName;
    public String email;
    public Integer phone;
    public Long revenue;
    public List<clients> lstClients = new List<clients>();
    
    public WrapperDemoClass(String companyName, String email, Integer phone, Long revenue){
        this.companyName = companyName;
        this.email = email;
        this.phone = phone;
        this.revenue = revenue;
    }
    
    public void addClients(String companyName, String website, String email, Integer phone){
        lstClients.add(new clients(companyName, website, email, phone));
    }
    
    public void printAllClients(){
        for(clients eachCli : lstClients){
        System.debug(eachCli);
        }
    }
    
    
    private class clients{
        public String companyName;
        public String website;
        public String email;
        public Integer phone;
        
        public clients(String companyName, String website, String email, Integer phone){
            this.companyName = companyName;
            this.website = website;
            this.email = email;
            this.phone = phone;
        }
    }
    
            /*
        WrapperDemoClass objInstance = new WrapperDemoClass('myComp','myComp@mcomp.com',111223344,1123L);
        
        objInstance.addClients('1stClient','1stClient@.com','1stClient@gmail.com',1);
        objInstance.addClients('2ndClient','2ndClient@.com','2ndClient@gmail.com',2);
        objInstance.addClients('3rdClient','3rdClient@.com','3rdClient@gmail.com',3);
        objInstance.addClients('4thClient','4thClient@.com','4thClient@gmail.com',4);
        
        objInstance.printAllClients();
        */
    
}