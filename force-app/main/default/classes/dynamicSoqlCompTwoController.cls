public class dynamicSoqlCompTwoController {
    
    @AuraEnabled
    public static List<dynamicObjectsForSOQL__c> returnObjects(){
        
        List<dynamicObjectsForSOQL__c> lstSobjects = [SELECT Id, Name, API_Name__c FROM dynamicObjectsForSOQL__c];        
        return lstSobjects;
    }
    
    
    @AuraEnabled
    public static List<fieldsWrapper> returnSobjectFields(String sObj){
                        
        Map<String, Schema.SObjectField> schemaMap = Schema.getGlobalDescribe().get(sObj).getDescribe().fields.getMap();
        List<fieldsWrapper> allFields = new List<fieldsWrapper>();
        
        for(String each : schemaMap.keySet()){
            
            fieldsWrapper newField = new fieldsWrapper();
            String temp = schemaMap.get(each).getDescribe().getName();
			newField.label = temp;  
            newField.value = temp;      
        
            allFields.add(newField);
        }
        
        return allFields;
    }
    
    
    @AuraEnabled
    public static List<Sobject> returnRecords(String sObj , List<String> selectedFields){
        
        try{
            String query = 'SELECT ';
             
            query += String.join(selectedFields, ',');
            
            query += ' FROM '+sObj;
            
            system.debug('Query --> '+query);
            system.debug('Query --> '+Database.query(query));
            
            return Database.query(query);
        }
        catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
                
    }
    
    
    public class fieldsWrapper{
        
        @AuraEnabled
        public string label;
        @AuraEnabled
        public string value;       
    }

}