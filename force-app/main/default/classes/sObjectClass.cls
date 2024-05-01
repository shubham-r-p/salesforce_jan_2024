public class sObjectClass {
    
    public static void methodOne(){
        Account accObj = new Account(Id='0015i00000kcZIrAAM',Name='WingNut Films',Rating='Warm');
        //insert accObj;
        
        Opportunity oppObj = new Opportunity(Id='0065i00000EUxcUAAT',Name='WingNut Films',StageName='Closed-Won',
                                             CloseDate=date.today(),AccountId=accObj.Id);
        //insert oppObj;
        
        //accObj.Name = 'New Line Cinema';
        //update accObj;
        
        //oppObj.StageName = 'Closed-Won';
        //update oppObj;
        
        //delete oppObj;
        
        List<Opportunity> oppDeleted = [SELECT Id FROM Opportunity WHERE isDeleted=true ALL ROWS];
        
        undelete oppDeleted;    
    }
    
    public static void methodTwo(){
        
        /*SObject accObj = (SObject)Type.forName('Account').newInstance();
		accObj.put('Name','WingNut Films');
		accObj.put('Rating','Today');
        insert accObj;

        
        SObject oppObj = (SObject)Type.forName('Opportunity').newInstance();
        oppObj.put('Name','Lord Of The Rings');
        oppObj.put('StageName','Warm');
        oppObj.put('CloseDate',date.today());
        oppObj.put('AccountId',accObj.Id);
        insert oppObj;*/
        
        /*SObject accObjUpdate = Database.query('SELECT Id, Name FROM Account WHERE Name =\'WingNut Films\' LIMIT 1');
        accObjUpdate.put('Name','New Line Cinema');
        update accObjUpdate;
        
        SObject oppObjUpdate = Database.query('SELECT Id, Name, StageName FROM Opportunity WHERE Name =\'Lord Of The Rings\' LIMIT 1');
        oppObjUpdate.put('StageName','Closed Won');
        update oppObjUpdate;*/
        
		//SObject oppDel = Database.query('SELECT Id, Name FROM Opportunity WHERE Name=\'Lord Of The Rings\' LIMIT 1');
        //delete oppDel;
        
        List<SObject> oppUndelete = Database.query('SELECT Id, Name FROM Opportunity WHERE isDeleted=true ALL ROWS');
      //List<SObject> oppUndelete = Database.query('SELECT Id, Name, StageName FROM Opportunity WHERE isDeleted=true ALL ROWS');
        
     	undelete oppUndelete;
    }
}