@isTest
public class FitnessTest {
    
	@isTest
    public static void calculateBMITest(){
        
        Fitness obj = new Fitness();
        
        Assert.areEqual(4.25, obj.calculateBMI(68, 4));
        
      //  Assert.areEqual(4.25, obj.calculatePace(5, Time.newInstance(1, 25, 0, 0)));
    }

}