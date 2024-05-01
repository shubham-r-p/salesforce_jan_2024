public class ternaryOperatorChallenge {
    
    public static void methodOne(){
        final integer one_slice = 8;
        final integer upto_three_slices = 7;
        final integer more_than_four = 6;
        
        integer a = 3;
        integer b = 1;
        integer c = 4;
        
        integer moneyA = a == 1 ? one_slice*a : a <= 3 ? upto_three_slices*a : more_than_four*a;
        System.debug('Money for a --> '+moneyA);
        
        integer moneyB = b == 1 ? one_slice*b : b <= 3 ? upto_three_slices*b : more_than_four*b;
        System.debug('Money for b --> '+moneyB);
        
        integer moneyC = c == 1 ? one_slice*c : c <= 3 ? upto_three_slices*c : more_than_four*c;
        System.debug('Money for c --> '+moneyC);
        
        System.debug('Total bill --> '+(moneyC+moneyB+moneyA));   
    }
}