trigger OrderOfExecution_Demo on OOE__c (before insert, after insert, before update, after update) {
    
    public static Boolean handleRecursion = true;
    
    if(Trigger.isInsert){
        
        if(Trigger.isInsert && Trigger.isBefore){
            
            for(OOE__c eachRec : Trigger.new){
                if(eachRec.Run_Apex_Trigger__c == true){
                    eachRec.Counter__c += 1;
                    eachRec.Stack__c += ' -> Before Insert Trigger ';                    
                }
            }
        }
        
        if(Trigger.isInsert && Trigger.isAfter){
            
            if(Trigger.new[0].Run_Apex_Trigger__c == true ){
                
                OOE__c currentRecord = [SELECT Id, Counter__c, Stack__c FROM OOE__c WHERE Id =: Trigger.new[0].Id];
                
                for(OOE__c eachRec : Trigger.new){
                    currentRecord.Counter__c += 1;
                    currentRecord.Stack__c += ' -> After Insert Trigger ';  
                }  
                
                UPDATE currentRecord;
            }
        }
    }
    
    if(Trigger.isUpdate){
        
        if(Trigger.isUpdate && Trigger.isBefore){
            
            for(OOE__c eachRec : Trigger.new){
                if(eachRec.Run_Apex_Trigger__c == true){
                    eachRec.Counter__c += 1;
                    eachRec.Stack__c = eachRec.Stack__c + ' -> Before Update Trigger ';                    
                }
            }
        }
        
        if(Trigger.isUpdate && Trigger.isAfter){
            
            System.debug('---------- Inside After Update Trigger ----------');
            
            for(OOE__c eachRec : Trigger.new){
                if(eachRec.Run_Apex_Trigger__c == true){  
                    
                    System.debug('Name --> '+eachRec.Name);
                    System.debug('Counter --> '+eachRec.Counter__c);
                    System.debug('Stack --> '+eachRec.Stack__c+' \n');
                }
            }
        }
    }
}

/*
 


        if(Trigger.isInsert && Trigger.isAfter){
            
            if(Trigger.new[0].Run_Apex_Trigger__c == true){
                Contact con = new Contact();
                
                OOE__c currentRecord = [SELECT Id, Counter__c, Stack__c FROM OOE__c WHERE Id =: Trigger.new[0].Id];
                System.debug('id --> '+Trigger.new[0].Id);
                
                for(OOE__c eachRec : Trigger.new){
                    
                    currentRecord.Counter__c += 1;
                    currentRecord.Stack__c += ' -> After Insert Trigger ';
                    
                    con.OOE__c = eachRec.Id;
                    con.LastName = eachRec.Name;
                    con.Counter__c = 1;
                    con.Stack__c = eachRec.Stack__c + ' -> After Insert Trigger (Contact) ';  
                    System.debug('23 --> '+con.Stack__c);
                    
                }    
                UPDATE currentRecord;
           }
       }



        if(Trigger.isUpdate && Trigger.isAfter){
            
            Map<OOE__c,List<Contact>> mapOOeContacts = new Map<OOE__c,List<Contact>>();
            
            List<Contact> lstContacts = new List<Contact>();
             
            for(OOE__c eachRec : [SELECT Id, Counter__c ,Stack__c,Run_Apex_Trigger__c, 
                                  (SELECT Id, Counter__c ,Stack__c FROM Contacts__r) FROM OOE__c]){
                
                mapOOeContacts.put(eachRec,eachRec.Contacts__r);
            }
            
            OOE__c currentRecord = [SELECT Id, Counter__c, Stack__c FROM OOE__c WHERE Id =: Trigger.new[0].Id];
            System.debug('id --> '+Trigger.new[0].Id);
            
            for(OOE__c eachRec : mapOOeContacts.keySet()){
                if(eachRec.Run_Apex_Trigger__c == true && !handleRecursion){      
                    
                    currentRecord.Counter__c += 1;
                    currentRecord.Stack__c += ' -> After Update Trigger ';
                    
                    for(Contact eachCon : eachRec.Contacts__r){
                        eachCon.Counter__c += 1;
                        eachCon.Stact_Two__c = eachRec.Stack__c + ' -> After Update Trigger (Contact) ';   
                        lstContacts.add(eachCon);
                    }           
                    handleRecursion = true;
                }
            }   
                UPDATE currentRecord;
            UPDATE lstContacts;
        }










*/