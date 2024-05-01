public class Fitness {
    
    public decimal calculateBMI(Decimal weightInKg,Decimal heightINMeters){
        Decimal bmi = weightInKg/(heightINMeters*heightINMeters);
        return bmi;
    }
    
    public decimal calculatePace(Decimal distanceCovered,Time timeTakenToCover){
        //divided by 60 to convert time in min to hr
        Decimal Speed = distanceCovered/(Integer.valueOf(timeTakenToCover)/60);
        return speed;
    }
    
}