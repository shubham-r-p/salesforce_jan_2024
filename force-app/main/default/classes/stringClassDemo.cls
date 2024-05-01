public class stringClassDemo {
    
    public static void stringClassDemoMethod(){
        
        String name = 'shubham Patil';
        System.debug('name --> '+name);
        
        //capitalize
        System.debug('name after capitalize --> '+name.capitalize());
        
        //contains
        System.debug('name contains patil ?--> '+name.contains('patil'));
        System.debug('name contains pat il ?--> '+name.contains('pat il'));
        
        //toUpperCase & toLowerCase
        System.debug('name in upperCase --> '+name.toUpperCase());
        System.debug('name in lowerCase --> '+name.toLowerCase());
        
        //equals
        String fNameOne = 'Shubham';
        String fNameTwo = 'shuBhaM';
        System.debug('fNameOne equals fNameTwo --> '+fNameOne.equals(fNameTwo));
        System.debug('fNameOne equals fNameTwo with lowerCase --> '+fNameOne.toLowerCase().equals(fNameTwo.toLowerCase()));
        
        //index of
        System.debug('indexOf --> '+name.indexOf('s'));
        
        //length
        System.debug('length --> '+fNameOne.length());
        
        //remove
        System.debug('remove --> '+fNameTwo.remove('haM'));
        
        //replace
        System.debug('replace --> '+fNameTwo.replace('shuBhaM', 'shuBham'));
        
        //split
        System.debug('split --> '+name.split(' '));
        
        //trim
        String trimDemo = '  Shubham Patil   ';
        System.debug('without trim -->'+trimDemo);
        System.debug('trim -->'+trimDemo.trim()+'### without trim -->'+trimDemo);
        
        //valueOf to convert any data type to string
        Integer empId = 12345;
        System.debug('Integer to string --> '+String.valueOf(empId));
        System.debug('DateTime to string --> '+String.valueOf(System.now()));
        System.debug('DateTime --> '+System.now());
        
        //isBlank & isEmpty
        String testOne;
        String testTwo = '';
        String testThree = ' ';
        System.debug('testOne --> '+String.isBlank(testOne)+' | testTwo --> '+String.isBlank(testTwo)+
                     ' | testThree --> '+String.isBlank(testThree));
        System.debug('testOne --> '+String.isEmpty(testOne)+' | testTwo --> '+String.isEmpty(testTwo)+
                     ' | testThree --> '+String.isEmpty(testThree));        
        
        //isNumeric
        String num = '18';
        String numTwo = 'virat18';
        System.debug('isNumeric num --> '+num.isNumeric());
        System.debug('isNumeric numTwo --> '+numTwo.isNumeric());
        
        //using Escape characters in string
        String demoString = 'Im doing \"SFDFFacts academy course\". \n Here I learn about Salesforce';
        system.debug('demoString --> '+demoString);
        
        /*
List<String> aprxPosts = new List<String>
{'apex is st lang','it follows oops'};


Map<String,List<String>> mapCategoryPosts = new Map<String,List<String>>
{'Apex'=>aprxPosts};

System.debug('mapCategoryPosts --> '+mapCategoryPosts);

List<String> adminPosts =new List<String>
{'Admin is part follows declaritive approach'
,'Its main features are flows and security'};

mapCategoryPosts.put('Admin',adminPosts);

System.debug('mapCategoryPosts --> '+mapCategoryPosts);
*/
        
    }
}