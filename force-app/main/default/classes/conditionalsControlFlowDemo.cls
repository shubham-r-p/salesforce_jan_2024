public class conditionalsControlFlowDemo {
    
    public static void switchWhenDemo(String weekDay){
        
        String day = weekDay;
        
        switch on day {
            when 'monday','tuesday','wednesday','thursday','friday' {
                System.debug('Go to office. Its a working day !');
            }	
            when 'saturday' {
                System.debug('Go to party. Its a weekend !');
            }
            when else {		  
                System.debug('Go to movie. Its sunday !');
            }
        }        
    }
    
    public static void ifElseDemo(Integer inputYear){
        
        Integer year = inputYear;
        
        //check if year is divisible by 4
        if(Math.mod(year, 4) == 0){
            System.debug('inside 1 !');
            //check if year is divisible by 100
            if(Math.mod(year, 100) == 0){
                System.debug('inside 2 !');
                //check if year is divisible by 400
                if(Math.mod(year, 400) == 0){
                    System.debug('inside 3 !');
                    System.debug(year+' is a leap year !');
                }
                else{
                    System.debug(year+' is not a leap year !');
                }
            }
            else{
                System.debug(year+' is not a leap year !');
            }
        }
        else{
            System.debug(year+' is not a leap year !');
        }
    }
    
    
}