public class contactTableSearchBoxController {
    
    public List<Contact> lstContact {get; set;}
    
    public String searchText {get; set;}    
    
    public integer totalRecs = 0;
    public Integer index = 0;
    public integer blockSize {get;set;}
    
    public boolean Firstbutton{get;set;}
    public boolean Previousbutton{get;set;}
    public boolean Nextbutton{get;set;}
    public boolean Lastbutton{get;set;}
    
    
    
    public contactTableSearchBoxController()
    {   
        blockSize = 5;
        
        totalRecs = [SELECT count() FROM Contact];
        
        lstContact = [SELECT Id ,Name ,Email ,Account.Name ,Phone FROM Contact limit : blockSize offset : index];
        
        Firstbutton=true;
        Previousbutton=true;
        Nextbutton=false;
        Lastbutton= false;     
    }
    
    
    public void searchContact()
    {
        searchText = '%'+searchText+'%';
        lstContact = [SELECT Id ,Name ,Email ,Account.Name ,Phone FROM Contact WHERE Name LIKE : searchText OR Email LIKE : searchText limit : blockSize offset : index];
        
        searchText = '';        
    }   
    
    
    public void firstButton(){        
        index = 0;
        
        lstContact = [SELECT Id ,Name ,Email ,Account.Name ,Phone FROM Contact limit : blockSize offset : index];
        
        Firstbutton=true;
        Previousbutton=true;
        Nextbutton=false;
        Lastbutton=false; 
    }
    
    
    public void previousButton(){
        // index = index - blockSize;
        
        //lstContact = [SELECT Id ,Name ,Email ,Account.Name ,Phone FROM Contact limit : blockSize offset : index];
        
        if(index > 0)
        {
            index = index - blockSize;
            lstContact = [SELECT Id ,Name ,Email ,Account.Name ,Phone FROM Contact limit : blockSize offset : index];
            Firstbutton=false;
            Previousbutton=false;
            Nextbutton=false;
            Lastbutton=false;
            if(index==0)
            {                
                Firstbutton=true;
                Previousbutton = true;
            }
            else
            {
                Firstbutton=false;
                Previousbutton=false;
            }    
        }
    }
        
        public void nxt(){
            
            index = index + blockSize;
            lstContact = [SELECT Id ,Name ,Email ,Account.Name ,Phone FROM Contact limit : blockSize offset : index];
            Firstbutton=false;
            Previousbutton=false;
        }
        
        
        public void lst(){
            // index = totalRecs - math.mod(totalRecs, blockSize);
            
            index = totalRecs - Blocksize;
            lstContact = [SELECT Id ,Name ,Email ,Account.Name ,Phone FROM Contact limit : blockSize offset : index];
            Firstbutton=false;
            Previousbutton=false;
            Nextbutton=true;
            Lastbutton=true;
        }
        
        
    }