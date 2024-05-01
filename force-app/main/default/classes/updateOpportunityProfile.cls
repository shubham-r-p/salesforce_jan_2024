public class updateOpportunityProfile {
        
    public static void getOppIds(){
        
    Set<Id> setOppIds = new Set<Id>();
        
        for(Opportunity each : [SELECT Id, Name, Profile__c, Amount FROM Opportunity]){
            setOppIds.add(each.Id);
        }
        
        updateOppProfile(setOppIds);
    }
    
    public static void updateOppProfile(Set<Id> oppIds){
        
        List<Opportunity> allOppRec = [SELECT Id, Name, Amount, Profile__c FROM Opportunity WHERE Id IN : oppIds];
        
        for(Opportunity each : allOppRec){
            if(each.Amount > 50000){
               each.Profile__c = 'High';
            }
            else if(each.Amount > 10000 && each.Amount < 50000){
               each.Profile__c = 'Medium';
            }
            else{
               each.Profile__c = 'Low';
            }
        }
        
        update allOppRec;
    }

}