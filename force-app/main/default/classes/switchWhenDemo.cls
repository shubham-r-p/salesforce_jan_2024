public class switchWhenDemo {
    
    public static void methodOne(){
        String day = 'tuesday'; 
        switch on day{            
            when 'monday','tuesday','wednesday'{
                System.debug('Today is monday/tuesday/wednesday !');
            }
            when 'friday'{
                System.debug('Today is friday !');
            }            
            when 'sunday'{
                System.debug('Today is sunday !');
            } 
            when else{
                System.debug('Today is not defined !');
            }
        }
    }
    
        public static void methodTwo(){
        
        Integer currentHourOfDay = System.now().hour();
        DateTime currentTimeOfDay = System.now();
        System.debug('Time --> '+currentTimeOfDay);
        System.debug('Hour --> '+currentHourOfDay);
        
        switch on currentHourOfDay{            
            when 0,1,2,3,4,5,6,7,8,9,10,11,12{
                System.debug('Good night !');
            }
            when 13{
                System.debug('Good afternoon !');
            }            
            when else{
                System.debug('Time is not defined !');
            }
        }
    }
}