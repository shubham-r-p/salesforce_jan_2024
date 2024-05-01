public class loopsDemo {
    
    public static void doWhileLoopDemo(Integer inputYear){
        Integer year = inputYear;
        do {
            System.debug('Processing year --> '+year);
            
            if(Math.mod(year, 4) == 0){
                //check if year is divisible by 100
                if(Math.mod(year, 100) == 0){
                    //check if year is divisible by 400
                    if(Math.mod(year, 400) == 0){
                        System.debug('---');
                        System.debug(year+' is a leap year ! \n ---');
                    }
                    else{
                    }
                }
                else{
                    System.debug(year+' is a leap year Else ! \n ---');
                }
            }
            else{
            }         
            year++;
        }
        while (year <= inputYear+100);        
    }
    
    public static void doWhileLoopChallenge(Integer num){
        
        Integer inputNum = num;
        
        do{
            if(Math.mod(inputNum, 3) == 0 && Math.mod(inputNum, 5) == 0){
                System.debug('fizzbuzz');
            }
            else if(Math.mod(inputNum, 3) == 0){
                System.debug('fizz');
            }            
            else if(Math.mod(inputNum, 5) == 0){
                System.debug('buzz');
            }  
            else{
                System.debug(inputNum);
            }    
            inputNum++;
        }
        while(inputNum <= num+100);
    }
    
    public static void whileLoopDemo(Integer inputYear){
        
        Integer year = inputYear;
        
        while(year <= inputYear+25){
            
            if(Math.mod(year, 4) == 0){
                //check if year is divisible by 100
                if(Math.mod(year, 100) == 0){
                    //check if year is divisible by 400
                    if(Math.mod(year, 400) == 0){
                        System.debug('---');
                        System.debug(year+' is a leap year ! \n ---');
                    }
                    else{
                    }
                }
                else{
                    System.debug(year+' is a leap year Else ! \n ---');
                }
            }
            else{
            }         
            year++;            
        }
        System.debug('year after while loop --> '+year);
    }
    
    public static void whileLoopChallenge(Integer num){
        Integer start = 1;
        
        Integer previousNum = 1;
        Integer beforePreNum = 0;
        Integer current;
        
        while(start <= num){
            
            current = previousNum + beforePreNum;
            
            System.debug(previousNum);
            beforePreNum = previousNum;
            previousNum = current;
            start++;
        }     
    }
    
    public static void forLoopDemo(Integer year,Integer span){
        
        Integer constYear = year+span;
        
        for(;year<=constYear;year++){
            
            if(Math.mod(year, 4) == 0){
                //check if year is divisible by 100
                if(Math.mod(year, 100) == 0){
                    //check if year is divisible by 400
                    if(Math.mod(year, 400) == 0){
                        System.debug('---');
                        System.debug(year+' is a leap year ! \n ---');
                    }
                    else{
                    }
                }
                else{
                    System.debug(year+' is a leap year Else ! \n ---');
                }
            }
            else{
            }         
        }
        System.debug('year after while loop --> '+year);
    }
    
    public static void foeLoopChallenge(Integer inputPattern){
        
        Integer pattern = inputPattern;
        
        /*String star = '*';
        
        for(integer i=0;i<pattern;i++){
            
            System.debug(star);
            star += ' *';
        }*/
        
        for(integer row=1;row<=pattern;row++){
            String star = '';
            System.debug(star);
            System.debug(row);
            for(integer column=1;column<=row;column++){
                System.debug(column);
                star += '* ';
            }
            System.debug(star);
        }
    }
    
    public static void breakStatemmentDemo(Integer breakAt){
        
        for(integer i=1;i<1000;i++){
            System.debug(i);
            if(i == breakAt){
                System.debug('<--break-->');   
                break;
            }
        }
    }
    
    public static void continueStatementDeom(String weekDay){
        
        List<String> allWeekDays = new List<String>{'Monday','Tuesday','Wednesday',
            										'Thursday','Friday','Saturday','Sunday'};
        
        for(integer i=0;i<allWeekDays.size();i++){
            
            if(weekDay.toLowerCase() == allWeekDays[i].toLowerCase()){
          	System.debug('Its '+allWeekDays[i]+' I will not eat chicken today !');
 				continue;
            }
           	System.debug(' Its '+allWeekDays[i]+' I can eat chicken today !');
        }
    }
    
}