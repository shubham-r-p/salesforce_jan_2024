public with sharing class caseAssignmentCaseHandler {
    
    
    static Id recId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Care Cases.').getRecordTypeId();
    static Integer count=0;
    static Integer counter=0;
    static boolean flag=false;
    static boolean check=false;

    
    public static void doBeforeInsert(List<Case> newCaseLst){
        
        List<Case_Assign__c> caseAssLst = [SELECT Id,Name,exclude_email__c,group_name__c,priority__c FROM Case_Assign__c];

        for(Case eachCase : newCaseLst){
            List<Case_Assign__c> nameFiltered = filterName(eachCase, caseAssLst);
            List<Case_Assign__c> emailFilterd = filterEmail(eachCase, nameFiltered); 
            filterPriority(eachCase, emailFilterd);
        }
    }


    public static  List<Case_Assign__c> filterName(Case newCase,List<Case_Assign__c> caseAssLst){
        
        List<String> lstCaseSubjects = new List<String>();
        
        if(newCase.Subject!=null && newCase.RecordTypeId==recId){
            lstCaseSubjects.add(newCase.Subject);
        }
        
        for(Case_Assign__c eachCaseAss : caseAssLst){
            
            if(newCase.subject.containsIgnoreCase(eachCaseAss.Name)){
                system.debug('in if');
                count++;
                if(eachCaseAss.Name.containsIgnoreCase(eachCaseAss.Name)){
                    system.debug('eachCaseAss.Name-->'+eachCaseAss.Name);
                    counter++;
                    
                    if(count==1){
                        flag=true;
                    }   
                }
            }
        }
        return caseAssLst;
    }

    
    public static List<Case_Assign__c> filterEmail(Case newCase,List<Case_Assign__c> caseAssLst){
        List<String> lstCaseExEmail = new List<String>();
        
        for(Case_Assign__c eachCaseAssign : caseAssLst){

           if(newCase.subject.containsIgnoreCase(eachCaseAssign.Name)){
            
               
                           lstCaseExEmail.addAll(eachCaseAssign.exclude_email__c.split(','));

           /* if(eachCaseAssign.exclude_email__c.containsIgnoreCase(',')){
                
            lstCaseExEmail.add(eachCaseAssign.exclude_email__c);
            }
            else{
                
            lstCaseExEmail.addAll(eachCaseAssign.exclude_email__c.split(','));
            }*/
                 
                
             //   if(eachCaseAss.Name.containsIgnoreCase(eachCaseAss.Name)){
             //     }   
                
                }
        }
        
                system.debug('all excld emails--> '+lstCaseExEmail);
        
        for(String eachExEmail : lstCaseExEmail){
            //system.debug('email2'+ eachExEmail);
            //System.debug('SuppliedEmail11-->'+newCase.SuppliedEmail);
            if(flag==true){
                if(newCase.SuppliedEmail!=null && newCase.SuppliedEmail.equals(eachExEmail)){
                    System.debug('eachExEmail-->'+eachExEmail);
                    System.debug('SuppliedEmail-->'+newCase.SuppliedEmail);
                    check=true;   
                    break;
                }
            }    
        }
        return caseAssLst;
    }
    
    
    public static void filterPriority(Case newCase, List<Case_Assign__c> caseAssLst){
        
        
        system.debug('in ');
        List<String> highpriority = new List<String>();
        List<String> mediumpriority = new List<String>();
        List<String> lowpriority = new List<String>();
        
        
        if(check==false){
            system.debug('check-->'+check);
            for(Case_Assign__c eachCaseAss : caseAssLst){
                if(newCase.subject.containsIgnoreCase(eachCaseAss.Name)){
                    if(count==1 && counter==1){
                        system.debug('eachCaseAss.group_name__c-->'+eachCaseAss.group_name__c);
                        newCase.group_name__c=eachCaseAss.group_name__c;
                        break;
                    }
                }
                if(newCase.subject.containsIgnoreCase(eachCaseAss.Name)){
                    if(count>1 || counter==1){
                        if(eachCaseAss.priority__c=='high'){
                            highpriority.add(eachCaseAss.priority__c);
                            //system.debug('highpriority-->'+highpriority);
                        }
                        else if(eachCaseAss.priority__c=='medium'){
                            mediumpriority.add(eachCaseAss.priority__c);
                        }
                        else if(eachCaseAss.priority__c=='low'){
                            lowpriority.add(eachCaseAss.priority__c);
                        }
                    }
                    if(highpriority.size()==0){
                        system.debug('highpriority-->'+highpriority.size());
                        if(mediumpriority.size()==0){
                            system.debug('mediumpriority-->'+mediumpriority.size());
                            if(lowpriority.size()==1){
                                system.debug('lowpriority-->'+lowpriority.size());
                                newCase.group_name__c=eachCaseAss.group_name__c; 
                                system.debug('eachCaseAss.group_name__c-->'+eachCaseAss.group_name__c);
                            }
                        }
                    }
                    else{
                        system.debug('highpriority-->'+highpriority.size());
                        newCase.group_name__c=eachCaseAss.group_name__c; 
                        system.debug('eachCaseAss.group_name__c-->'+eachCaseAss.group_name__c);
                        break;
                    }
                }
            }
        }
    }
    
    
    public static void doBeforeUpdate(List<Case> newCaseLst){
        //CaseTriggerHandler handler = new CaseTriggerHandler();
        doBeforeInsert(newCaseLst);
    }
    
   /* public void doBeforeDelete(List<sObject> oldList, Map<Id,sObject> oldMap){
        
    }
    
    public void doAfterInsert(List<Case> newCaseLst){
        
    }
    public void doAfterUpdate(List<Case> newCaseLst){
        doAfterInsert(newCaseLst);
    }
    
    public void doAfterDelete(List<sObject> oldList, Map<Id,sObject> oldMap){
        
    }
    public void doAfterUndelete(List<sObject> newList, Map<Id,sObject> newMap){
        
    }
    
    private void updateAccountName(List<sObject> newList){
        
    }*/
}
    
    
    
    
    








   /* public static void assignCaseGroupName(List<Case> lstNewCases) {
        
        Set<String> lstCaseSubjects = new Set<String>();
        
        Set<Id> lstCaseAssignIds = new Set<Id>();

        
        for(Case eachCase : lstNewCases){
            
            if(eachCase.Subject != null && eachCase.RecordTypeId == 
               
               Schema.SObjectType.Case.getRecordTypeInfosByName().get('Care Cases.').getRecordTypeId()){
                   
                   
                   for(Case_Assign__c eachCaseAssign : [SELECT Id ,Name FROM Case_Assign__c]){

					if(eachCase.Subject != null && (eachCase.Subject).containsIgnoreCase(eachCaseAssign.Name)){

						lstCaseAssignIds.add(eachCaseAssign.Id);
						}
					}
                   
                   //List<List<Case_Assign__c>> lstOfMatchingRec = [FIND :lstCaseSubjects IN NAME FIELDS
                   //RETURNING Case_Assign__c(Name)];

                   /*List<String> lstNames = eachCase.Subject.split(' ');
                   
                   for(String eachName : lstNames){
                       
                       lstCaseSubjects.add('%'+eachName+'%');
                   }*/
             //  }
       // }
        
       // List<Case_Assign__c> lstMatchingCaseAssignRec = 
        //    [SELECT Id, Name, Group_Name__c, Priority__c, Exclude_Email__c FROM Case_Assign__c WHERE Name LIKE : lstCaseSubjects];
        
       /*   [SELECT Id, Name, Group_Name__c, Priority__c, Exclude_Email__c FROM Case_Assign__c WHERE Id IN : lstCaseAssignIds];
        
        
        system.debug('lstMatchingCaseAssignRec size--> '+lstMatchingCaseAssignRec.size());
        
        
        for(Case_Assign__c eachCa : lstMatchingCaseAssignRec){
            system.debug(eachCa);
        }
        
        
        List<String> lstExcldEmails = new List<String>();
        
        
        for(Case_Assign__c eachCaseAssig : lstMatchingCaseAssignRec){
            
            if(eachCaseAssig.Exclude_Email__c != null){
                
                lstExcldEmails.addAll(eachCaseAssig.Exclude_Email__c.split(','));
            }
        }
        
        system.debug('lstmails--> '+lstExcldEmails);
        
        
        
        if(lstMatchingCaseAssignRec.size() == 1){
            
            for(Case eachCase : lstNewCases){
                
                for(Case_Assign__c eachCaseAssign : lstMatchingCaseAssignRec){
                    
                    for(String eachExcldEmail : lstExcldEmails){
                        
                        if(eachCase.SuppliedEmail != eachExcldEmail || eachCase.SuppliedEmail == null){
                            
                            eachCase.Group_Name__c = eachCaseAssign.Group_Name__c;
                        }
                    }
                }
            }
        }
        else{            
                                            system.debug('inside else');
            
            for(Case eachCase : lstNewCases){
                
                for(Case_Assign__c eachCaseAssign : lstMatchingCaseAssignRec){
                            Boolean br = false;            
                        
                        if(!lstExcldEmails.contains(eachCase.SuppliedEmail) || eachCase.SuppliedEmail == null){
                            
                                system.debug('inside excld mail');
                            
                            if(eachCaseAssign.Priority__c == 'High'){
                                
                                system.debug('inside high');
                                
                                eachCase.Group_Name__c = eachCaseAssign.Group_Name__c;
                                br = true;
                                break;
                            }
                            
                            else if(eachCaseAssign.Priority__c == 'Medium'){
                                
                                system.debug('inside medium');
                                
                                eachCase.Group_Name__c = eachCaseAssign.Group_Name__c;
                            }
                            
                            else{
                                
                                system.debug('inside low');
                                
                                eachCase.Group_Name__c = eachCaseAssign.Group_Name__c;
                            }                             
                                             
                    }
                    if(br) break;
                }
            }
        }
        
    }*/
        

   /* public static void assignCaseGroupNameUpdate(List<Case> lstNewCases) {

        List<String> lstCaseSubjects = new List<String>();

        for(Case eachCase : lstNewCases){

            if(eachCase.Subject != null && eachCase.RecordTypeId == '0125i000000MXcZAAW'){
            lstCaseSubjects.add(eachCase.Subject);
            }
        }

        List<Case_Assign__c> lstMatchingCaseAssignRec = 
[SELECT Id, Name, Group_Name__c, Priority__c, Exclude_Email__c FROM Case_Assign__c WHERE Name IN : lstCaseSubjects];

        List<String> lstExcldEmails = new List<String>();



        for(Case_Assign__c eachCaseAssig : lstMatchingCaseAssignRec){

            if(eachCaseAssig.Exclude_Email__c != null){

                lstExcldEmails.addAll(eachCaseAssig.Exclude_Email__c.split(','));
            }
        }

        if(lstMatchingCaseAssignRec.size() == 1){

            for(Case eachCase : lstNewCases){

                for(Case_Assign__c eachCaseAssign : lstMatchingCaseAssignRec){


                    if(eachCase.ContactEmail != null || eachCase.SuppliedEmail != null){

                        for(String eachExcldEmail : lstExcldEmails){

                            if(eachExcldEmail != null && 
(eachCase.ContactEmail == eachExcldEmail || eachCase.SuppliedEmail == eachExcldEmail)){

                                //~no changes~
                            }
                        }
                    }
                    else{

                        eachCase.Group_Name__c = eachCaseAssign.Group_Name__c;
                    }
                }

                    //eachCase.Group_Name__c = eachCaseAssign.Group_Name__c;
                
            }
        }
        else {
            
            for(Case eachCase : lstNewCases){

                for(Case_Assign__c eachCaseAssign : lstMatchingCaseAssignRec){



                    for(String eachExcldEmail : lstExcldEmails){

                       // if(eachExcldEmail != null && (eachCase.ContactEmail == eachExcldEmail || eachCase.SuppliedEmail == eachExcldEmail)){

                            //~no changes~
                        }
                    }
                }
                else{

                    //eachCase.Group_Name__c = eachCaseAssign.Group_Name__c;

                    if(eachCaseAssign.Priority__c == 'High'){

                        eachCase.Group_Name__c = eachCaseAssign.Group_Name__c;
                    }

                    else if(eachCaseAssign.Priority__c == 'Medium'){

                    eachCase.Group_Name__c = eachCaseAssign.Group_Name__c;
                    }

                    else{

                        eachCase.Group_Name__c = eachCaseAssign.Group_Name__c;
                    }

                }

            }
        }
    }*/

 //   }

/*

List<Case> caseL = new List<Case>();
caseL.add(new Case(Subject = 'jay k', SuppliedEmail = 'test@gmail.com', Origin = 'Phone'));
caseL.add(new Case(Subject = 'Shubham Patil', SuppliedEmail = 'test@gmail.com', Origin = 'Phone'));
insert caseL;
System.debug(caseL);*/