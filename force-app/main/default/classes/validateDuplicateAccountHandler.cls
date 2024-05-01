public with sharing class validateDuplicateAccountHandler {
    
    public void doBeforeInsert(List<sObject> newList){
        //validateAccRecBeforeInsert(newList);

    }
    
    public void doBeforeUpdate(List<Contact> oldList, Map<Id,Contact> oldMap, List<Contact> newList, Map<Id,Contact> newMap){
        //validateConRecBeforeUpdate(oldList,oldMap,newList,newMap);
        
    }
    
    public void doBeforeDelete(List<sObject> oldList, Map<Id,sObject> oldMap){

    }
    
    public void doAfterInsert(List<Contact> newList, Map<Id,Contact> newMap){
        updateContactCountOnAcc(newList,newMap);
        updateAllContactsOnAcc(newList,newMap);
    }
    
    public void doAfterUpdate(List<Contact> oldList, Map<Id,Contact> oldMap, List<Contact> newList, Map<Id,Contact> newMap){
        updateContactCountOnAccAfterUp(oldList,oldMap,newList,newMap);
    }
    
    public void doAfterDelete(List<Contact> oldList, Map<Id,Contact> oldMap){
        updateConCountOnAccAfterConDel(oldList,oldMap);
    }
    
    public void doAfterUndelete(List<Contact> newList, Map<Id,Contact> newMap){
        updateContactCountOnAcc(newList,newMap);
    }

    // Listing All Contact records on Account All Contacts fields

    public void updateAllContactsOnAcc(List<Contact> lstNewContacts , Map<Id,Contact> mapNewContacts){

        Set<Id> setAccIds = new Set<Id>();

        for(Contact eachCon : lstNewContacts){

            if(eachCon.AccountId != null)
            setAccIds.add(eachCon.AccountId);
        }

        List<Account> lstAccToUpWithCon = [SELECT Id ,Name ,All_Contacts__c ,(SELECT Id ,AccountId ,Name FROM Contacts ORDER BY CreatedDate ASC) FROM Account WHERE Id IN : setAccIds];

        List<Account> lstAccToUp = new List<Account>();
        
        for(Account eachAcc : lstAccToUpWithCon){

            if(eachAcc.Contacts.size() > 0){
               Map<Id,String> mapAccIdContacts = processContactsForAllContactsAcc(eachAcc.Contacts);
               eachAcc.All_Contacts__c = mapAccIdContacts.get(eachAcc.Id);
            }
            lstAccToUp.add(eachAcc);
        }

        if(!lstAccToUp.isEmpty())
        UPDATE lstAccToUp;
    }

    public Map<Id,String> processContactsForAllContactsAcc(List<Contact> lstConToProcess){

        Map<Id,String> mapToReturn = new Map<Id,String>();

        List<String> allContacts = new List<String>();
        Id accId;

        for(Integer i=0,count=1;i<lstConToProcess.size();i++){

            allContacts.add(count+') '+lstConToProcess[i].Name);
            accId = lstConToProcess[i].AccountId;

            count++;
        }

        String singleContactList = String.join(allContacts,' \n');

        mapToReturn.put(accId,singleContactList);
        return mapToReturn;
    }







    // RollUp Summary using AggregateResult

    public void updateContactCountOnAcc(List<Contact> lstNewContacts,Map<Id,Contact> newMapIdContacts){

        Set<Id> setAccIds = new Set<Id>();

        for(Contact eachCon : lstNewContacts){
            if(eachCon.AccountId != null)
            setAccIds.add(eachCon.AccountId);
        }        

        List<Account> lstAccWithCon = [SELECT Id ,Name ,Contacts_Count__c FROM Account WHERE Id IN : setAccIds];

        Map<Id,Integer> mapAccConCount = new Map<Id,Integer>();

        List<AggregateResult> lstConByAcc = [SELECT AccountId,count(Id)conCount From Contact WHERE AccountId IN : setAccIds GROUP BY AccountId];

        for(AggregateResult each : lstConByAcc){
    
            System.debug('AccountId -->'+each.get('AccountId'));
            System.debug('Count --> '+each.get('conCount'));
            
        mapAccConCount.put( (Id)each.get('AccountId'),(Integer)each.get('conCount'));
        }

        for(Account eachAcc : lstAccWithCon){
            eachAcc.Contacts_Count__c = (Integer) mapAccConCount.get(eachAcc.Id);
        }
        UPDATE lstAccWithCon;
    }



    public void updateContactCountOnAccAfterUp(List<Contact> oldList,Map<Id,Contact> mapOldContacts, List<Contact> lstNewCon , Map<Id,Contact> newMap){

        Set<Id> setAccIds = new Set<Id>();

        for(Contact eachCon : lstNewCon){
            if(eachCon.AccountId != null)
            setAccIds.add(eachCon.AccountId);
            if(mapOldContacts.get(eachCon.Id).AccountId != null)
            setAccIds.add(mapOldContacts.get(eachCon.Id).AccountId);
        }  

        List<Account> lstAccountToUp = [SELECT Id ,Name ,Contacts_Count__c FROM Account WHERE Id IN : setAccIds];

        Map<Id,Integer> mapAccConCount = new Map<Id,Integer>();

        List<AggregateResult> lstAccIdConCount = [SELECT AccountId ,count(Id)conCount FROM Contact WHERE AccountId IN : setAccIds GROUP BY AccountId];

        for(AggregateResult each : lstAccIdConCount){

            System.debug('after up AccountId -->'+each.get('AccountId'));
            System.debug('after up Count --> '+each.get('conCount'));

            mapAccConCount.put((Id)each.get('AccountId'),(Integer)each.get('conCount'));
        }

        for(Account eachAcc : lstAccountToUp){

          if(mapAccConCount.keySet().contains(eachAcc.Id)){
            eachAcc.Contacts_Count__c = (Integer)mapAccConCount.get(eachAcc.Id);
          }
        }

        UPDATE lstAccountToUp;
    }


    public void updateConCountOnAccAfterConDel(List<Contact> lstOldCon , Map<Id,Contact> mapOldIdContact){

        Set<Id> setAccIds = new Set<Id>();

        for(Contact eachCon : lstOldCon){

            if(eachCon.AccountId != null)
            setAccIds.add(eachCon.AccountId);
        }

        List<Account> lstAccToUp = [SELECT Id ,Name ,Contacts_Count__c FROM Account WHERE Id IN : setAccIds];

        Map<Id,Integer> mapAccIdConCount = new Map<Id,Integer>();

        List<AggregateResult> lstEachAccConCount = [SELECT AccountId ,count(Id)conCount FROM Contact WHERE AccountId IN : setAccIds GROUP BY AccountId];

        for(AggregateResult eachAgg : lstEachAccConCount){

            System.debug('AccountId -->'+eachAgg.get('AccountId'));
            System.debug('Count --> '+eachAgg.get('conCount'));
            
            mapAccIdConCount.put((Id)eachAgg.get('AccountId'),(Integer)eachAgg.get('conCount'));
        }

        for(Account eachAcc : lstAccToUp){

            eachAcc.Contacts_Count__c = (Integer)mapAccIdConCount.get(eachAcc.Id);
        }

        UPDATE lstAccToUp;
    }









    // Validate Duplicate contact by Email, Mobile and Phone
    
    public void validateAccRecBeforeInsert(List<Contact> newList){

            List<Contact> lstAllCon = [SELECT Id ,Name ,Email ,Phone ,MobilePhone FROM Contact];

            Set<String> setAllEmails = new Set<String>();
            Set<String> setAllPhones = new Set<String>();
            Set<String> setAllMobiles = new Set<String>();

            for(Contact eachOldCon : lstAllCon){
                if(!String.isEmpty(eachOldCon.Email)){
                    setAllEmails.add(eachOldCon.Email);
                }
                if(!String.isEmpty(eachOldCon.Phone)){
                    setAllPhones.add(eachOldCon.Phone);
                }
                if(!String.isEmpty(eachOldCon.MobilePhone)){
                    setAllMobiles.add(eachOldCon.MobilePhone);
                }
            }

            Set<String> setAll = new Set<String>();

            for(Contact con : [SELECT Id ,Name ,Email ,Phone ,MobilePhone FROM Contact where Email In : setAllEmails OR  Phone IN : setAllPhones OR  MobilePhone In: setAllMobiles] ){
                if(con.Email != null)
                setAll.add(con.Email);
                if(con.Phone != null)
                setAll.add(con.Phone);
                if(con.MobilePhone != null)
                setAll.add(con.MobilePhone);
            }

            for(Contact eachNewContact : newList){

                if(setAll.contains(eachNewContact.Email) || setAll.contains(eachNewContact.Phone) || setAll.contains(eachNewContact.MobilePhone)){
                    eachNewContact.addError('Contact with duplicate email , phone and mobile is not allowed !');
                }
            }
    }


    public void validateConRecBeforeUpdate(List<Contact> oldList,Map<Id,Contact> mapOldContacts, List<Contact> lstNewCon , Map<Id,Contact> newMap){

        System.debug('Inside before update');

        Set<Id> setUpdatedAccs = new Set<Id>();

        Set<String> setAllEmails = new Set<String>();
        Set<String> setAllPhones = new Set<String>();
        Set<String> setAllMobiles = new Set<String>();

        for(Contact eachOldCon : [SELECT Id ,Name ,Email ,Phone ,MobilePhone FROM Contact]){
            setUpdatedAccs.add(eachOldCon.Id);

            if(!String.isEmpty(eachOldCon.Email)){
                setAllEmails.add(eachOldCon.Email);
            }
            if(!String.isEmpty(eachOldCon.Phone)){
                setAllPhones.add(eachOldCon.Phone);
            }
            if(!String.isEmpty(eachOldCon.MobilePhone)){
                setAllMobiles.add(eachOldCon.MobilePhone);
            }
        }

       // Map<Id,Contact> mapConRec = new Map<Id,Contact>([SELECT Id ,Name ,Phone ,Email ,MobilePhone FROM Contact WHERE Id IN : setUpdatedAccs]);

        for(Contact eachCon : lstNewCon){

            if(setAllEmails.contains(eachCon.Email) || setAllPhones.contains(eachCon.Phone) || setAllMobiles.contains(eachCon.MobilePhone)){

                System.debug('Inside before update 2');

                eachCon.addError('Contact with duplicate email , phone and mobile is not allowed !');
            }
        }
    }


}