public class opportunityProductCheckingHandler {
    
    public static List<Opportunity_Product__c> oldOppProduct = [SELECT Id ,Primary_Product__c FROM Opportunity_Product__c];
    
    //a
    public static void checkOpportunityFirstProduct(List<Opportunity_Product__c> lstOppProduct){
        
        Set<Id> setOppIds = new Set<Id>();
        
        for(Opportunity_Product__c oppPro : lstOppProduct){
            
            setOppIds.add(oppPro.Opportunity__c);
        }
                
        List<Opportunity> lstopportunity = [SELECT Id ,Name ,(SELECT Id ,Primary_Product__c FROM Opportunity_Products__r) FROM Opportunity WHERE Id IN : setOppIds];
        
        for(Opportunity opp : lstopportunity){
        
        	for(Opportunity_Product__c oppProduct : lstOppProduct){
            
            	if(oppProduct.Primary_Product__c == false && (opp.Opportunity_Products__r).size() == 0){
                
                   oppProduct.Primary_Product__c = true;
            }
        }
    }
}
    
    
    //b
    public static void uncheckOldProductsIfNewChecked(List<Opportunity_Product__c> lstOppProduct , Map<Id , Opportunity_Product__c> mapOppProduct){
        
        
        Set<Id> setOppIds = new Set<Id>();
        
        for(Opportunity_Product__c oppPro : lstOppProduct){
            
            setOppIds.add(oppPro.Opportunity__c);
        }
                
        List<Opportunity_Product__c> lstOppProductToUpdate = new List<Opportunity_Product__c>();
        
        List<Opportunity> lstopportunity = [SELECT Id ,Name ,(SELECT Id ,Primary_Product__c FROM Opportunity_Products__r) FROM Opportunity WHERE Id IN : setOppIds];
       
        for(Opportunity opp : lstopportunity){
        
        	for(Opportunity_Product__c newOppProductRec : lstOppProduct){
            
            	if((opp.Opportunity_Products__r).size() > 1 && newOppProductRec.Primary_Product__c == true){
                                
                	for(Opportunity_Product__c allOldOppPro : opp.Opportunity_Products__r){
                    
                    	if( newOppProductRec.Id != allOldOppPro.Id){
                    
                    		allOldOppPro.Primary_Product__c = false;
                    		lstOppProductToUpdate.add(allOldOppPro);                    
                    }
                }
            }        
        }
	}   
        if(!lstOppProductToUpdate.isEmpty()){
        UPDATE lstOppProductToUpdate;
        }
    }
    
    
    //c
    public static void updateEventCheck(List<Opportunity_Product__c> lstOldOppProducts , Map<Id , Opportunity_Product__c> mapOldOppProducts , List<Opportunity_Product__c> lstNewOppProducts){
        
        Set<Id> setOppIds = new Set<Id>();
        
        for(Opportunity_Product__c oppPro : lstOldOppProducts){
            
            setOppIds.add(oppPro.Opportunity__c);
        }        
 
        List<Opportunity> lstopportunity = [SELECT Id ,Name ,(SELECT Id ,Primary_Product__c FROM Opportunity_Products__r) FROM Opportunity WHERE Id IN : setOppIds];
        
        List<Opportunity_Product__c> lstOppProductToUpdate = new List<Opportunity_Product__c>();
        
        for(Opportunity_Product__c newVersionOppProduct : lstNewOppProducts){
            
            Opportunity_Product__c oldVersionOppPrduct = mapOldOppProducts.get(newVersionOppProduct.Id);
            
            	if(oldVersionOppPrduct.Primary_Product__c == false && newVersionOppProduct.Primary_Product__c == true){
                
                    for(Opportunity allOpp : lstopportunity){
                        
                        for(Opportunity_Product__c allOppProduct : allOpp.Opportunity_Products__r){
                            
                    		if( newVersionOppProduct.Id != allOppProduct.Id){
                    		
                    		allOppProduct.Primary_Product__c = false;
                    		lstOppProductToUpdate.add(allOppProduct); 
                    }
				}
			}	
		}   
	}        
        if(!lstOppProductToUpdate.isEmpty()){
			UPDATE lstOppProductToUpdate;
        }
}
        
        
    //d
    public static void updateEventUncheck(List<Opportunity_Product__c> lstOldOppProducts , Map<Id , Opportunity_Product__c> mapOldOppProducts , List<Opportunity_Product__c> lstNewOppProducts , Map<Id , Opportunity_Product__c> mapNewOppProducts){
        
		
        Set<Id> setOppIds = new Set<Id>();
        
        Set<Id> oppProId = new Set<Id>();
        
        for(Opportunity_Product__c oldOppPro : lstOldOppProducts){
            
            setOppIds.add(oldOppPro.Opportunity__c);
            oppProId.add(oldOppPro.Id);
        }
        
        List<Opportunity> lstopportunity = [SELECT Id ,Name ,(SELECT Id ,Primary_Product__c FROM Opportunity_Products__r where Primary_Product__c = false AND Id not IN : oppProId limit 1) FROM Opportunity WHERE Id IN : setOppIds];
        
        List<Opportunity_Product__c> lstOppProductToUpdate = new List<Opportunity_Product__c>();
        
        for(Opportunity opp : lstopportunity){
            
            for(Opportunity_Product__c allOppPro : opp.Opportunity_Products__r){
                
                for(Opportunity_Product__c oldVerOppPro : lstOldOppProducts){
                    
                    Opportunity_Product__c newVerOppPro = mapNewOppProducts.get(oldVerOppPro.Id);
                    
                    if(oldVerOppPro.Primary_Product__c == True && newVerOppPro.Primary_Product__c == false){
                        
                        allOppPro.Primary_Product__c = true;
                        lstOppProductToUpdate.add(allOppPro);                        }
                }
            }
        }
        if(!lstOppProductToUpdate.isEmpty()){
        UPDATE lstOppProductToUpdate;
    }
    }
}
//d
        /*for(Opportunity_Product__c newVersionOppProduct : lstNewOppProducts){
            
            Opportunity_Product__c oldVersionOppPrduct = mapOldOppProducts.get(newVersionOppProduct.Id);
            
            if(oldVersionOppPrduct.Primary_Product__c == true && newVersionOppProduct.Primary_Product__c == false){
                
                for(Opportunity opp : lstopportunity){
                    
                    if(opp.Opportunity_Products__r[0].Id == opp.Opportunity_Products__r[0].Id){
                    Opportunity_Product__c oppProOld = opp.Opportunity_Products__r[0];
                    
                    oppProOld.Primary_Product__c = true;
                    
                    lstOppProductToUpdate.add(oppProOld);                    }
						
                    //if(newVersionOppProduct.Id != oldVersionOppPrduct.Id){

                    //}
                }   
            }   
        }*/