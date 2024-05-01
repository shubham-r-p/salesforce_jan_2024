@isTest
public class Covid19Test {
    
    @isTest
    public static void treatPatientTest(){
        
        Covid19 obj = new Covid19(1);
        
        obj.treatPatient();
        
        System.assertEquals(2, obj.recoveredInArea);
        
        obj.getTreated();
        
        System.assertEquals(2, obj.getTreated());
        
       // Assert.areEqual(expected, actual)
    }
    
}