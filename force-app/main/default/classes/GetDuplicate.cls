public class GetDuplicate {
    
    public static List<Opportunity> checkDuplicates(){
        
        List<Opportunity> allOpportunities = [SELECT Id, Name, Quote__c, 
                                              LastModifiedDate FROM Opportunity Order By LastModifiedDate Desc];
        
        Map<String,List<Opportunity>> mapQuoteOpportunity = new Map<String, List<Opportunity>>();
        
        for(Opportunity each : allOpportunities){
            if(String.isNotBlank(each.Quote__c)) {
                if(!mapQuoteOpportunity.containsKey(each.Quote__c)) {
                    mapQuoteOpportunity.put(each.Quote__c, new List<Opportunity>());
                } 
                mapQuoteOpportunity.get(each.Quote__c).add(each);    
            }
        }
        
        system.debug('mapQuoteOpportunity --> '+mapQuoteOpportunity);
        
        List<Opportunity> duplicateOpportunities = new List<Opportunity>();
        
        for(String eachQuote : mapQuoteOpportunity.keySet()){            
            try{                
                List<Opportunity> duplicateOpp = mapQuoteOpportunity.get(eachQuote);                
                if(duplicateOpp != null && duplicateOpp.size() > 1){                       
                    Datetime latestModifiedDate = Datetime.newInstance(1900, 1, 1, 0, 0, 0);                
                    Opportunity latestOpportunity;
                    
                    for (Opportunity opp : duplicateOpp) {
                        Datetime opportunityModifiedDate = opp.LastModifiedDate;
                        
                        if (opportunityModifiedDate > latestModifiedDate) {
                            latestModifiedDate = opportunityModifiedDate;
                            latestOpportunity = opp;
                        }
                    }
                    for(Opportunity opp : duplicateOpp) {
                        if(opp.Id != latestOpportunity.Id) {
                            duplicateOpportunities.add(opp);
                        }
                    }
                }
            }
            Catch(Exception e){
                system.debug(e);
            }
        }
        
        //if(!duplicateOpportunities.isEmpty()){
        //delete dup
        //  return duplicateOpportunities;
        //}        
        return null;
    }
    
    public static List<Opportunity> getDup(){
        
        List<AggregateResult> res = [SELECT Quote__c , Count(Id) FROM 
                                     Opportunity GROUP BY Quote__c HAVING COUNT(Quote__c) > 1];
        
        
        for (AggregateResult ar : res)  {
            
        //Id entProductId = (Id)agrResult.get('entProductId');
        //String usageType = (string)agrResult.get('usageType');            
            system.debug('ar --> '+ar);
        }
        

        
        return null;
    }
}