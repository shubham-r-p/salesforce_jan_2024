trigger populateAssetDescription on Asset (Before Insert, Before Update, Before Delete, After Insert, After Update, After Delete, After Undelete) {
    populateAssetDescriptionHandler handler = new populateAssetDescriptionHandler();
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            handler.doBeforeInsert(trigger.new);
        }else if(Trigger.isUpdate){
            handler.doBeforeUpdate(trigger.old, trigger.oldmap, trigger.new, Trigger.newmap);
        }else if(Trigger.isDelete){
            handler.doBeforeDelete(trigger.old, trigger.oldmap);
        }
    }else if(Trigger.isAfter){
        if(Trigger.isInsert){
            handler.doAfterInsert(trigger.new, trigger.newmap);
        }else if(Trigger.isUpdate){
           // if(handler.isFirstTime){
           // handler.isFirstTime = false;
            handler.doAfterUpdate(trigger.old, trigger.oldmap, trigger.new, Trigger.newmap);
          //  }
        }else if(Trigger.isDelete){
            handler.doAfterDelete(trigger.old, trigger.oldmap);
        }else if(Trigger.isUndelete){
            handler.doAfterUndelete(trigger.new, trigger.newmap);
        }
    }

}