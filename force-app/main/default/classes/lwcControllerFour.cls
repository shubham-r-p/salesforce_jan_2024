public class lwcControllerFour {
    
    @AuraEnabled
    public static List<String> returnAllConFields(){
        
        
        Map<String , Schema.RecordTypeInfo> conRecordTypeIdd = 
            Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByName();
        
        List<Schema.RecordTypeInfo> lstRecordTypeInfo = conRecordTypeIdd.values();
        
        system.debug('mapKeySet--> '+conRecordTypeIdd.keySet());
        system.debug('lstValues--> '+lstRecordTypeInfo);
        
        Map<String , Id> mapRecTypeId = new Map<String , Id>();
        
        for(Schema.RecordTypeInfo eachRecType : lstRecordTypeInfo){
            mapRecTypeId.put(eachRecType.getDeveloperName() , eachRecType.getRecordTypeId());
        }
        
        system.debug('map--> '+mapRecTypeId);
        
        
        
        
        
        
        //Dynamically get recordTypeId with recordType and objectName

        Schema.DescribeSObjectResult caseRecordTypeId = 
            
            Schema.getGlobalDescribe().get('Contact').getDescribe();
        
        
        
        Map<String , Schema.RecordTypeInfo> conRecordTypeId = 
            
            Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByName();
        
       // system.debug(conRecordTypeId);
        
        
         
            //Schema.getGlobalDescribe().get('Contact').getDescribe().getRecordTypeInfosByName().get('fs').getRecordTypeId();
        
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get('contact');
        Map<String, Schema.SObjectField> fieldMap = targetType.getDescribe().fields.getMap();
        
        List<String> lstFields = new List<String>();
        
        for (Schema.SObjectField field : fieldMap.values()) {
            
            lstFields.add(field.getDescribe().getName());
        }
        
        system.debug('list-->'+lstFields);
        
        return lstFields;
    }
    
    
    
    @AuraEnabled
    public static List<String> lstContactFields(){
        
        List<String> lstFields = new List<String>();
        
        for(Schema.FieldSetMember fieldSetMemberObj : SObjectType.Contact.FieldSets.fs
            .getFields())
        {
            lstFields.add(fieldSetMemberObj.getFieldPath());
            system.debug(fieldSetMemberObj.getFieldPath());
            
        }
        
        return lstFields;
    }
    
    
    @AuraEnabled
    public static Id insertCon(Account acc){
        
        try{
            acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('cusRecType').getRecordTypeId();
            
            insert acc;
            
            return acc.Id;
        }
        catch(Exception e){
            
            throw new AuraHandledException(e.getMessage());
        }
        
        
    }
    
    
    @AuraEnabled
    public static List<Contact> returnContacts(String email){
        
        try{
            String searchK = '%'+email+'%';
            
            List<Contact> lstConatct = [SELECT Id, MailingAddress, Name, Email FROM Contact WHERE Email LIKE : searchK];
            
            return lstConatct;
        }
        catch(Exception e){
            
            throw new AuraHandledException(e.getMessage());
        }        
    }
    
    
    @AuraEnabled
    public static List<Lead> returnLeads(String email){
        
        try{
            String searchK = '%'+email+'%';
            
            List<Lead> lstLead = [SELECT Id, Address, Name, Email FROM Lead WHERE Email LIKE : searchK];
            
            return lstLead;
        }
        catch(Exception e){
            
            throw new AuraHandledException(e.getMessage());
        }                
    }
    
    
    @AuraEnabled
    public static List<Account> lstAllAccCon(){
        
        List<Account> lstAccCon = [SELECT Id ,Name ,(SELECT Id ,Name ,LastName ,FirstName FROM Contacts),
                                   (SELECT Id ,Name , Amount ,StageName FROM Opportunities) FROM Account limit 5];
        
        return lstAccCon;
        
    }
}