public class futureMethodDemo implements Queueable {
    
    public futureMethodDemo(){
        taskOne();
        taskTwo();
        taskThree();
        taskFour();
    }
    
    public void execute(QueueableContext qc){
        system.debug('Queueable');
    }
    
    public void taskOne(){
        system.debug('Task1');
    }    
    public void taskTwo(){
        system.debug('Task2');
    }    
    
    @future
    public static void taskThree(){
        system.debug('Task3');
    }    
    
    public void taskFour(){
        system.debug('Task4');
    }
    
}