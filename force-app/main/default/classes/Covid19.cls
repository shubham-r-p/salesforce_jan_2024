public class Covid19 {
    
    public Integer recoveredInArea = 0;
    public static Integer recoveredInCountry = 0;
    
    public Covid19(Integer recoveredInArea){
        this.recoveredInArea = recoveredInArea;
        recoveredInCountry += recoveredInArea;
    }
    
    public void treatPatient(){
		recoveredInArea++;
		recoveredInCountry++;
    }
    
    public Integer getTreated(){
        return recoveredInArea;
    }

}