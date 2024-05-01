public with sharing class populateAssetDescriptionHandler {

   // public Boolean isFirstTime = true;
   Asset assetUp; 

    public void doBeforeInsert(List<sObject> newList){
    }
    
    public void doBeforeUpdate(List<sObject> oldList, Map<Id,sObject> oldMap, List<sObject> newList, Map<Id,sObject> newMap){
    
    }
    
    public void doBeforeDelete(List<sObject> oldList, Map<Id,sObject> oldMap){
    
    }
    
    public void doAfterInsert(List<Asset> newList, Map<Id,Asset> newMap){

       // updateAssetDescription(newList,newMap);    
    }
    
    public void doAfterUpdate(List<Asset> oldList, Map<Id,Asset> oldMap, List<Asset> newList, Map<Id,Asset> newMap){
        updateAssetDescription(newList,newMap);
    }
    
    public void doAfterDelete(List<sObject> oldList, Map<Id,sObject> oldMap){
    
    }
    
    public void doAfterUndelete(List<sObject> newList, Map<Id,sObject> newMap){
    
    }
    
    public void updateAssetDescription(List<Asset> newList,Map<Id,Asset> newMapIdAsset){

        Set<Id> setAssetIds = new Set<Id>();
        Map<Id,List<Order>> mapIdOrders = new Map<Id,List<Order>>();
        
        for(Asset eachAsset : newList){
            setAssetIds.add(eachAsset.Id);
			if(eachAsset.Orders__r != null)                
            mapIdOrders.put(eachAsset.Id, eachAsset.Orders__r);
        }

        List<Order> lstOrderRecToUp = new List<Order>();
        List<Asset> lstAssetRecToUp = new List<Asset>();

        Map<Id,Asset> mapIdAsset = new Map<Id,Asset>
            ([SELECT Id ,Name ,Description,
              (SELECT id, Name, Description from Orders__r) ,
              Product2.Description FROM Asset  WHERE Id IN : setAssetIds]);

        for(Asset eachAsset : mapIdAsset.values()){

            if(eachAsset.Description != null){

                for(Order eachOrder : mapIdOrders.get(eachAsset.Id)){

                eachOrder.Description = eachAsset.Description;  
                lstOrderRecToUp.add(eachOrder);
                }
            }
            else if(eachAsset.Description == null){

                if(eachAsset.Product2.Description !=null)

                eachAsset.Description = eachAsset.Product2.Description;

                lstAssetRecToUp.add(eachAsset);

                for(Order eachOrder : mapIdOrders.get(eachAsset.Id)){

                    eachOrder.Description = eachAsset.Product2.Description;
                    lstOrderRecToUp.add(eachOrder);
                    }
            }

        }

        if(!lstOrderRecToUp.isEmpty()){
        UPDATE lstOrderRecToUp;
        }
        if(!lstAssetRecToUp.isEmpty()){
            UPDATE lstAssetRecToUp;
            }

       // this.handleRecurssion = true;
    }

}