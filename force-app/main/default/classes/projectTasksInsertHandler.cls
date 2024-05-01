public class projectTasksInsertHandler{
    
    public static void insertProjectTasksAfterProject(List<Project__c> lstNewProjectRec){
        
        
        List<String> lstAllTypes = new List<String>{'New Task', 'Planning Phase', 'Construction Work', 'Completion Step' ,'Contract End'};
        
        List<Project_task__C> lstNewProTasks = new List<Project_task__C>();
            
        for(Project__c eachProject : lstNewProjectRec){
        for(integer i=0 ; i<5 ; i++){
            
            Project_task__C objProTask = new Project_task__C();
            objProTask.Type__c = lstAllTypes[i];
            objProTask.Project__c = eachProject.Id;
            lstNewProTasks.add(objProTask);
        }
        }
        insert lstNewProTasks;
        
        system.debug('lstAllTasks--> '+lstNewProTasks);
		        
        for(integer i=1 ; i<lstNewProTasks.size() ; i++){       
            //for(Project_task__C eachProjectTask : lstNewProTasks){
                Project_task__c eachProjectTask = lstNewProTasks[i];
                if(eachProjectTask.Type__c != 'New Task'){
                    
                    system.debug('--> '+eachProjectTask);
                    eachProjectTask.Project_Task__c =  lstNewProTasks[i-1].Id;   
                }
            //}
        }
        
        

        
        
        update lstNewProTasks;
        
        
        
        
        
        
        
        /*for(integer i=1 ; i<lstNewProTasks.size()-1 ; i++){                       
                if(lstNewProTasks[i].Type__c != 'New Task'){                    
                    lstNewProTasks[i].Project_Task__c =  lstNewProTasks[i-1].Id;   
                }
        }*/        
        
        
        
        
        
        
        
        
       /* Map<Id , List<Project_Task__C>> mapProjectTask = new Map<Id , List<Project_Task__C>>();
        
        Map<Id, Project_Task__c> mapProTaskId = new Map<Id, Project_Task__c>();
        //Map<Project_Task__c, Id> mapProTaskId = new Map<Project_Task__c, Id>();
        
        
        for(Project__c eachPro : lstNewProjectRec){
            
            //List<Project_task__c> tempList = getchildTasks(eachPro.Id);
            //mapProjectTask.put(eachProTask.Id, tempList);
            
            for(Project_task__c eachProTask : getchildTasks(eachPro.Id)){
                
                if(eachProTask.Type__c == 'Planning Phase'){
                    
                    mapProTaskId.put(eachProTask.Id , eachProTask);                    
                }
                else if(eachProTask.Type__c == 'Construction Work'){
                    
                    mapProTaskId.put(eachProTask.Id , eachProTask);                    
                }
                else if(eachProTask.Type__c == 'Completion Step'){
                    
                    mapProTaskId.put(eachProTask.Id , eachProTask);                    
                }
                else if(eachProTask.Type__c == 'Contract End'){
                    
                    mapProTaskId.put(eachProTask.Id , eachProTask);                    
                }
                //mapProTaskId.put(eachProTask , eachProTask.Id);
                mapProjectTask.put(eachPro.Id , getchildTasks(eachPro.Id));
            }
            
        }*/
        
        
        
        /*for(integer i=0 ; i<5 ; i++){
            
            

            
            
            
            
            
        }*/
        
        
        
        
        
        
        
        
        
        
        
       /* List<Project_Task__C> lstProjectTaskToUp = new List<Project_Task__C>();
        
        
        for(Project__c eachProject : lstNewProjectRec){
            
            for(Project_Task__C eachProTask : mapProjectTask.get(eachProject.Id)){
                
                for(Project_Task__C eachProTaskFromMap : mapProTaskId.values()){
                    
                    if(eachProTask.Type__c != 'New Task'){
                        
                        eachProTask.Project_Task__c = eachProTaskFromMap.Id;
                        lstProjectTaskToUp.add(eachProTask);
                    }
                }*/
                
              
        /*Project_Task__C newTaskObj;
Project_Task__C planningPhaseObj;
Project_Task__C constructioWorknewTaskObj;
Project_Task__C completionStepnewTaskObj;
Project_Task__C contractEndnewTaskObj;*/                
             
                /*if(eachProTask.Type__c == 'New Task'){

newTaskObj = mapProjectTask.get(eachProTask.Id);
}
else if(eachProTask.Type__c == 'Planning Phase'){

planningPhaseObj = mapProjectTask.get(eachProTask.Id);
}
else if(eachProTask.Type__c == 'Construction Work'){

constructioWorknewTaskObj = mapProjectTask.get(eachProTask.Id);
}
else if(eachProTask.Type__c == 'Completion Step'){

completionStepnewTaskObj = mapProjectTask.get(eachProTask.Id);
}
else if(eachProTask.Type__c == 'Contract End'){

contractEndnewTaskObj = mapProjectTask.get(eachProTask.Id);
}
                
            }      
        }*/
        
                //UPDATE lstProjectTaskToUp;
        
        
       // List<Project_Task__C> lstProjectTaskToUp = new List<Project_Task__C>();
        
        /*planningPhaseObj.Project_Task__c = newTaskObj.Id;
lstProjectTaskToUp.add(planningPhaseObj);

constructioWorknewTaskObj.Project_Task__c = planningPhaseObj.Id;
lstProjectTaskToUp.add(constructioWorknewTaskObj);

completionStepnewTaskObj.Project_Task__c = constructioWorknewTaskObj.Id;
lstProjectTaskToUp.add(completionStepnewTaskObj);

contractEndnewTaskObj.Project_Task__c = completionStepnewTaskObj.Id;
lstProjectTaskToUp.add(contractEndnewTaskObj);*/
                
    }
    
    
   /* public static List<Project_task__C> getChildTasks(Id projectId){
        
        List<Project_Task__C> lstProjectTask = new List<Project_Task__c>();
        
        Project_Task__C projecTaskOne = new Project_Task__C();
        projecTaskOne.Type__c = 'New Task';
        projecTaskOne.Project__c = projectId;
        lstProjectTask.add(projecTaskOne);
        
        Project_Task__C projecTaskOneTwo= new Project_Task__C();
        projecTaskOneTwo.Type__c = 'Planning Phase';
        projecTaskOneTwo.Project__c = projectId;
        lstProjectTask.add(projecTaskOneTwo);
        
        Project_Task__C projecTaskThree = new Project_Task__C();
        projecTaskThree.Type__c = 'Construction Work';
        projecTaskThree.Project__c = projectId;
        lstProjectTask.add(projecTaskThree);
        
        Project_Task__C projecTaskFour = new Project_Task__C();
        projecTaskFour.Type__c = 'Completion Step';
        projecTaskFour.Project__c = projectId;
        lstProjectTask.add(projecTaskFour);
        
        Project_Task__C projecTaskFive = new Project_Task__C();
        projecTaskFive.Type__c = 'Contract End';
        projecTaskFive.Project__c = projectId;
        lstProjectTask.add(projecTaskFive);
        
        INSERT lstProjectTask;
        
        return lstProjectTask;
    }
    */
    
}