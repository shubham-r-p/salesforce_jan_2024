public with sharing class closeCasesWrappClassDemo {


    @AuraEnabled(cacheable=true)
    public static List<wrapperClass> returnCases(){
        try {

            List<wrapperClass> lstWrapCaseCheckBox = new List<wrapperClass>();

            for(Case eachCase : [SELECT Id ,CaseNumber , Subject , Status FROM Case WHERE Status!='Closed' LIMIT 5]){

                wrapperClass objWrap = new wrapperClass(eachCase);

                lstWrapCaseCheckBox.add(objWrap);                
            }
            System.debug(lstWrapCaseCheckBox);
            return lstWrapCaseCheckBox;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static void closeSelectedCases(String lstSelectedCases){
        try {

            List<wrapperClass> lstWrapperClass = (List<wrapperClass>)JSON.deserialize(lstSelectedCases , List<wrapperClass>.class);

            List<Case> lstCaseToUp = new List<Case>();

            for(wrapperClass eachWrappClass : lstWrapperClass){

                if(eachWrappClass.isSelected == true){

                    eachWrappClass.caseRecord.Status = 'Closed';

                    lstCaseToUp.add(eachWrappClass.caseRecord);
                }

            }

            if(!lstCaseToUp.isEmpty()){

                update lstCaseToUp;
            }
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }


    public class wrapperClass{

        @AuraEnabled
        Public Case caseRecord{get;set;}
        @AuraEnabled
        Public Boolean isSelected{get;set;}


        public wrapperClass(Case caseRec){

            this.caseRecord = caseRec;
            this.isSelected = false;
        }

    }

}