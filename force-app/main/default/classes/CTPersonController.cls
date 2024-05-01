public with sharing class CTPersonController {


    public static String getToken(String mobile){

        System.debug('mobile --> '+mobile);
        
        Blob targetBlob = Blob.valueOf(mobile);
        Blob hash = Crypto.generateDigest('MD5', targetBlob);
        System.debug('token --> '+EncodingUtil.base64Encode(hash));

        return EncodingUtil.base64Encode(hash);
    }

    public static List<Person__c> getRecentHealthChanges(){

        List<Person__c> lstPersonRec = [SELECT Id, Name, Mobile__c, Health_Status__c, Status_Update_Date__c, Token__c FROM 
                                        Person__c ORDER BY Status_Update_Date__c DESC NULLS LAST LIMIT 100];
                                        
                                        return lstPersonRec;
    }
                                    
    public static List<Person__c> searchPeople(String searchTerm){
        
        searchTerm += '%';
        
        List<Person__c> lstPersonRec = [SELECT Id, Name, Mobile__c, Health_Status__c, Status_Update_Date__c, Token__c 
                                        FROM Person__c WHERE 
                                        Name like :searchTerm OR 
                                        Mobile__c like :searchTerm OR 
                                        Token__c like :searchTerm ORDER BY Status_Update_Date__c DESC NULLS LAST];

        return lstPersonRec;
    }

    public static Person__c getPersonById(String personId){

        List<Person__c> people = [SELECT Id, Name, Mobile__c, Health_Status__c, Status_Update_Date__c, Token__c 
                                  FROM Person__c WHERE Id =: personId];

        if(!people.isEmpty()){
            return people[0];
        }
        return null;
    }
    
    public static List<People_Tracing__c> getTraces(String recordId){
        
        //List<People_Tracing__c> lstPeopleTracing =
           return [SELECT Id, Name, Contact_Date__c, Contact_Type__c, Person_1__c, 
                                                    Person_2__c FROM People_Tracing__c 
                                                    WHERE Person_1__c=: recordId
                                                    OR Person_2__c=: recordId
                                                    ORDER BY Contact_Date__c DESC];
        /*
        if(!lstPeopleTracing.isEmpty()){
            return lstPeopleTracing;
        }
        return null;*/
    }
    
    public static List<People_Tracing__c> checkDuplicates(List<People_Tracing__c> peopleTraces){
        
        //store person ids here
        Set<Id> personIds = new Set<Id>();
        
        for(People_Tracing__c each : peopleTraces){
            personIds.add(each.Person_1__c);
            personIds.add(each.Person_2__c);
        }
        
        List<People_Tracing__c> lstDuplicates = new List<People_Tracing__c>();
        
        Map<Id, Set<Id>> mapPersonOneIdSetPerTwoIds = new Map<Id, Set<Id>>();
        
   List<People_Tracing__c> lstExistingRec = [SELECT Id, Name, Contact_Date__c, Contact_Type__c, Person_1__c, Person_2__c 
                                                  FROM People_Tracing__c
                                                  WHERE Person_1__c IN : personIds AND
                                                  Person_2__c IN : personIds
                                                 ];
        
        if(lstExistingRec != null && lstExistingRec.size() > 0){
            
            for(People_Tracing__c each : lstExistingRec){
                if(!mapPersonOneIdSetPerTwoIds.containsKey(each.Person_1__c)){
                    mapPersonOneIdSetPerTwoIds.put(each.Person_1__c, new Set<Id>());
                }
                mapPersonOneIdSetPerTwoIds.get(each.Person_1__c).add(each.Person_2__c);
                
                if(!mapPersonOneIdSetPerTwoIds.containsKey(each.Person_2__c)){
                    mapPersonOneIdSetPerTwoIds.put(each.Person_2__c, new Set<Id>());
                }
                mapPersonOneIdSetPerTwoIds.get(each.Person_2__c).add(each.Person_1__c);
            }
        }
                
        for(People_Tracing__c each : peopleTraces){
            if((mapPersonOneIdSetPerTwoIds.containsKey(each.Person_1__c) && 
               mapPersonOneIdSetPerTwoIds.get(each.Person_1__c).contains(each.Person_2__c)) || 
				(mapPersonOneIdSetPerTwoIds.containsKey(each.Person_2__c) && 
               mapPersonOneIdSetPerTwoIds.get(each.Person_2__c).contains(each.Person_1__c))){
                   lstDuplicates.add(each);
               }
        }
        return lstDuplicates;
    }
     
    
}