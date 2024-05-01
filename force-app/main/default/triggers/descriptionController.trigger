trigger descriptionController on Asset (after update) {
    
    if(Trigger.isAfter){
        
        if(Trigger.isUpdate){
            
            Set<Id> setAssetRecIds = new Set<Id>();
            
           // List<Asset> lstAssetsAndOrders = [SELECT Id , Description ,(SELECT Id , Description FROM Orders)
             //                                 FROM Asset WHERE Id IN : Trigger.new];
            
            
            
        }
        
    }

}