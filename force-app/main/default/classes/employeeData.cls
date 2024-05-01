public class employeeData {
    
    public string name;
    public integer id;   

    public address addObj;
    
    public employeeData(String name , integer id , string strt , string city , integer cd , string ste , string ctry){
        
        this.name = name;
        this.id = id;

        addObj = new address();
        
        addObj.street = strt;
        addObj.city = city;
        addObj.code = cd;
        addObj.state = ste;
        addObj.country = ctry;
    }
}


/*

List<employeeData> lstEmpData = new List<employeeData>();


employeeData obj = new employeeData('shubh' , 123 , 'c mala' , 'kpur',415409 , 'mh' , 'In');
employeeData obj2 = new employeeData('shubh2' , 123 , 'c mala' , 'kpur',415409 , 'mh' , 'In');
employeeData obj3 = new employeeData('shubh3' , 123 , 'c mala' , 'kpur',415409 , 'mh' , 'In');
employeeData obj4 = new employeeData('shubh4' , 123 , 'c mala' , 'kpur',415409 , 'mh' , 'In');
employeeData obj5 = new employeeData('shubh6' , 123 , 'c mala' , 'kpur',415409 , 'mh' , 'In');

lstEmpData.add(obj);
lstEmpData.add(obj2);
lstEmpData.add(obj3);
lstEmpData.add(obj4);
lstEmpData.add(obj5);

for(employeeData each : lstEmpData){
system.debug('each emp data '+each);
system.debug('each emp address '+each.addObj);

}

*/