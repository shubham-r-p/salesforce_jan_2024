public class dynamicSoqlPrac {
    
    
    public static void firstMethod(){
        
        Map<String,Schema.SObjectType> lstSobjects = Schema.getGlobalDescribe();
        
   //     System.debug('get Glob des map --> '+lstSobjects);
   //     
                    integer i=1;

        
        for(String eachString : lstSobjects.keyset()){
            
            
            system.debug('key  --> '+eachString + '   value --> '+ lstSobjects.get(eachString)) ;
            
                

            
            if(i == 11)
                break;
            
        }
    }

}