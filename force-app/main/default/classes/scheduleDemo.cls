public class scheduleDemo implements Schedulable {
    
    
    public void execute(SchedulableContext qc){
        Database.executeBatch(new batchDemo() , 10);
    }
}